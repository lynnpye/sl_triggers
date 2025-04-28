using namespace SKSE;
using namespace SKSE::log;
using namespace SKSE::stl;


#include "Plugin.h"
#include "GameEventHandler.h"
#include "RE/Skyrim.h"
#include "SKSE/SKSE.h"

namespace plugin {
    namespace Util {

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