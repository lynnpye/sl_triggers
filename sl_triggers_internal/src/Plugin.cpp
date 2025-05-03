using namespace SKSE;
using namespace SKSE::log;
using namespace SKSE::stl;

#include "Plugin.h"
#include "GameEventHandler.h"
#include "RE/Skyrim.h"
#include "SKSE/SKSE.h"

#pragma push(warning)
#pragma warning(disable:4100)
namespace plugin {
    namespace Util {

        RE::BSTSmartPointer<RE::BSScript::Object> GetScriptObject_AME(RE::ActiveEffect* ae) {
            auto* vm = RE::BSScript::Internal::VirtualMachine::GetSingleton();
            auto* handlePolicy = vm->GetObjectHandlePolicy();
            auto handle = handlePolicy->GetHandleForObject(ae->VMTYPEID, ae);

            RE::BSFixedString bsScriptName("sl_triggersCmd");

            auto it = vm->attachedScripts.find(handle);
            if (it == vm->attachedScripts.end()) {
                logger::error("{}: vm->attachedScripts couldn't find handle[{}] scriptName[{}]", __func__, handle, bsScriptName.c_str());
                return nullptr;
            }

            for (std::uint32_t i = 0; i < it->second.size(); i++) {
                auto& attachedScript = it->second[i];
                if (attachedScript) {
                    auto* script = attachedScript.get();
                    if (script) {
                        auto info = script->GetTypeInfo();
                        if (info) {
                            if (info->name == bsScriptName) {
                                logger::trace("script[{}] found attached to handle[{}]", bsScriptName.c_str(), handle);
                                RE::BSTSmartPointer<RE::BSScript::Object> result(script);
                                return result;
                            }
                        }
                    }
                }
            }

            return nullptr;
        }

        class VoidCallbackFunctor : public RE::BSScript::IStackCallbackFunctor {
            public:
                explicit VoidCallbackFunctor(std::function<void()> callback)
                    : onDone(std::move(callback)) {}

                void operator()(RE::BSScript::Variable) override {
                    // This is called when the script function finishes
                    if (onDone) {
                        onDone();
                    }
                }

                void SetObject(const RE::BSTSmartPointer<RE::BSScript::Object>&) override {}

            private:
                std::function<void()> onDone;
        };

        /*
        class StringCallbackFunctor : public RE::BSScript::IStackCallbackFunctor {
            public:
                using Callback = std::function<void(RE::BSFixedString)>;

                explicit StringCallbackFunctor(Callback cb)
                    : callback(std::move(cb)) {}

                void operator()(RE::BSScript::Variable a_result) override {
                    RE::BSFixedString result;

                    if (a_result.IsString()) {
                        result = a_result.GetString();
                    }

                    if (callback) {
                        callback(result);
                    }
                }

                void SetObject(const RE::BSTSmartPointer<RE::BSScript::Object>&) override {}

            private:
                Callback callback;
        };

        class ActorCallbackFunctor : public RE::BSScript::IStackCallbackFunctor {
            public:
                std::function<void(RE::Actor*)> onResult;

                explicit ActorCallbackFunctor(std::function<void(RE::Actor*)> callback)
                    : onResult(std::move(callback)) {}

                void operator()(RE::BSScript::Variable a_result) override {
                    if (a_result.IsObject() && a_result.GetObject()) {
                        auto object = a_result.GetObject();
                        auto handle = object->GetHandle();
                        auto* vm = RE::BSScript::Internal::VirtualMachine::GetSingleton();
                        auto* handlePolicy = vm->GetObjectHandlePolicy();
                        if (handlePolicy) {
                            RE::TESForm* formObj = handlePolicy->GetObjectForHandle(RE::Actor::FORMTYPE, handle);
                            if (formObj) {
                                RE::Actor* objResult = static_cast<RE::Actor*>(formObj);
                                onResult(objResult);
                                return;
                            }
                        }
                    }

                    // Failed to resolve, pass null
                    onResult(nullptr);
                }

                void SetObject(const RE::BSTSmartPointer<RE::BSScript::Object>&) override {}
        };

        class BoolCallbackFunctor : public RE::BSScript::IStackCallbackFunctor {
            public:
                using Callback = std::function<void(bool)>;

                explicit BoolCallbackFunctor(Callback cb)
                    : callback(std::move(cb)) {}

                void operator()(RE::BSScript::Variable a_result) override {
                    bool result = false;

                    if (a_result.IsBool()) {
                        result = a_result.GetBool();
                    }

                    if (callback) {
                        callback(result);
                    }
                }

                void SetObject(const RE::BSTSmartPointer<RE::BSScript::Object>&) override {}

            private:
                Callback callback;
        };


        bool CustomResolve(RE::BSFixedString scriptname, RE::Actor* cmdTargetActor,
                                        RE::ActiveEffect* cmdPrimary, RE::BSFixedString code) {
            if (cmdPrimary && cmdTargetActor) {
                RE::BSFixedString slt_SetOperationHandled("_slt_SetCustomResolveReady");
                RE::BSTSmartPointer<RE::BSScript::ObjectTypeInfo> typeinfoptr;
                auto* vm = RE::BSScript::Internal::VirtualMachine::GetSingleton();
                RE::BSFixedString resolveFunction("CustomResolve");
                auto* callbackArgs = RE::MakeFunctionArguments();

                auto resultCallback = RE::BSTSmartPointer<RE::BSScript::IStackCallbackFunctor>(
                    new VoidCallbackFunctor([vm, cmdPrimary, slt_SetOperationHandled, callbackArgs, code]() {
                        SKSE::GetTaskInterface()->AddTask([vm, cmdPrimary, slt_SetOperationHandled, callbackArgs, code]() {
                            auto scrobj = GetScriptObject_AME(cmdPrimary);
                            RE::BSTSmartPointer<RE::BSScript::IStackCallbackFunctor> setterCallback{nullptr};

                            if (scrobj) {
                                //logger::info("CustomResolve: calling '{}'", slt_SetOperationHandled.c_str());
                                //logger::info("CustomResolve: marking ready : {}", code.c_str());
                                bool didit = vm->DispatchMethodCall1(scrobj, slt_SetOperationHandled, callbackArgs, setterCallback);
                               // logger::info("CustomResolve: marked ready  : {}", code.c_str());
                                if (didit) {
                                    //logger::info("Dispatched '{}' to CmdPrimary", slt_SetOperationHandled.c_str());
                                } else {
                                    logger::info("Unable to dispatch '{}' to CmdPrimary", slt_SetOperationHandled.c_str());
                                }
                            } else {
                                logger::info("CustomResolve: Unable to retrieve Script object for cmdPrimary");
                            }
                        });
                    }));

                //logger::info("CustomResolve: fetching typeinfo for '{}'", scriptname.c_str());
                bool gotTypeInfo = vm->GetScriptObjectType1(scriptname, typeinfoptr);

                if (!gotTypeInfo) {
                    logger::error("No type info returned for script '{}'", scriptname.c_str());
                    return false;
                }
                    
                auto* resolveArgs = RE::MakeFunctionArguments(static_cast<RE::Actor*>(cmdTargetActor), static_cast<RE::ActiveEffect*>(cmdPrimary),
                                                    static_cast<RE::BSFixedString>(code));

                int numglobs = typeinfoptr->GetNumGlobalFuncs();
                auto globiter = typeinfoptr->GetGlobalFuncIter();

                for (int i = 0; i < numglobs; i++) {
                    if (resolveFunction == globiter[i].func->GetName()) {
                      //  logger::info("CustomResolve: dispatching : {}", code.c_str());
                        bool resolveCalled = vm->DispatchStaticCall(scriptname, resolveFunction, resolveArgs, resultCallback);
                       // logger::info("CustomResolve: dispatched  : {}", code.c_str());

                        if (!resolveCalled) {
                            logger::error("Unable to call CustomResolve for script '{}'", scriptname.c_str());
                        } else {
                            //logger::info("Dispatched CustomResolve to script '{}'", scriptname.c_str());
                        }

                        return resolveCalled;
                    }
                }
            } else {
                logger::info("CustomResolve: _cmdPrimary or _cmdTargetActor was null");
            }

            return false;
        }

        bool CustomResolveActor(RE::BSFixedString scriptname, RE::Actor* cmdTargetActor, RE::ActiveEffect* cmdPrimary,
                                RE::BSFixedString code) {
            if (cmdPrimary && cmdTargetActor) {
                RE::BSFixedString slt_SetOperationHandled("_slt_SetCustomResolveActorReady");
                RE::BSTSmartPointer<RE::BSScript::ObjectTypeInfo> typeinfoptr;
                auto* vm = RE::BSScript::Internal::VirtualMachine::GetSingleton();
                RE::BSFixedString resolveFunction("CustomResolveActor");
                auto* callbackArgs = RE::MakeFunctionArguments();

                auto resultCallback = RE::BSTSmartPointer<RE::BSScript::IStackCallbackFunctor>(
                    new VoidCallbackFunctor([vm, cmdPrimary, slt_SetOperationHandled, callbackArgs]() {
                        SKSE::GetTaskInterface()->AddTask([vm, cmdPrimary, slt_SetOperationHandled, callbackArgs]() {
                            auto scrobj = GetScriptObject_AME(cmdPrimary);
                            RE::BSTSmartPointer<RE::BSScript::IStackCallbackFunctor> setterCallback{nullptr};

                            if (scrobj) {
                                vm->DispatchMethodCall1(scrobj, slt_SetOperationHandled, callbackArgs, setterCallback);
                            } else {
                                logger::info("CustomResolveActor: Unable to retrieve Script object for cmdPrimary");
                            }
                        });
                    }));

                bool gotTypeInfo = vm->GetScriptObjectType1(scriptname, typeinfoptr);

                if (!gotTypeInfo) {
                    logger::error("No type info returned for script '{}'", scriptname.c_str());
                    return false;
                }

                auto* resolveArgs =
                    RE::MakeFunctionArguments(static_cast<RE::Actor*>(cmdTargetActor), static_cast<RE::ActiveEffect*>(cmdPrimary),
                                              static_cast<RE::BSFixedString>(code));

                int numglobs = typeinfoptr->GetNumGlobalFuncs();
                auto globiter = typeinfoptr->GetGlobalFuncIter();

                for (int i = 0; i < numglobs; i++) {
                    if (resolveFunction == globiter[i].func->GetName()) {
                        bool resolveCalled = vm->DispatchStaticCall(scriptname, resolveFunction, resolveArgs, resultCallback);

                        if (!resolveCalled) {
                            logger::error("Unable to call CustomResolveActor for script '{}'", scriptname.c_str());
                        }

                        return resolveCalled;
                    }
                }
            } else {
                logger::info("CustomResolveActor: _cmdPrimary or _cmdTargetActor was null");
            }

            return false;
        }


        bool CustomResolveCond(RE::BSFixedString scriptname, RE::Actor* cmdTargetActor, RE::ActiveEffect* cmdPrimary, RE::BSFixedString p1,
                               RE::BSFixedString p2, RE::BSFixedString oper) {
            if (cmdPrimary && cmdTargetActor) {
                RE::BSFixedString slt_SetOperationHandled("_slt_SetCustomResolveCondReady");
                RE::BSTSmartPointer<RE::BSScript::ObjectTypeInfo> typeinfoptr;
                auto* vm = RE::BSScript::Internal::VirtualMachine::GetSingleton();
                RE::BSFixedString resolveFunction("CustomResolveCond");
                auto* callbackArgs = RE::MakeFunctionArguments();

                auto resultCallback = RE::BSTSmartPointer<RE::BSScript::IStackCallbackFunctor>(
                    new VoidCallbackFunctor([vm, cmdPrimary, slt_SetOperationHandled, callbackArgs]() {
                        SKSE::GetTaskInterface()->AddTask([vm, cmdPrimary, slt_SetOperationHandled, callbackArgs]() {
                            auto scrobj = GetScriptObject_AME(cmdPrimary);
                            RE::BSTSmartPointer<RE::BSScript::IStackCallbackFunctor> setterCallback{nullptr};

                            if (scrobj) {
                                vm->DispatchMethodCall1(scrobj, slt_SetOperationHandled, callbackArgs, setterCallback);
                            } else {
                                logger::info("CustomResolveCond: Unable to retrieve Script object for cmdPrimary");
                            }
                        });
                    }));

                bool gotTypeInfo = vm->GetScriptObjectType1(scriptname, typeinfoptr);

                if (!gotTypeInfo) {
                    logger::error("No type info returned for script '{}'", scriptname.c_str());
                    return false;
                }

                auto* resolveArgs =
                    RE::MakeFunctionArguments(static_cast<RE::Actor*>(cmdTargetActor), static_cast<RE::ActiveEffect*>(cmdPrimary),
                    static_cast<RE::BSFixedString>(p1), static_cast<RE::BSFixedString>(p2), static_cast<RE::BSFixedString>(oper));

                int numglobs = typeinfoptr->GetNumGlobalFuncs();
                auto globiter = typeinfoptr->GetGlobalFuncIter();

                for (int i = 0; i < numglobs; i++) {
                    if (resolveFunction == globiter[i].func->GetName()) {
                        bool resolveCalled = vm->DispatchStaticCall(scriptname, resolveFunction, resolveArgs, resultCallback);

                        if (!resolveCalled) {
                            logger::error("Unable to call CustomResolveCond for script '{}'", scriptname.c_str());
                        }

                        return resolveCalled;
                    }
                }
            } else {
                logger::info("CustomResolveCond: _cmdPrimary or _cmdTargetActor was null");
            }

            return false;
        }
        */

        bool RunOperationOnActor(std::vector<RE::BSFixedString> _scriptnames, RE::Actor* _cmdTargetActor, RE::ActiveEffect* _cmdPrimary,
                                 std::vector<RE::BSFixedString> _param) {
            bool success = false;

            if (_cmdPrimary && _cmdTargetActor) {
                RE::BSTSmartPointer<RE::BSScript::ObjectTypeInfo> typeinfoptr;
                auto* vm = RE::BSScript::Internal::VirtualMachine::GetSingleton();
                auto* callbackArgs = RE::MakeFunctionArguments();
                auto vmhandle = vm->GetObjectHandlePolicy()->GetHandleForObject(_cmdPrimary->VMTYPEID, _cmdPrimary);
                RE::BSFixedString callbackEvent("OnSetOperationCompleted");

                auto resultCallback = RE::BSTSmartPointer<RE::BSScript::IStackCallbackFunctor>(
                    new VoidCallbackFunctor([vm, vmhandle, callbackEvent, _cmdPrimary, callbackArgs]() {
                        SKSE::GetTaskInterface()->AddTask(
                            [vm, vmhandle, callbackEvent, _cmdPrimary, callbackArgs]() {
                            //auto scrobj = GetScriptObject_AME(_cmdPrimary);
                            RE::BSTSmartPointer<RE::BSScript::IStackCallbackFunctor> setterCallback{nullptr};

                            vm->SendEvent(vmhandle, callbackEvent, RE::MakeFunctionArguments());
                        });
                    })
                );

                auto* operationArgs =
                    RE::MakeFunctionArguments(static_cast<RE::Actor*>(_cmdTargetActor), static_cast<RE::ActiveEffect*>(_cmdPrimary),
                                              static_cast<std::vector<RE::BSFixedString>>(_param));

                for (const auto& _scriptname: _scriptnames) {
                    success = vm->GetScriptObjectType1(_scriptname, typeinfoptr);

                    if (!success) {
                        continue;
                    }

                    success = false;

                    int numglobs = typeinfoptr->GetNumGlobalFuncs();
                    auto globiter = typeinfoptr->GetGlobalFuncIter();

                    for (int i = 0; i < numglobs; i++) {
                        if (_param[0] == globiter[i].func->GetName()) {
                            success = vm->DispatchStaticCall(_scriptname, _param[0], operationArgs, resultCallback);

                            return success;
                        }
                    }
                }
            }

            return success;
        }

        std::string TrimString(const std::string& str) {
            size_t first = str.find_first_not_of(" \t\n\r");
            if (first == std::string::npos)
                return "";
            size_t last = str.find_last_not_of(" \t\n\r");
            return str.substr(first, last - first + 1);
        }

        std::vector<std::string> SplitLinesTrimmed(const std::string& content) {
            std::vector<std::string> lines;
            size_t start = 0;
            size_t i = 0;
            size_t len = content.length();

            while (i < len) {
                if (content[i] == '\r') {
                    if (i > start) {
                        std::string line = content.substr(start, i - start);
                        line = TrimString(line);
                        if (!line.empty()) {
                            lines.push_back(line);
                        }
                    }
                    if (i + 1 < len && content[i + 1] == '\n') {
                        i += 2;  // Windows CRLF
                    } else {
                        i += 1;  // Classic Mac CR
                    }
                    start = i;
                } else if (content[i] == '\n') {
                    if (i > start) {
                        std::string line = content.substr(start, i - start);
                        line = TrimString(line);
                        if (!line.empty()) {
                            lines.push_back(line);
                        }
                    }
                    i += 1;
                    start = i;
                } else {
                    i += 1;
                }
            }

            // Add last line if there's any remaining
            if (start < len) {
                std::string lastLine = content.substr(start);
                lastLine = TrimString(lastLine);
                if (!lastLine.empty()) {
                    lines.push_back(lastLine);
                }
            }

            return lines;
        }

        std::string GetTranslatedString(const std::string& input) {
            auto sfmgr = RE::BSScaleformManager::GetSingleton();
            if (!(sfmgr)) {
                return input;
            }

            auto gfxloader = sfmgr->loader;
            if (!(gfxloader)) {
                return input;
            }

            auto translator =
                (RE::BSScaleformTranslator*) gfxloader->GetStateBagImpl()->GetStateAddRef(RE::GFxState::StateType::kTranslator);

            if (!(translator)) {
                return input;
            }

            RE::GFxTranslator::TranslateInfo transinfo;
            RE::GFxWStringBuffer result;

            std::wstring key_utf16 = stl::utf8_to_utf16(input).value_or(L""s);
            transinfo.key = key_utf16.c_str();

            transinfo.result = std::addressof(result);

            translator->Translate(std::addressof(transinfo));

            if (!result.empty()) {
                std::string actualresult = stl::utf16_to_utf8(result).value();
                return actualresult;
            }

            // Fallback: return original string if no translation found
            return input;
        }

        std::vector<RE::ActiveEffect*> GetActiveEffectsForActor(RE::Actor* _theActor) {
            std::vector<RE::ActiveEffect*> activeEffects;

            if (_theActor) {
                auto actorEffects = _theActor->AsMagicTarget()->GetActiveEffectList();

                for (const auto& effect: *actorEffects) {
                    activeEffects.push_back(effect);
                }
            }

            return activeEffects;
        }

        std::vector<std::string> SplitLines(const std::string& content) {
            std::vector<std::string> lines;
            size_t start = 0;
            size_t i = 0;
            size_t len = content.length();

            while (i < len) {
                if (content[i] == '\r') {
                    if (i > start) {
                        lines.push_back(content.substr(start, i - start));
                    }
                    if (i + 1 < len && content[i + 1] == '\n') {
                        i += 2;  // Windows CRLF
                    } else {
                        i += 1;  // Classic Mac CR
                    }
                    start = i;
                } else if (content[i] == '\n') {
                    if (i > start) {
                        lines.push_back(content.substr(start, i - start));  // Unix LF
                    }
                    i += 1;
                    start = i;
                } else {
                    i += 1;
                }
            }

            // Add last line if there's any remaining
            if (start < len) {
                lines.push_back(content.substr(start));
            }

            return lines;
        }

        std::vector<std::string> Tokenize(const std::string& input) {
            std::vector<std::string> tokens;
            std::string current;
            bool inQuotes = false;
            size_t i = 0;

            while (i < input.size()) {
                char c = input[i];

                if (!inQuotes && c == ';') {
                    // Comment detected — ignore rest of line
                    break;
                }

                if (inQuotes) {
                    if (c == '"') {
                        if (i + 1 < input.size() && input[i + 1] == '"') {
                            current += '"';  // Escaped quote
                            i += 2;
                        } else {
                            inQuotes = false;
                            i++;
                        }
                    } else {
                        current += c;
                        i++;
                    }
                } else {
                    if (std::isspace(static_cast<unsigned char>(c))) {
                        if (!current.empty()) {
                            tokens.push_back(current);
                            current.clear();
                        }
                        i++;
                    } else if (c == '"') {
                        inQuotes = true;
                        i++;
                    } else {
                        current += c;
                        i++;
                    }
                }
            }

            if (!current.empty()) {
                tokens.push_back(current);
            }

            return tokens;
        }
    }  // namespace Util

    namespace Papyrus {
        /*
        bool CustomResolve(RE::StaticFunctionTag*, RE::BSFixedString _scriptname, RE::Actor* _cmdTargetActor,
                                        RE::ActiveEffect* _cmdPrimary, RE::BSFixedString _code) {
          //  logger::info("CustomResolve: in the door : {}", _code.c_str());
            bool result = Util::CustomResolve(_scriptname, _cmdTargetActor, _cmdPrimary, _code);
          //  logger::info("CustomResolve: exiting the building : {}", _code.c_str());
            return result;
        }

        bool CustomResolveActor(RE::StaticFunctionTag*, RE::BSFixedString scriptname, RE::Actor* cmdTargetActor,
                                RE::ActiveEffect* cmdPrimary, RE::BSFixedString code) {
           // logger::info("CustomResolveActor: in the door : {}", code.c_str());
            bool result = Util::CustomResolveActor(scriptname, cmdTargetActor, cmdPrimary, code);
         //   logger::info("CustomResolveActor: exiting the building : {}", code.c_str());
            return result;
        }

        bool CustomResolveCond(RE::StaticFunctionTag*, RE::BSFixedString _scriptname, RE::Actor* _cmdTargetActor,
                               RE::ActiveEffect* _cmdPrimary, RE::BSFixedString _p1, RE::BSFixedString _p2, RE::BSFixedString _oper) {
       //     logger::info("CustomResolveCond: in the door : {}", _oper.c_str());
            bool result = Util::CustomResolveCond(_scriptname, _cmdTargetActor, _cmdPrimary, _p1, _p2, _oper);
        //    logger::info("CustomResolveCond: exiting the building : {}", _oper.c_str());
            return result;
        }
        */

        bool RunOperationOnActor(RE::StaticFunctionTag*, std::vector<RE::BSFixedString> _scriptnames, RE::Actor* _cmdTargetActor,
                                 RE::ActiveEffect* _cmdPrimary, std::vector<RE::BSFixedString> _param) {
            return Util::RunOperationOnActor(_scriptnames, _cmdTargetActor, _cmdPrimary, _param);
        }

        std::vector<std::string> SplitLinesTrimmed(RE::StaticFunctionTag*, RE::BSFixedString _fileString) {
            return Util::SplitLinesTrimmed(_fileString.c_str());
        }

        std::string GetTranslatedString(RE::StaticFunctionTag*, RE::BSFixedString _translationKey) {
            std::string somevalue = Util::GetTranslatedString(_translationKey.c_str());
            logger::info("GetTranslatedString from({})  to({})", _translationKey.c_str(), somevalue);
            return somevalue;
            //return Util::GetTranslatedString(_translationKey.c_str());
        }

        std::vector<RE::ActiveEffect*> GetActiveMagicEffectsForActor(RE::StaticFunctionTag*, RE::Actor* _theActor) {
            return Util::GetActiveEffectsForActor(_theActor);
        }

        bool IsLoaded(RE::StaticFunctionTag*) {
            return true;
        }

        std::vector<std::string> SplitLines(RE::StaticFunctionTag*, RE::BSFixedString _fileString) {
            return Util::SplitLines(_fileString.c_str());
        }

        std::vector<std::string> Tokenize(RE::StaticFunctionTag*, RE::BSFixedString _tokenString) {
            return Util::Tokenize(_tokenString.c_str());
        }

        bool Register(RE::BSScript::IVirtualMachine* vm) {
            /*
            vm->RegisterFunction("_CustomResolve", "sl_triggers_internal", CustomResolve);
            vm->RegisterFunction("_CustomResolveActor", "sl_triggers_internal", CustomResolveActor);
            vm->RegisterFunction("_CustomResolveCond", "sl_triggers_internal", CustomResolveCond);
            */
            vm->RegisterFunction("_RunOperationOnActor", "sl_triggers_internal", RunOperationOnActor);
            vm->RegisterFunction("_SplitLinesTrimmed", "sl_triggers_internal", SplitLinesTrimmed, true);
            vm->RegisterFunction("_GetTranslatedString", "sl_triggers_internal", GetTranslatedString, true);
            vm->RegisterFunction("_GetActiveMagicEffectsForActor", "sl_triggers_internal", GetActiveMagicEffectsForActor);
            vm->RegisterFunction("_IsLoaded", "sl_triggers_internal", IsLoaded, true);
            vm->RegisterFunction("_SplitLines", "sl_triggers_internal", SplitLines, true);
            vm->RegisterFunction("_Tokenize", "sl_triggers_internal", Tokenize, true);

            return true;
        }
    }  // namespace Papyrus

    std::optional<std::filesystem::path> getLogDirectory() {
        using namespace std::filesystem;
        PWSTR buf;
        SHGetKnownFolderPath(FOLDERID_Documents, KF_FLAG_DEFAULT, nullptr, &buf);
        std::unique_ptr<wchar_t, decltype(&CoTaskMemFree)> documentsPath{buf, CoTaskMemFree};
        path directory{documentsPath.get()};
        directory.append("My Games"sv);

        if (exists("steam_api64.dll"sv)) {
            if (exists("openvr_api.dll") || exists("Data/SkyrimVR.esm")) {
                directory.append("Skyrim VR"sv);
            } else {
                directory.append("Skyrim Special Edition"sv);
            }
        } else if (exists("Galaxy64.dll"sv)) {
            directory.append("Skyrim Special Edition GOG"sv);
        } else if (exists("eossdk-win64-shipping.dll"sv)) {
            directory.append("Skyrim Special Edition EPIC"sv);
        } else {
            return current_path().append("skselogs");
        }
        return directory.append("SKSE"sv).make_preferred();
    }

    void initializeLogging() {
        auto path = getLogDirectory();
        if (!path) {
            report_and_fail("Can't find SKSE log directory");
        }
        *path /= std::format("{}.log"sv, Plugin::Name);

        std::shared_ptr<spdlog::logger> log;
        if (IsDebuggerPresent()) {
            log = std::make_shared<spdlog::logger>("Global", std::make_shared<spdlog::sinks::msvc_sink_mt>());
        } else {
            log = std::make_shared<spdlog::logger>("Global", std::make_shared<spdlog::sinks::basic_file_sink_mt>(path->string(), true));
        }
        log->set_level(spdlog::level::info);
        log->flush_on(spdlog::level::info);

        spdlog::set_default_logger(std::move(log));
        spdlog::set_pattern(PLUGIN_LOGPATTERN_DEFAULT);
    }
}  // namespace plugin

using namespace plugin;

extern "C" DLLEXPORT bool SKSEPlugin_Load(const LoadInterface* skse) {
    initializeLogging();

    logger::info("'{} {}' is loading, game version '{}'...", Plugin::Name, Plugin::VersionString, REL::Module::get().version().string());
    Init(skse);

    auto papyrus = SKSE::GetPapyrusInterface();
    papyrus->Register(plugin::Papyrus::Register);

    GameEventHandler::getInstance().onLoad();
    logger::info("{} has finished loading.", Plugin::Name);
    return true;
}

#pragma pop()