#include <windows.h>
#include <iostream>
#include <string>
#include <vector>
#include <thread>

#include "caprunner.h"

namespace SLT {

std::string ReadFromPipe(HANDLE hPipe) {
    std::string result;
    DWORD dwRead;
    char chBuf[4096];
    
    while (true) {
        BOOL bSuccess = ReadFile(hPipe, chBuf, sizeof(chBuf) - 1, &dwRead, NULL);
        if (!bSuccess || dwRead == 0) {
            break;
        }
        
        chBuf[dwRead] = '\0';
        result += chBuf;
    }
    
    return result;
}

bool RunCapricaForScripts() {
    auto capexe = GetCapricaExe();
    if (!fs::exists(capexe) || !fs::is_regular_file(capexe)) {
        logger::warn("RunCapricaForScripts: Unable to locate caprica.exe at ({})", capexe.string());
        return false;
    }
    auto pstr = GetCapricaExe().string();
    std::string commandLine = std::format("{} . --game=skyrim --flags=..\\caprica\\TESV_Papyrus_Flags.flg --output=..\\..\\..\\..\\scripts --import=..\\peximport --quiet --ignorecwd --champollion-compat", GetCapricaExe().string());
    std::string workingDirectory = fs::absolute(GetCapricaWorkingDir()).string();

    logger::info("RunCapricaForScripts: starting in folder ({}):\n\t{}", workingDirectory, commandLine);
    
    SECURITY_ATTRIBUTES saAttr = {};
    saAttr.nLength = sizeof(SECURITY_ATTRIBUTES);
    saAttr.bInheritHandle = TRUE;
    saAttr.lpSecurityDescriptor = NULL;
    
    // Create pipes for stdout and stderr
    HANDLE hChildStdOutRead, hChildStdOutWrite;
    HANDLE hChildStdErrRead, hChildStdErrWrite;
    
    if (!CreatePipe(&hChildStdOutRead, &hChildStdOutWrite, &saAttr, 0)) {
        logger::error("[ERROR] Failed to create stdout pipe");
        return false;
    }
    
    if (!CreatePipe(&hChildStdErrRead, &hChildStdErrWrite, &saAttr, 0)) {
        logger::error("[ERROR] Failed to create stderr pipe");
        CloseHandle(hChildStdOutRead);
        CloseHandle(hChildStdOutWrite);
        return false;
    }
    
    // Ensure the read handles are not inherited
    SetHandleInformation(hChildStdOutRead, HANDLE_FLAG_INHERIT, 0);
    SetHandleInformation(hChildStdErrRead, HANDLE_FLAG_INHERIT, 0);
    
    STARTUPINFOA startupInfo = {};
    PROCESS_INFORMATION processInfo = {};
    
    startupInfo.cb = sizeof(startupInfo);
    startupInfo.hStdError = hChildStdErrWrite;
    startupInfo.hStdOutput = hChildStdOutWrite;
    startupInfo.hStdInput = GetStdHandle(STD_INPUT_HANDLE);
    startupInfo.dwFlags |= STARTF_USESTDHANDLES;
    
    // Create the process
    BOOL success = CreateProcessA(
        nullptr,                        // lpApplicationName (use command line instead)
        &commandLine[0],               // lpCommandLine (modifiable string)
        nullptr,                        // lpProcessAttributes
        nullptr,                        // lpThreadAttributes
        TRUE,                           // bInheritHandles (TRUE to inherit pipe handles)
        CREATE_NO_WINDOW,               // dwCreationFlags
        nullptr,                        // lpEnvironment
        workingDirectory.c_str(),      // lpCurrentDirectory
        &startupInfo,                  // lpStartupInfo
        &processInfo                   // lpProcessInformation
    );
    
    if (!success) {
        DWORD error = GetLastError();
        logger::error("[ERROR] Failed to start caprica.exe. Error code: {}",error);
        
        // Clean up pipes
        CloseHandle(hChildStdOutRead);
        CloseHandle(hChildStdOutWrite);
        CloseHandle(hChildStdErrRead);
        CloseHandle(hChildStdErrWrite);
        return false;
    }
    
    logger::info("[INFO] Started caprica.exe in directory: {}", workingDirectory);
    
    // Close the write ends of the pipes so ReadFile will know when the child process ends
    CloseHandle(hChildStdOutWrite);
    CloseHandle(hChildStdErrWrite);
    
    // Start background thread to handle process monitoring and cleanup
    // Capture all necessary handles and data by value
    std::thread([processInfo, hChildStdOutRead, hChildStdErrRead]() {
        // Wait for the process to complete
        DWORD waitResult = WaitForSingleObject(processInfo.hProcess, INFINITE);
        
        if (waitResult != WAIT_OBJECT_0) {
            logger::error("[ERROR] Failed to wait for caprica.exe completion. Wait result: {}", waitResult);
            CloseHandle(processInfo.hProcess);
            CloseHandle(processInfo.hThread);
            CloseHandle(hChildStdOutRead);
            CloseHandle(hChildStdErrRead);
            return;
        }
        
        // Read output from the child process
        std::string stdoutOutput = ReadFromPipe(hChildStdOutRead);
        std::string stderrOutput = ReadFromPipe(hChildStdErrRead);
        
        // Get the exit code
        DWORD exitCode = 0;
        if (!GetExitCodeProcess(processInfo.hProcess, &exitCode)) {
            logger::error("[ERROR] Failed to get exit code from caprica.exe");
            CloseHandle(processInfo.hProcess);
            CloseHandle(processInfo.hThread);
            CloseHandle(hChildStdOutRead);
            CloseHandle(hChildStdErrRead);
            return;
        }
        
        // Clean up handles
        CloseHandle(processInfo.hProcess);
        CloseHandle(processInfo.hThread);
        CloseHandle(hChildStdOutRead);
        CloseHandle(hChildStdErrRead);
        
        // Output captured content
        if (!stdoutOutput.empty()) {
            logger::info("[STDOUT] caprica.exe output:");
            logger::info("{}", stdoutOutput);
        }
        
        if (!stderrOutput.empty()) {
            logger::error("[STDERR] caprica.exe error output:");
            logger::error("{}", stderrOutput);
        }
        
        if (exitCode == 0) {
            logger::info("[SUCCESS] caprica.exe completed successfully (exit code: 0)");

            auto outdir = GetCapricaWorkingDir();
            if (fs::exists(outdir) && fs::is_directory(outdir)) {
                auto* vm = RE::BSScript::Internal::VirtualMachine::GetSingleton();
                try {
                    for (const auto& entry : fs::directory_iterator(outdir)) {
                        if (entry.is_regular_file() && entry.path().extension() == ".psc") {
                            logger::info("Attempting to reload VM script ({})", entry.path().stem().string());
                            if (vm->ReloadType(entry.path().stem().string().c_str())) {
                                logger::info("Successfully reloaded script ({})", entry.path().stem().string());
                            } else {
                                logger::error("Failed to reload script ({})", entry.path().stem().string());
                            }
                            RE::BSTSmartPointer<RE::BSScript::ObjectTypeInfo> objTypeInfo;
                            RE::BSFixedString bsfsScriptName(entry.path().stem().string());
                            if (vm->GetScriptObjectType(bsfsScriptName, objTypeInfo)) {
                                logger::info("Successfully fetched script object type info for ({}) / ({})", entry.path().stem().string(), objTypeInfo->GetName());
                            } else {
                                logger::error("Failed to fetch script object type info for ({})", entry.path().stem().string());
                            }
                        }
                    }
                } catch (const fs::filesystem_error& ex) {
                } catch (const std::exception& ex) {
                }
            }
        } else {
            logger::error("[FAILURE] caprica.exe failed with exit code: {}", exitCode);
        }
    }).detach();
    
    // Return immediately - the process is now running in the background
    logger::info("[INFO] caprica.exe started in background thread");
    return true;
}

}