#include "engine.h"
#include "sl_triggers.h"

#pragma push(warning)
#pragma warning(disable:4100)


namespace SLT {

// SLTNativeFunctions implementation remains the same below

#pragma region SLTNativeFunctions definition

// Non-latent Functions
bool SLTNativeFunctions::DeleteTrigger(PAPYRUS_NATIVE_DECL, std::string_view extKeyStr, std::string_view trigKeyStr) {
    if (!SystemUtil::File::IsValidPathComponent(extKeyStr) || !SystemUtil::File::IsValidPathComponent(trigKeyStr)) {
        logger::error("Invalid characters in extensionKey ({}) or triggerKey ({})", extKeyStr, trigKeyStr);
        return false;
    }

    if (extKeyStr.empty() || trigKeyStr.empty()) {
        logger::error("extensionKey and triggerKey may not be empty extensionKey[{}]  triggerKey[{}]", extKeyStr, trigKeyStr);
        return false;
    }

    // Ensure triggerKey ends with ".json"
    if (trigKeyStr.length() < 5 || trigKeyStr.substr(trigKeyStr.length() - 5) != ".json") {
        trigKeyStr = std::string(trigKeyStr) + std::string(".json");
    }

    fs::path filePath = SLT::GetPluginPath() / "extensions" / extKeyStr / trigKeyStr;

    std::error_code ec;

    if (!fs::exists(filePath, ec)) {
        logger::info("Trigger file not found: {}", filePath.string());
        return false;
    }

    if (fs::remove(filePath, ec)) {
        logger::info("Successfully deleted: {}", filePath.string());
        return true;
    } else {
        logger::info("Failed to delete {}: {}", filePath.string(), ec.message());
        return false;
    }
}

RE::TESForm* SLTNativeFunctions::GetForm(PAPYRUS_NATIVE_DECL, std::string_view a_editorID) {
    return FormUtil::Parse::GetForm(a_editorID);
}

std::string SLTNativeFunctions::GetNumericLiteral(PAPYRUS_NATIVE_DECL, std::string_view token) {
    std::int32_t intValue;
    std::from_chars_result intResult;
    
    // Check for hexadecimal prefix
    if (token.size() > 2 && (token.substr(0, 2) == "0x" || token.substr(0, 2) == "0X")) {
        // Parse as hexadecimal (skip the "0x" prefix)
        intResult = std::from_chars(token.data() + 2, token.data() + token.size(), intValue, 16);
    } else {
        // Parse as decimal
        intResult = std::from_chars(token.data(), token.data() + token.size(), intValue, 10);
    }

    if (intResult.ec == std::errc{} && intResult.ptr == token.data() + token.size()) {
        return std::format("int:{}", intValue);
    }

    float_t floatValue;
    auto floatResult = std::from_chars(token.data(), token.data() + token.size(), floatValue);
    
    // If float parsing succeeded and consumed the entire string
    if (floatResult.ec == std::errc{} && floatResult.ptr == token.data() + token.size()) {
        return std::format("float:{}", floatValue);
    }

    return "invalid";
}

std::vector<std::string> SLTNativeFunctions::GetScriptsList(PAPYRUS_NATIVE_DECL) {
    std::vector<std::string> result;
    std::unordered_set<std::string> seen;

    fs::path scriptsFolderPath = GetPluginPath() / "commands";

    if (fs::exists(scriptsFolderPath)) {
        for (const auto& entry : fs::directory_iterator(scriptsFolderPath)) {
            if (entry.is_regular_file()) {
                auto scriptname = entry.path().filename().string();
                if (scriptname.ends_with(".ini") || scriptname.ends_with(".sltscript")) {
                    auto stem = entry.path().filename().stem().string();
                    
                    // Convert to lowercase for case-insensitive comparison
                    std::string lowerStem = stem;
                    std::transform(lowerStem.begin(), lowerStem.end(), lowerStem.begin(), ::tolower);
                    
                    // Only add if we haven't seen this stem before (case-insensitive)
                    if (seen.find(lowerStem) == seen.end()) {
                        seen.insert(lowerStem);
                        result.push_back(stem); // Keep original case
                    }
                }
            }
        }
    } else {
        logger::error("Scripts folder ({}) doesn't exist. You may need to reinstall the mod.", scriptsFolderPath.string());
    }

    if (result.size() > 1) {
        std::sort(result.begin(), result.end(), [](const std::string& a, const std::string& b) {
            std::string lowerA = a, lowerB = b;
            std::transform(lowerA.begin(), lowerA.end(), lowerA.begin(), ::tolower);
            std::transform(lowerB.begin(), lowerB.end(), lowerB.begin(), ::tolower);
            return lowerA < lowerB;
        });
    }

    
    return result;
}

SLTSessionId SLTNativeFunctions::GetSessionId(PAPYRUS_NATIVE_DECL) {
    return SLT::GetSessionId();
}

float SLTNativeFunctions::GetSubmergedLevel(PAPYRUS_NATIVE_DECL, RE::Actor* akActor) {
    if (!akActor) {
        logger::warn("GetSubmergedLevel: akActor is nullptr; return 0.0");
        return 0.0;
    }
    return Util::Actor::GetSubmergedLevel(akActor);
}

namespace {

    namespace LocalTS {
        std::vector<int> TimestampPartsOfNow() {
            using namespace std::chrono;
            auto now = system_clock::now();
            auto time_t = system_clock::to_time_t(now);
            auto tm = *std::localtime(&time_t);
            return {
                tm.tm_year + 1900,  // Convert back to actual year
                tm.tm_mon + 1,      // Convert back to 1-12
                tm.tm_mday,
                tm.tm_hour,
                tm.tm_min,
                tm.tm_sec
            };
        }

        // Raw extraction - no validation, just parse the numbers
        std::vector<std::int32_t> RawParseTimestamp(std::string_view timestamp) {
            // empty source string means get 'now'
            if (timestamp.empty()) {
                return TimestampPartsOfNow();
            }

            // Must be exactly 14 characters: YYYYMMDDhhmmss
            if (timestamp.length() != 14) {
                return {};
            }
            
            // Check that all characters are digits
            for (char c : timestamp) {
                if (!std::isdigit(c)) {
                    return {};
                }
            }
            
            // Extract components without any validation
            auto extract = [&](size_t start, size_t length) -> std::int32_t {
                std::int32_t result = 0;
                for (size_t i = start; i < start + length; ++i) {
                    result = result * 10 + (timestamp[i] - '0');
                }
                return result;
            };
            
            std::int32_t year   = extract(0, 4);  // YYYY
            std::int32_t month  = extract(4, 2);  // MM
            std::int32_t day    = extract(6, 2);  // DD
            std::int32_t hour   = extract(8, 2);  // hh
            std::int32_t minute = extract(10, 2); // mm
            std::int32_t second = extract(12, 2); // ss
            
            return {year, month, day, hour, minute, second};
        }

        // Normalization function - handles overflow/underflow and invalid dates
        std::vector<std::int32_t> NormalizeTimestamp(std::int32_t year, std::int32_t month, std::int32_t day, std::int32_t hour, std::int32_t minute, std::int32_t second) {
            // Use C standard library to handle the complex date math
            std::tm tm = {};
            tm.tm_year = year - 1900;  // tm_year is years since 1900
            tm.tm_mon = month - 1;     // tm_mon is 0-11
            tm.tm_mday = day;          // tm_mday is 1-31
            tm.tm_hour = hour;         // tm_hour is 0-23
            tm.tm_min = minute;        // tm_min is 0-59
            tm.tm_sec = second;        // tm_sec is 0-59
            
            // mktime normalizes the values and handles overflow/underflow
            std::time_t time = std::mktime(&tm);
            
            if (time == -1) {
                // mktime failed - return empty vector
                return {};
            }
            
            // Convert back to normalized components
            return {
                tm.tm_year + 1900,  // Convert back to actual year
                tm.tm_mon + 1,      // Convert back to 1-12
                tm.tm_mday,
                tm.tm_hour,
                tm.tm_min,
                tm.tm_sec
            };
        }

        // Convenience overload that takes a vector
        std::vector<std::int32_t> NormalizeTimestamp(const std::vector<std::int32_t>& components) {
            if (components.size() != 6) {
                return {};
            }
            return NormalizeTimestamp(components[0], components[1], components[2], 
                                    components[3], components[4], components[5]);
        }

        std::vector<std::int32_t> NormalizeTimestamp(std::string_view sourceTimestamp) {
            return NormalizeTimestamp(RawParseTimestamp(sourceTimestamp));
        }


        std::string TimestampPartsToString(std::int32_t year, std::int32_t month, std::int32_t day, std::int32_t hour, std::int32_t minute, std::int32_t second) {
            return std::format("{:04d}{:02d}{:02d}{:02d}{:02d}{:02d}",
                            year,
                            month,
                            day,
                            hour,
                            minute,
                            second);
        }

        std::string TimestampPartsToString(const std::vector<std::int32_t>& components) {
            if (components.size() != 6) {
                return "";
            }
            return TimestampPartsToString(components[0], components[1], components[2], 
                                    components[3], components[4], components[5]);
        }

    }

}

std::vector<std::int32_t> SLTNativeFunctions::NormalizeTimestamp(PAPYRUS_NATIVE_DECL, std::string_view optionalSourceTimestamp) {
    return LocalTS::NormalizeTimestamp(optionalSourceTimestamp);
}

std::vector<std::int32_t> SLTNativeFunctions::NormalizeTimestampComponents(PAPYRUS_NATIVE_DECL, std::vector<std::int32_t> optionalSourceTimestampComponents) {
    return LocalTS::NormalizeTimestamp(optionalSourceTimestampComponents);
}

std::string SLTNativeFunctions::GetTopicInfoResponse(PAPYRUS_NATIVE_DECL, RE::TESTopicInfo* topicInfo) {
    if (!topicInfo) {
        logger::error("GetTopicInfoResponses called but topicInfo was null");
    } else {
        RE::DialogueItem dialogueItem = topicInfo->GetDialogueData(nullptr);
        
        for (auto* response : dialogueItem.responses) {
            if (response) {
                return std::string(response->text.c_str());
            }
        }
    }

    return "";
}

std::string SLTNativeFunctions::GetTranslatedString(PAPYRUS_NATIVE_DECL, std::string_view input) {
    auto sfmgr = RE::BSScaleformManager::GetSingleton();
    if (!(sfmgr)) {
        return std::string(input);
    }

    auto gfxloader = sfmgr->loader;
    if (!(gfxloader)) {
        return std::string(input);
    }

    auto translator =
        (RE::BSScaleformTranslator*) gfxloader->GetStateBagImpl()->GetStateAddRef(RE::GFxState::StateType::kTranslator);

    if (!(translator)) {
        return std::string(input);
    }

    RE::GFxTranslator::TranslateInfo transinfo;
    RE::GFxWStringBuffer result;

    std::wstring key_utf16 = ::stl::utf8_to_utf16(input).value_or(L""s);
    transinfo.key = key_utf16.c_str();

    transinfo.result = std::addressof(result);

    translator->Translate(std::addressof(transinfo));

    if (!result.empty()) {
        std::string actualresult = ::stl::utf16_to_utf8(result).value();
        return actualresult;
    }

    // Fallback: return original string if no translation found
    return std::string(input);
}

std::vector<std::string> SLTNativeFunctions::GetTriggerKeys(PAPYRUS_NATIVE_DECL, std::string_view extensionKey) {
    std::vector<std::string> result;

    fs::path triggerFolderPath = GetPluginPath() / "extensions" / extensionKey;

    if (fs::exists(triggerFolderPath)) {
        for (const auto& entry : fs::directory_iterator(triggerFolderPath)) {
            if (entry.is_regular_file()) {
                if (str::iEquals(entry.path().extension().string(), ".json")) {
                    result.push_back(entry.path().filename().string());
                }
            }
        }
    } else {
        logger::error("Trigger folder ({}) doesn't exist. You may need to reinstall the mod or at least make sure the folder is created.",
            triggerFolderPath.string());
    }
    
    if (result.size() > 1) {
        std::sort(result.begin(), result.end());
    }
    
    return result;
}

namespace {
bool IsAssignableScope(std::string_view scope) {
    if (
        Util::String::iEquals("local", scope)
        || Util::String::iEquals("thread", scope)
        || Util::String::iEquals("target", scope)
        || Util::String::iEquals("global", scope)
    )
        return true;
    return false;
}

bool IsValidScope(std::string_view scope) {
    if (
        IsAssignableScope(scope)
        || Util::String::iEquals("system", scope)
        || Util::String::iEquals("request", scope)
    )
        return true;
    return false;
}
}

#define RUN_TEST_VARSCOPE true
#undef RUN_TEST_VARSCOPE
#ifdef RUN_TEST_VARSCOPE
OnAfterSKSEInit([]{
    using namespace std;
    auto variables = vector<string>({
        ""
        , "$varname[12]"
        , "$varname[$listindex]"
        , "$varname[ $listindex ]"
        , "$varname"
        , "$local.varname"
        , "$thread.varname"
        , "$target.varname"
        , "$global.varname"
        , "$system.varname"
        , "$request.varname"
        , "$var.name"
        , "$var.n.ame"
        , "$target.var.name"
        , "$target.<foo>.varname"
        , "$target.< foo >.varname"
        , "$target.<foo>varname"
        , "$target<foo>.varname"
        , "$target.<foo.bar>.var.name"
        , "$target.< $target<foo>.barActor[ 23 ]{ $target.<bar>.barVal[ $key ]{ keykey } } >.var.name[ $key1 ]{ $mapkey }"
        , "$varname[]"
        , "$varname[]{}"
        , "$varname[12]{}"
        , "$global.mapval{test}"
        , "$local.varname[12]"
        , "$target.<foo>.varname[12]"
        , "$target.<foo>.varname[12]{}"
        , "$target.<foo>.varname[12]{$thekey}"
        , "$varname{akey}"
        , "$varname{\"whee\"}"
        , "$varname{23}"
    });

    logger::debug("Testing GetVarScope with forAssignment == false");
    for (const auto& var : variables) {
        auto varscope = SLTNativeFunctions::GetVarScope(nullptr, 0, var, false);
        logger::debug("\n '{}' \n\t /SCOPE: '{}' \n\t /VNAME: '{}' \n\t /TGEXT: '{}' \n\t /LINDX: '{}' \n\t /MAPKY: '{}' \n\t /RMPKY: '{}' \n", var, varscope[0], varscope[1], varscope[2], varscope[3], varscope[4], varscope[5]);
    }

    logger::debug("Testing GetVarScope with forAssignment == true");
    for (const auto& var : variables) {
        auto varscope = SLTNativeFunctions::GetVarScope(nullptr, 0, var, true);
        logger::debug("\n '{}' \n\t /SCOPE: '{}' \n\t /VNAME: '{}' \n\t /TGEXT: '{}' \n\t /LINDX: '{}' \n\t /MAPKY: '{}' \n\t /RMPKY: '{}' \n", var, varscope[0], varscope[1], varscope[2], varscope[3], varscope[4], varscope[5]);
    }
})
#endif

std::vector<std::string> SLTNativeFunctions::GetVarScope(PAPYRUS_NATIVE_DECL, std::string_view variable, bool forAssignment) {

/*
this is the syntax possible for variable:
$<OPTIONAL: scope := default='local'>.<OPTIONAL: target_extension_scope : only valid if scope == 'target'>.<varname>[OPTIONAL: list_index]{OPTIONAL: map_key}

NOTE: varname may contain 0 or more '.', but ONLY IF a scope is specified (otherwise it will assume the first period-separated block is a scope)

valid scope values: ''/'local', 'thread', 'target', 'global'

Some possible versions:

$local.varname
$varname -- same as $local.varname

$local.var.name -- valid
$var.name -- NOT valid because it thinks 'var' is the scope, which is not a valid scope; only a problem for local scope as other scopes must be specified

$thread.varname
$global.varname
$target.varname

$target.<partner>.varname -- the target_extension_scope is only valid if scope is 'target'
$target.<partner>.var.name -- another example

$varname[] -- references the variable generally, list_index would be "[]"
$varname[0] -- references the 0th value, list_index would be "0"
$varname[17], etc.

$thread.varname[]
$thread.varname[0]
$thread.var.name[0]

$target.varname[]
$target.<actor>.varname[] -- with target_extension_scope
$target.<actor>.var.name[]

$varname{"key"} -- map_key would be ""key""
$varname{$foo} -- map_key would be "$foo"
$varname{} -- references the variable generally, map_key would be "{}"
$varname[0]{$foo} -- list_index would be "0", map_key would be "$foo"
$varname[17]{} -- list_index would be "17", map_key would be "{}"

$target.varname[100]{$bar}
$target.va.rname[100]{$bar}

NOTE: an empty list index CANNOT be used with a map_key, so $varname[]{} and $varname[]{$foo} are both invalid

So the fullest example would be:
$target.<actor>.var.n.ame[23]{$key}
for which:
scope - "target"
target_extension_scope - "actor"
varname - "var.n.ame"
list_index - "23"
map_key - "$key"

Provide C++ code that will parse variable and then place the values into the result vector
result[0] - scope
result[1] - varname
result[2] - target_extension_scope
result[3] - list_index
result[4] - map_key
result[5] - resolved_map_key ; allotted but used on the papyrus side
result[6] - resolved_list_index ; allotted but used on the papyrus side

*/
    using namespace std;

    vector<string> result;
    result.resize(7);

    size_t varlen = variable.size();

    if (varlen < 2 || variable[0] != '$') {
        result[1] = variable;
        return result;
    }

    string& scope = result[0];
    string& varname = result[1]; 
    string& target_extension_scope = result[2];
    string& list_index = result[3];
    string& map_key = result[4];

    size_t startPos = 1;
    size_t endPos;

    if (
        variable.starts_with("$local.")
    ) {
        startPos = 7;
    }
    else if (
        variable.starts_with("$thread.")
        || variable.starts_with("$target.")
        || variable.starts_with("$global.")
        || variable.starts_with("$system.")
    ) {
        startPos = 8;
    }
    else if (
        variable.starts_with("$request.")
    ) {
        startPos = 9;
    }

    if (startPos == 1) {
        scope = "local";
    } else {
        scope = Util::String::ToLower(variable.substr(1, startPos - 2));
    }

    // check for valid scope
    if (!IsValidScope(scope)) {
        scope = "local";
        startPos = 1;
    }

    if (forAssignment && !IsAssignableScope(scope)) {
        logger::error("Scope ({}) is not assignable but is on LHS of assignment", scope);

        scope = "";
        varname = variable;
        return result;
    }

    // check for target extension scope
    if (variable[startPos] == '<') {
        if (scope != "target") {
            logger::error("Scope ({}) is not valid for use with <target-extension-scope>", scope);

            scope = "";
            varname = variable;
            return result;
        }

        endPos = startPos + 1;

        int counter = 1;
        while (endPos < varlen && counter > 0) {
            if (variable[endPos] == '<') {
                ++counter;
            }
            else if (variable[endPos] == '>') {
                --counter;
            }
            ++endPos;
        }

        if (counter > 0) {
            logger::error("Malformed target extension scope for variable ({}); imbalanced brackets, '<'/'>'", variable);

            scope = "";
            varname = variable;
            return result;
        }
        else if (endPos >= varlen || variable[endPos] != '.') {
            logger::error("Malformed target extension scope for variable ({}); missing trailing sub-scope separator, '.'", variable);

            scope = "";
            varname = variable;
            return result;
        }

        target_extension_scope = Util::String::trim(variable.substr(startPos + 1, endPos - startPos - 2));

        startPos = endPos + 1;
    }

    // no variable name at all
    if (startPos >= varlen) {
        // malformed
        logger::error("Variable ({}) has no variable name", variable);

        scope = "";
        varname = variable;
        return result;
    }
    else if (variable[startPos] == '[') {
        // malformed
        logger::error("Variable ({}) has list index with no variable name", variable);

        scope = "";
        varname = variable;
        return result;
    }
    else if (variable[startPos] == '{') {
        // malformed
        logger::error("Variable ({}) has map key with no variable name", variable);

        scope = "";
        varname = variable;
        return result;
    }

    /*
     *  e.g. for:
     *      $target.<foo.bar>.baz.ban[23]{"whee"}
     *                        ^
     *                        |-- startPos
     */
    size_t bracketStartPos = variable.find("[", startPos);
    if (bracketStartPos != string::npos) {

        endPos = bracketStartPos + 1;

        int counter = 1;
        while (endPos < varlen && counter > 0) {
            if (variable[endPos] == '[') {
                ++counter;
            }
            else if (variable[endPos] == ']') {
                --counter;
            }
            if (counter <= 0) break;

            ++endPos;
        }

        if (counter > 0) {
            // malformed
            logger::error("Variable ({}) has imbalanced list index", variable);

            scope = "";
            varname = variable;
            return result;
        }

        list_index = Util::String::trim(variable.substr(bracketStartPos + 1, endPos - bracketStartPos - 1));
        if (list_index.empty()) {
            // malformed
            logger::error("Variable ({}) used list syntax with an empty list index", variable);

            scope = "";
            varname = variable;
            return result;
        }

        varname = Util::String::trim(variable.substr(startPos, bracketStartPos - startPos));
        if (varname.empty()) {
            // malformed
            logger::error("Variable ({}) has list index with no variable name", variable);

            scope = "";
            varname = variable;
            return result;
        }

        bracketStartPos = variable.find("{", endPos);
    } else {
        bracketStartPos = variable.find("{", startPos);
    }

    if (bracketStartPos != string::npos) {

        endPos = variable.rfind("}");
        if (endPos == string::npos) {
            // malformed
            logger::error("Variable ({}) has imbalanced map key", variable);

            scope = "";
            varname = variable;
            return result;
        }

        map_key = Util::String::trim(variable.substr(bracketStartPos + 1, endPos - bracketStartPos - 1));
        if (map_key.empty()) {
            // malformed
            logger::error("Variable ({}) used map syntax with an empty key", variable);

            scope = "";
            varname = variable;
            return result;
        }

        if (varname.empty()) {
            varname = variable.substr(startPos, bracketStartPos - startPos);
            if (varname.empty()) {
                // malformed
                logger::error("Variable ({}) has map key with no variable name", variable);

                scope = "";
                varname = variable;
                return result;
            }
        }
    }

    if (varname.empty()) {
        varname = variable.substr(startPos);
    }

    if (varname.empty()) {
        // malformed
        logger::error("Variable ({}) has no variable name", variable);

        scope = "";
        varname = variable;
        return result;
    }

    return result;
}

void SLTNativeFunctions::LogDebug(PAPYRUS_NATIVE_DECL, std::string_view logmsg) {
    logger::debug("{}", logmsg);
}

void SLTNativeFunctions::LogError(PAPYRUS_NATIVE_DECL, std::string_view logmsg) {
    logger::error("{}", logmsg);
}

void SLTNativeFunctions::LogInfo(PAPYRUS_NATIVE_DECL, std::string_view logmsg) {
    logger::info("{}", logmsg);
}

void SLTNativeFunctions::LogWarn(PAPYRUS_NATIVE_DECL, std::string_view logmsg) {
    logger::warn("{}", logmsg);
}

std::vector<std::string> SLTNativeFunctions::MCMGetAttributeData(PAPYRUS_NATIVE_DECL, bool isTriggerAttribute, std::string_view extensionKey, std::string_view attrName, std::string_view info) {
    std::vector<std::string> result;

    if (extensionKey.empty() || attrName.empty() || info.empty()) {
        logger::error("MCMGetAttributeData: extensionKey({}), attrName({}), and info({}) are all required to be non-empty; returning empty list", extensionKey, attrName, info);
        return result;
    }

    fs::path file = GetExtensionAttributesFile(extensionKey);

    if (fs::exists(file)) {
        std::string jkey = isTriggerAttribute ? "trigger_attributes" : "settings_attributes";
        
        nlohmann::json j;

        try {
            std::ifstream in(file);
            in >> j;
        } catch (...) {
            logger::error("MCMGetAttributeData: Exception while loading JSON from {}", file.filename().string());
        }

        if (j.contains(jkey)) {
            if (j[jkey].is_array()) {
                std::string mappedKey;
                for (const auto& attributeEntry : j[jkey]) {
                    if (attributeEntry.is_array() && !attributeEntry.empty() && attributeEntry.size() > 1) {
                        std::string firstElement = attributeEntry[0];
                        if (!firstElement.empty() && firstElement[0] != '#' && Util::String::iEquals(attrName, firstElement)) {
                            mappedKey = attributeEntry[1];
                            break;
                        }
                    }
                }
                
                if (j.contains(mappedKey)) {
                    if (j[mappedKey].is_array()) {
                        for (const auto& mappedEntry : j[mappedKey]) {
                            if (mappedEntry.is_array() && !mappedEntry.empty() && mappedEntry.size() > 1) {
                                std::string firstElement = mappedEntry[0];
                                if (!firstElement.empty() && firstElement[0] != '#' && Util::String::iEquals(info, firstElement)) {
                                    for (int i = 1; i < mappedEntry.size(); i++) {
                                        std::string mappedEntryValue = mappedEntry[i];
                                        if (mappedEntryValue[0] == '#')
                                            break;
                                        result.push_back(mappedEntry[i]);
                                    }
                                }
                            }
                        }
                    } else {
                        logger::error("MCMGetAttributeData: Mapped attribute key {} not an array in file {}", mappedKey, file.filename().string());    
                    }
                } else {
                    logger::error("MCMGetAttributeData: Mapped attribute key {} missing in file {}", mappedKey, file.filename().string());
                }
            } else {
                logger::error("MCMGetAttributeData: Extension attributes file {} entry for {} is not an array", file.filename().string(), jkey);
            }
        } else {
            logger::error("MCMGetAttributeData: Extension attributes file {} does not have an entry for {}", file.filename().string(), jkey);
        }
    } else {
        logger::error("MCMGetAttributeData: File does not exist: {}", file.filename().string());
    }

    return result;
}

namespace {
enum PTYPE {
    PTYPE_STRING    = 1,
    PTYPE_INT       = 2,
    PTYPE_FLOAT     = 3,
    PTYPE_FORM      = 4
};

int MCMGetAttrType(PAPYRUS_NATIVE_DECL, bool isTriggerAttribute, std::string_view extensionKey, std::string_view attrName) {
    auto data = SLTNativeFunctions::MCMGetAttributeData(PAPYRUS_FN_PARMS, isTriggerAttribute, extensionKey, attrName, "type");
    if (data.size() > 0) {
        if (Util::String::iEquals(data[0], "int")) return PTYPE_INT;
        if (Util::String::iEquals(data[0], "float")) return PTYPE_FLOAT;
        if (Util::String::iEquals(data[0], "string")) return PTYPE_STRING;
        if (Util::String::iEquals(data[0], "form")) return PTYPE_FORM;
    }
    return -1;
}
}

std::vector<std::string> SLTNativeFunctions::MCMGetLayout(PAPYRUS_NATIVE_DECL, bool isTriggerAttribute, std::string_view extensionKey, std::string_view dataFileName) {
    std::vector<std::string> result;
    result.resize(2);

    if (extensionKey.empty() || (isTriggerAttribute && dataFileName.empty())) {
        logger::error("MCMGetLayout: extensionKey({}), dataFileName({}) are both required to be non-empty; returning empty list", extensionKey, dataFileName);
        return result;
    }

    fs::path file = GetExtensionAttributesFile(extensionKey);
    fs::path dataFile;
    if (isTriggerAttribute) {
        dataFile = GetTriggerFile(extensionKey, dataFileName);
    } else {
        dataFile = GetExtensionSettingsFile(extensionKey);
    }

    if (fs::exists(file)) {
        std::string jkey = isTriggerAttribute ? "trigger_layoutconditions" : "settings_layoutconditions";
        
        nlohmann::json j;

        try {
            std::ifstream in(file);
            in >> j;
        } catch (...) {
            logger::error("MCMGetLayout: Exception while loading JSON from {}", file.filename().string());
            return result;
        }

        if (j.contains(jkey) && j[jkey].is_array()) {
            std::string visibilityKey;

            for (const auto& attributeEntry : j[jkey]) {
                if (attributeEntry.is_array() && !attributeEntry.empty()) {
                    std::string layoutConditionValue = attributeEntry[0];
                    if (!layoutConditionValue.empty() && layoutConditionValue[0] != '#') {
                        // the first uncommented list in trigger_layoutconditions provides us the key for comparisons
                        if (visibilityKey.empty()) {
                            visibilityKey = layoutConditionValue;
                            result[1] = visibilityKey;
                        // afterward, any pair (or higher) gets processed
                        } else if (attributeEntry.size() > 1) {
                            int ptype = MCMGetAttrType(PAPYRUS_FN_PARMS, isTriggerAttribute, extensionKey, visibilityKey);
                            if (PTYPE_INT == ptype) {
                                int checkValue = Util::String::StringToIntWithImplicitHexConversion(layoutConditionValue).value_or(0);
                                nlohmann::json data;

                                try {
                                    std::ifstream in(dataFile);
                                    in >> data;
                                } catch (...) {
                                    logger::error("MCMGetLayout: Exception while loading JSON from {}", dataFile.filename().string());
                                    return result;
                                }

                                int dataValue = 0;
                                if (data.contains("int") && data["int"].contains(visibilityKey)) {
                                    dataValue = data["int"][visibilityKey];
                                }

                                if (checkValue == dataValue) {
                                    std::string layoutName = attributeEntry[1];
                                    std::vector<std::string> rowone = MCMGetLayoutData(PAPYRUS_FN_PARMS, isTriggerAttribute, extensionKey, layoutName, 0);
                                    if (rowone.size() > 0) {
                                        result[0] = layoutName;
                                        result[1] = visibilityKey;
                                        return result;
                                    }
                                }
                            } else if (PTYPE_STRING == ptype) {
                                nlohmann::json data;

                                try {
                                    std::ifstream in(dataFile);
                                    in >> data;
                                } catch (...) {
                                    logger::error("MCMGetLayout: Exception while loading JSON from {}", dataFile.filename().string());
                                    return result;
                                }

                                std::string dataValue;
                                if (data.contains("int") && data["int"].contains(visibilityKey)) {
                                    dataValue = data["int"][visibilityKey];
                                }

                                if (layoutConditionValue == dataValue) {
                                    std::string layoutName = attributeEntry[1];
                                    std::vector<std::string> rowone = MCMGetLayoutData(PAPYRUS_FN_PARMS, isTriggerAttribute, extensionKey, layoutName, 0);
                                    if (rowone.size() > 0) {
                                        result[0] = layoutName;
                                        result[1] = visibilityKey;
                                        return result;
                                    }
                                }
                            }
                        }
                    }
                }
            }
            if (result.size() == 0) {
                logger::warn("MCMGetLayout: Extension attributes file {} entry for {} returned no valid attribute names", file.filename().string(), jkey);
            }
        } else {
            return result;
        }
    } else {
        logger::error("MCMGetLayout: File does not exist: {}", file.filename().string());
    }

    return result;
}

std::vector<std::string> SLTNativeFunctions::MCMGetLayoutData(PAPYRUS_NATIVE_DECL, bool isTriggerAttribute, std::string_view extensionKey, std::string_view layout, std::int32_t row) {
    std::vector<std::string> result;

    if (extensionKey.empty()) {
        logger::error("MCMGetLayoutData: extensionKey({}) is required to be non-empty; returning empty list", extensionKey);
        return result;
    }

    fs::path file = GetExtensionAttributesFile(extensionKey);

    if (fs::exists(file)) {
        std::string jkey = std::string(layout);
        if (jkey.empty()) {
            if (isTriggerAttribute) {
                jkey = "triggerlayout";
            } else {
                jkey = "settingslayout";
            }
        }
        
        nlohmann::json j;

        try {
            std::ifstream in(file);
            in >> j;
        } catch (...) {
            logger::error("MCMGetLayoutData: Exception while loading JSON from {}", file.filename().string());
            return result;
        }

        if (j.contains(jkey)) {
            if (j[jkey].is_array()) {
                for (auto it = j[jkey].begin(); it != j[jkey].end(); ++it) {
                    const auto& attributeEntry = *it;
                    if (attributeEntry.is_array() && !attributeEntry.empty()) {
                        std::string elem = attributeEntry[0];
                        if (!elem.empty() && elem[0] != '#') {
                            result.push_back(elem);
                        }
                        if (attributeEntry.size() > 1) {
                            elem = attributeEntry[1];
                            if (!elem.empty() && elem[0] != '#') {
                                result.push_back(elem);
                            }
                        }
                        if (std::next(it) != j[jkey].end()) {
                            result.push_back("/");
                        }
                    }
                }
            } else {
                logger::error("MCMGetLayoutData: Extension attributes file {} entry for {} is not an array", file.filename().string(), jkey);
            }
        } else {
            logger::error("MCMGetLayoutData: Extension attributes file {} does not have an entry for {}", file.filename().string(), jkey);
        }
    } else {
        logger::error("MCMGetLayoutData: File does not exist: {}", file.filename().string());
    }

    return result;
}
/*
0 - unrecognized
1 - is explicitly .json
2 - is explicitly .ini
3 - is explicitly .sltscript
10 - implicitly .json
20 - implicitly .ini
30 - implicitly .sltscript
*/
std::int32_t SLTNativeFunctions::NormalizeScriptfilename(PAPYRUS_NATIVE_DECL, std::string_view scriptfilename) {
    fs::path scrpath = GetScriptfilePath(scriptfilename);
    std::string scrfn = "";

    if (!scrpath.has_extension()) {
        scrfn = std::string(scriptfilename) + ".sltscript";
        scrpath = GetScriptfilePath(scrfn);
        if (!scrpath.empty() && fs::exists(scrpath)) {
            return 30;
        }

        scrfn = std::string(scriptfilename) + ".ini";
        scrpath = GetScriptfilePath(scrfn);
        if (!scrpath.empty() && fs::exists(scrpath)) {
            return 20;
        }
    } else {
        scrfn = scrpath.extension().string();
        if (!scrpath.empty() && !scrfn.empty() && fs::exists(scrpath)) {
            if (scrfn == ".sltscript") {
                return 3;
            }
            if (scrfn == ".ini") {
                return 2;
            }
        }
    }

    return 0;
}

bool SLTNativeFunctions::RunOperationOnActor(PAPYRUS_NATIVE_DECL, RE::Actor* cmdTarget, RE::ActiveEffect* cmdPrimary,
    std::vector<std::string> tokens) {
    return OperationRunner::RunOperationOnActor(cmdTarget, cmdPrimary, tokens);
}

bool SLTNativeFunctions::RunSLTRMain(PAPYRUS_NATIVE_DECL, RE::Actor* cmdTarget, std::string_view scriptname, std::vector<std::string> strlist, std::vector<std::int32_t> intlist, std::vector<float> floatlist, std::vector<bool> boollist, std::vector<RE::TESForm*> formlist) {
    return OperationRunner::RunSLTRMain(cmdTarget, scriptname, strlist, intlist, floatlist, boollist, formlist);
}

void SLTNativeFunctions::SetExtensionEnabled(PAPYRUS_NATIVE_DECL, std::string_view extensionKey, bool enabledState) {
    //SLTExtensionTracker::SetEnabled(extensionKey, enabledState);
    auto funlibs = FunctionLibrary::ByExtensionKey(extensionKey);

    for (auto* funlib : funlibs) {
        if (funlib) {
            funlib->enabled = enabledState;
            logger::info("SetExtensionEnabled: FunctionLibrary[{}]", funlib->GetDescription());
            FunctionLibrary::RefreshFunctionLibraryCache();
        } else {
            logger::error("FunctionLibrary in vector for extensionKey '{}' was nullptr; unable to set enabled to '{}'", extensionKey, enabledState);
        }
    }
}

void SLTNativeFunctions::SetCombatSinkEnabled(PAPYRUS_NATIVE_DECL, bool isEnabled) {
    SLTREventSink::GetSingleton()->SetEnabledCombatEvent(isEnabled);
    logger::info("CombatEvent sink enabled({})", SLTREventSink::GetSingleton()->IsEnabledCombatEvent());
}

void SLTNativeFunctions::SetEquipSinkEnabled(PAPYRUS_NATIVE_DECL, bool isEnabled) {
    SLTREventSink::GetSingleton()->SetEnabledEquipEvent(isEnabled);
    logger::info("EquipEvent sink enabled({})", SLTREventSink::GetSingleton()->IsEnabledEquipEvent());
}

void SLTNativeFunctions::SetHitSinkEnabled(PAPYRUS_NATIVE_DECL, bool isEnabled) {
    SLTREventSink::GetSingleton()->SetEnabledHitEvent(isEnabled);
    logger::info("HitEvent sink enabled({})", SLTREventSink::GetSingleton()->IsEnabledHitEvent());
}

/*
void SLTNativeFunctions::SetActivateSinkEnabled(PAPYRUS_NATIVE_DECL, bool isEnabled) {
    SLTREventSink::GetSingleton()->SetEnabledActivateEvent(isEnabled);
    logger::info("ActivateEvent sink enabled({})", SLTREventSink::GetSingleton()->IsEnabledActivateEvent());
}
*/

void SLTNativeFunctions::SetHarvestedSinkEnabled(PAPYRUS_NATIVE_DECL, bool isEnabled) {
    SLTREventSink::GetSingleton()->SetEnabledHarvestedEvent(isEnabled);
    logger::info("HarvestedEvent sink enabled({})", SLTREventSink::GetSingleton()->IsEnabledHarvestedEvent());
}

void SLTNativeFunctions::SetSwimHookEnabled(PAPYRUS_NATIVE_DECL, bool isEnabled) {
    SLTREventSink::GetSingleton()->SetEnabledSwimHooks(isEnabled);
    logger::info("SwimHooks processing enabled({})", SLTREventSink::GetSingleton()->IsEnabledSwimHooks());
}

bool SLTNativeFunctions::IsCombatSinkEnabled(PAPYRUS_NATIVE_DECL) {
    return SLTREventSink::GetSingleton()->IsEnabledCombatEvent();
}

bool SLTNativeFunctions::IsEquipSinkEnabled(PAPYRUS_NATIVE_DECL) {
    return SLTREventSink::GetSingleton()->IsEnabledEquipEvent();
}

bool SLTNativeFunctions::IsHitSinkEnabled(PAPYRUS_NATIVE_DECL) {
    return SLTREventSink::GetSingleton()->IsEnabledHitEvent();
}

/*
bool SLTNativeFunctions::IsActivateSinkEnabled(PAPYRUS_NATIVE_DECL) {
    return SLTREventSink::GetSingleton()->IsEnabledActivateEvent();
}
*/

bool SLTNativeFunctions::IsHarvestedSinkEnabled(PAPYRUS_NATIVE_DECL) {
    return SLTREventSink::GetSingleton()->IsEnabledHarvestedEvent();
}

bool SLTNativeFunctions::IsSwimHookEnabled(PAPYRUS_NATIVE_DECL) {
    return SLTREventSink::GetSingleton()->IsEnabledSwimHooks();
}

bool SLTNativeFunctions::SmartEquals(PAPYRUS_NATIVE_DECL, std::string_view a, std::string_view b) {
    float aNum = 0.0, bNum = 0.0;
    bool aIsNum = Util::String::isNumeric(a, aNum);
    bool bIsNum = Util::String::isNumeric(b, bNum);

    std::optional<bool> aBoolVal;
    std::optional<bool> bBoolVal;
    if (!aIsNum) {
        if (Util::String::isTrue(a)) {
            aBoolVal = true;
        } else if (Util::String::isFalse(a)) {
            aBoolVal = false;
        }
    }
    if (!bIsNum) {
        if (Util::String::isTrue(b)) {
            bBoolVal = true;
        } else if (Util::String::isFalse(b)) {
            bBoolVal = false;
        }
    }

    bool outcome = false;
    if ((aBoolVal.has_value() || bBoolVal.has_value()) && ((aBoolVal.has_value() || aIsNum) && (bBoolVal.has_value() || bIsNum))) {
        bool aVal = aBoolVal.value_or(aIsNum ? aNum != 0.0 : !a.empty());
        bool bVal = bBoolVal.value_or(bIsNum ? bNum != 0.0 : !b.empty());
        outcome = aVal == bVal;
        //logger::debug("SmartEquals: a({}) b({}) aNum({}) bNum({}) aIsNum({}) bIsNum({}) outcome({}): at least one bool: aBoolVal.has({}) bBoolVal.has({}) aVal({}) bVal({})", a, b, aNum, bNum, aIsNum, bIsNum, outcome, aBoolVal.has_value(), bBoolVal.has_value(), aVal, bVal);
    }
    else if (aIsNum && bIsNum) {
        outcome = (std::fabs(aNum - bNum) < FLT_EPSILON);  // safe float comparison
        //logger::debug("SmartEquals: a({}) b({}) aNum({}) bNum({}) aIsNum({}) bIsNum({}) outcome({}): treating as numeric checking diff vs FLT_EPSILON", a, b, aNum, bNum, aIsNum, bIsNum, outcome);
    }
    else {
        outcome = Util::String::iEquals(a, b);
        //logger::debug("SmartEquals: a({}) b({}) aNum({}) bNum({}) aIsNum({}) bIsNum({}) outcome({}): treating as Util::String::iEquals(a,b) comparison", a, b, aNum, bNum, aIsNum, bIsNum, outcome);
    }

    return outcome;
}

/**
; returns string[]
; 0 : count of functional lines returned
; N-cmdLines : scriptlineno for each line
; N-cmdLines : tokencount for each line
; N-cmdLines : tokenoffsets for each line
; N- + : full set of tokens
 */
std::vector<std::string> SLTNativeFunctions::SplitScriptContentsAndTokenize(PAPYRUS_NATIVE_DECL, std::string_view scriptfilename) {
    std::vector<std::string> scriptlineno;
    std::vector<std::string> tokencount;
    std::vector<std::string> tokenoffsets;

    std::vector<std::string> linetokens;
    
    std::vector<std::string> tokenaccumulator;

    fs::path filepath = GetScriptfilePath(scriptfilename);
    std::int32_t lineno = 0;
    std::int32_t tokcount = 0;
    std::int32_t tokoffset = 0;

    if (fs::exists(filepath) && fs::is_regular_file(filepath)) {
        std::ifstream file(filepath);
        if (file.good()) {
            std::string line;
            while (std::getline(file, line)) {
                lineno++;

                linetokens = Tokenizev2(PAPYRUS_FN_PARMS, line);

                if (linetokens.size() < 1) {
                    continue;
                }

                tokoffset += tokcount; // accumulate from previous tokcount
                tokcount = linetokens.size();

                scriptlineno.push_back(std::to_string(lineno));
                tokencount.push_back(std::to_string(tokcount));
                tokenoffsets.push_back(std::to_string(tokoffset));

                tokenaccumulator.append_range(linetokens);
            }
        }
    }

    std::vector<std::string> result;

    auto sz = 1 + scriptlineno.size() + tokencount.size() + tokenoffsets.size() + tokenaccumulator.size();
    result.reserve(1 + scriptlineno.size() + tokencount.size() + tokenoffsets.size() + tokenaccumulator.size());

    result.push_back(std::to_string(scriptlineno.size()));
    result.append_range(scriptlineno);
    result.append_range(tokencount);
    result.append_range(tokenoffsets);
    result.append_range(tokenaccumulator);

    return result;
}

bool SLTNativeFunctions::StartScript(PAPYRUS_NATIVE_DECL, RE::Actor* cmdTarget, std::string_view initialScriptName) {
    return ScriptPoolManager::GetSingleton().ApplyScript(cmdTarget, initialScriptName);
}

std::vector<std::string> SLTNativeFunctions::Tokenize(PAPYRUS_NATIVE_DECL, std::string_view input) {
    std::vector<std::string> tokens;
    std::string current;
    bool inQuotes = false;
    bool inBrackets = false;
    size_t i = 0;

    while (i < input.size()) {
        char c = input[i];

        if (!inQuotes && !inBrackets && c == ';') {
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
                    tokens.push_back(current);
                    current.clear();
                    i++;
                }
            } else {
                current += c;
                i++;
            }
        } else if (inBrackets) {
            if (c == ']') {
                inBrackets = false;
                current = '[' + current + c;
                tokens.push_back(current);
                current.clear();
                i++;
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
            } else if (c == '[') {
                inBrackets = true;
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

std::vector<std::string> SLTNativeFunctions::Tokenizev2(PAPYRUS_NATIVE_DECL, std::string_view input) {
    std::vector<std::string> tokens;
    size_t pos = 0;
    size_t len = input.length();
    
    while (pos < len) {
        // Skip whitespace
        while (pos < len && std::isspace(input[pos])) {
            pos++;
        }
        
        if (pos >= len) break;
        
        // Check for comment - everything from ';' to end of line is ignored
        if (input[pos] == ';') {
            break; // Stop processing, ignore rest of line
        }
        
        // Check for $$, ACTUAL HIGHEST PRECEDENCE
        if (pos + 1 < len && input[pos] == '$' && input[pos + 1] == '$') {
            size_t start = pos;
            pos += 2; // Skip $"
            tokens.push_back("$$");
        }
        // Check for $" (dollar-double-quoted interpolation)
        else if (pos + 1 < len && input[pos] == '$' && input[pos + 1] == '"') {
            size_t start = pos;
            pos += 2; // Skip $"
            
            // Find closing quote, handling escaped quotes ""
            while (pos < len) {
                if (input[pos] == '"') {
                    // Check for escaped quote ""
                    if (pos + 1 < len && input[pos + 1] == '"') {
                        pos += 2; // Skip escaped quote pair
                    } else {
                        pos++; // Include the closing quote
                        break; // Found unescaped closing quote
                    }
                } else {
                    pos++;
                }
            }
            
            // Add token with $" prefix, including trailing quote
            tokens.push_back(std::string(input.substr(start, pos - start)));
        }
        // Check for " (double-quoted literal) - SECOND PRECEDENCE
        else if (input[pos] == '"') {
            size_t start = pos;
            pos++; // Skip opening quote
            
            // Find closing quote, handling escaped quotes ""
            while (pos < len) {
                if (input[pos] == '"') {
                    // Check for escaped quote ""
                    if (pos + 1 < len && input[pos + 1] == '"') {
                        pos += 2; // Skip escaped quote pair
                    } else {
                        pos++; // Include the closing quote
                        break; // Found unescaped closing quote
                    }
                } else {
                    pos++;
                }
            }
            
            // Add token with leading and trailing quotes
            tokens.push_back(std::string(input.substr(start, pos - start)));
        }
        // Check for [ (goto label) - THIRD PRECEDENCE
        else if (input[pos] == '[') {
            size_t start = pos;
            pos++; // Skip opening bracket
            
            // Find closing bracket
            while (pos < len && input[pos] != ']') {
                pos++;
            }
            
            if (pos < len && input[pos] == ']') {
                pos++; // Include the closing bracket
            }
            
            // Add token with leading and trailing brackets
            tokens.push_back(std::string(input.substr(start, pos - start)));
        }
        // Check for $$
        // Check for variables
        else if (input[pos] == '$') {
            size_t start = pos;
            pos++;

            while (pos < len){
                auto& chi = input[pos];
                if (isalnum(chi) || chi == '.' || chi == '_') {
                    pos++;
                }
                else if (chi == '<') {
                    pos++;
                    // find closing '>'
                    int counter = 1;
                    while (pos < len) {
                        auto& xi = input[pos];
                        pos++;
                        if (xi == '<') {
                            ++counter;
                        }
                        else if (xi == '>') {
                            --counter;
                        }
                        if (counter <= 0)
                            break;
                    }
                }
                else if (chi == '[') {
                    pos++;
                    // find closing ']'
                    int counter = 1;
                    while (pos < len) {
                        auto& xi = input[pos];
                        pos++;
                        if (xi == '[') {
                            ++counter;
                        }
                        else if (xi == ']') {
                            --counter;
                        }
                        if (counter <= 0)
                            break;
                    }
                }
                else if (chi == '{') {
                    pos++;
                    // find closing '}'
                    int counter = 1;
                    while (pos < len) {
                        auto& xi = input[pos];
                        pos++;
                        if (xi == '{') {
                            ++counter;
                        }
                        else if (xi == '}') {
                            --counter;
                        }
                        if (counter <= 0)
                            break;
                    }
                }
                else
                    break;
                
                //pos++;
            }
            
            tokens.push_back(std::string(input.substr(start, pos - start)));
        }
        // Bare token - collect until whitespace - LOWEST PRECEDENCE
        else {
            size_t start = pos;
            
            while (pos < len && !std::isspace(input[pos])) {
                pos++;
            }
            
            tokens.push_back(std::string(input.substr(start, pos - start)));
        }
    }

    return tokens;
}

namespace {
bool IsValidVariableName(const std::string& name) {
    if (name.empty()) return false;
    
    // less sloppy would be to make sure the <> is appropriately placed and only on target scope
    for (char c : name) {
        if (!std::isalnum(c) && c != '$' && c != '_' && c != '.' && c != '<' && c != '>' && c!= '{' && c != '}' && c != '[' && c != ']') {
            return false;
        }
    }
    
    // Don't allow names starting or ending with dots
    return name.front() != '.' && name.back() != '.';
}

/**
 * FindClosingChar - Searches chars for the paired matching closeChar, skipping nested pairs
 * 
 * startPos - the position of the openChar which we are to search for a mate for (so "a{0}", startPos would be 1 and we should return 3)
 */
size_t FindClosingChar(std::string_view chars, std::size_t startPos, char openChar, char closeChar) {
    // Check if startPos is valid
    if (startPos >= chars.size()) {
        return std::string_view::npos;
    }
    
    // Initialize counter with 1 since we start with one opening character
    size_t openCount = 1;
    
    // Start searching from the position after startPos
    for (size_t i = startPos + 1; i < chars.size(); ++i) {
        if (chars[i] == openChar) {
            // Found another opening character, increment counter
            ++openCount;
        } else if (chars[i] == closeChar) {
            // Found a closing character, decrement counter
            --openCount;
            
            // If counter reaches 0, we found the matching closing character
            if (openCount == 0) {
                return i;
            }
        }
        // For any other character, just continue
    }
    
    // No matching closing character found
    return std::string_view::npos;
}
}

std::vector<std::string> SLTNativeFunctions::TokenizeForVariableSubstitution(PAPYRUS_NATIVE_DECL, std::string_view input) {
    std::vector<std::string> result;
    
    if (input.empty()) {
        return result;
    }
    
    size_t pos = 0;
    std::string currentLiteral;
    
    while (pos < input.length()) {
        size_t openBrace = input.find('{', pos);
        
        if (openBrace == std::string::npos) {
            // No more braces, add remaining text as literal
            currentLiteral += input.substr(pos);
            break;
        }
        
        // Add text before the brace as literal
        currentLiteral += input.substr(pos, openBrace - pos);
        
        // Check for escaped opening brace {{
        if (openBrace + 1 < input.length() && input[openBrace + 1] == '{') {
            currentLiteral += "{";  // Add single literal brace
            pos = openBrace + 2;    // Skip both braces
            continue;
        }
        
        // Find matching closing brace
        size_t closeBrace = FindClosingChar(input, openBrace, '{', '}');
        //input.find('}', openBrace + 1);
        if (closeBrace == std::string::npos) {
            // No matching closing brace, treat as literal
            currentLiteral += input.substr(openBrace);
            break;
        }
        
        /*
        // Check for escaped closing brace }}
        if (closeBrace + 1 < input.length() && input[closeBrace + 1] == '}') {
            // This is an escaped closing brace, not end of variable
            currentLiteral += input.substr(openBrace, closeBrace - openBrace + 2);
            currentLiteral.back() = '}';  // Replace second } with single }
            pos = closeBrace + 2;
            continue;
        }
        */
        
        // Extract variable name between braces
        std::string varName = Util::String::trim(std::string(input.substr(openBrace + 1, closeBrace - openBrace - 1)));
        
        // Trim whitespace from variable name
        //varName.erase(0, varName.find_first_not_of(" \t"));
        //varName.erase(varName.find_last_not_of(" \t") + 1);
        
        if (!varName.empty() && IsValidVariableName(varName)) {
            
            // Add current literal if not empty
            if (!currentLiteral.empty()) {
                result.push_back(currentLiteral);
                currentLiteral.clear();
            }
            
            // Add variable name bare (with $ prefix)
            if (varName.starts_with('$')) {
                result.push_back(varName);
            } else {
                result.push_back("$" + varName);
            }
        } else {
            // Invalid or empty variable name, treat braces as literal
            currentLiteral += input.substr(openBrace, closeBrace - openBrace + 1);
        }
        
        pos = closeBrace + 1;
    }
    
    // Add final literal if not empty
    if (!currentLiteral.empty()) {
        result.push_back(currentLiteral);
    }
    
    return result;
}

std::string SLTNativeFunctions::Trim(PAPYRUS_NATIVE_DECL, std::string_view str) {
    return Util::String::trim(str);
}


#pragma endregion

};

#pragma pop()