@echo off
setlocal


REM Everything below this line should be able to remain untouched
SET "SRC_DIR=%~dp0src"


SET "DLL_SRC=.\plugin\sl-triggers\build\release-msvc\sl-triggers.dll"
SET "SRC_DLL_DIR=%SRC_DIR%\SKSE\Plugins\"
ECHO Copy sll-triggers.dll to %SRC_DIR%
XCOPY /i /y "%DLL_SRC%" "%SRC_DLL_DIR%"

:: Check for exactly one argument
if "%~1"=="" (
    echo Usage: %~nx0 ^<integer-version-number^>
    exit /b 1
)

:: Assign the argument
set "INPUT=%~1"

:: Check if INPUT is numeric using string parsing
set "VERNO="
for /f "delims=0123456789" %%A in ("%INPUT%") do (
    echo Error: Argument must be a valid integer.
    exit /b 1
)
set "VERNO=%INPUT%"

:: Confirm assignment
echo VERNO is set to %VERNO%

set "THEZIP=%~dp0sl_triggers%VERNO%.zip"

del /f %THEZIP%

pushd src
powershell -Command "Compress-Archive -Path '%SRC_DIR%\*' -DestinationPath '%THEZIP%'"
popd

endlocal

