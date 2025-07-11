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

void FuzPlay(PAPYRUS_NATIVE_DECL, std::string_view fuzFileName) {

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
                if (scriptname.ends_with(".ini") || scriptname.ends_with(".sltscript") || scriptname.ends_with(".json")) {
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

    std::wstring key_utf16 = stl::utf8_to_utf16(input).value_or(L""s);
    transinfo.key = key_utf16.c_str();

    transinfo.result = std::addressof(result);

    translator->Translate(std::addressof(transinfo));

    if (!result.empty()) {
        std::string actualresult = stl::utf16_to_utf8(result).value();
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
        
        scrfn = std::string(scriptfilename) + ".json";
        scrpath = GetScriptfilePath(scrfn);
        if (!scrpath.empty() && fs::exists(scrpath)) {
            return 10;
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
            if (scrfn == ".json") {
                return 1;
            }
        }
    }

    return 0;
}

bool SLTNativeFunctions::RunOperationOnActor(PAPYRUS_NATIVE_DECL, RE::Actor* cmdTarget, RE::ActiveEffect* cmdPrimary,
    std::vector<std::string> tokens) {
    return OperationRunner::RunOperationOnActor(cmdTarget, cmdPrimary, tokens);
}

void SLTNativeFunctions::SetExtensionEnabled(PAPYRUS_NATIVE_DECL, std::string_view extensionKey, bool enabledState) {
    //SLTExtensionTracker::SetEnabled(extensionKey, enabledState);
    FunctionLibrary* funlib = FunctionLibrary::ByExtensionKey(extensionKey);

    //SLTStackAnalyzer::Walk(stackId);
    if (funlib) {
        funlib->enabled = enabledState;
        logger::debug("SetExtensionEnabled: functionLibrary->extensionKey({}) ->enabled({})", funlib->extensionKey, funlib->enabled);
        FunctionLibrary::RefreshFunctionLibraryCache();
    } else {
        logger::error("Unable to find function library for extensionKey '{}' to set enabled to '{}'", extensionKey, enabledState);
    }
}

namespace {
bool isNumeric(std::string_view str, float& outValue) {
    const char* begin = str.data();
    const char* end = begin + str.size();

    auto result = std::from_chars(begin, end, outValue);
    return result.ec == std::errc() && result.ptr == end;
}
}

bool SLTNativeFunctions::SmartEquals(PAPYRUS_NATIVE_DECL, std::string_view a, std::string_view b) {
    float aNum = 0.0, bNum = 0.0;
    bool aIsNum = isNumeric(a, aNum);
    bool bIsNum = isNumeric(b, bNum);

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

/*
std::vector<std::string> SLTNativeFunctions::SplitFileContents(PAPYRUS_NATIVE_DECL, std::string_view content_view) {
    std::vector<std::string> lines;
    size_t start = 0;
    size_t i = 0;
    std::string content(content_view.data());
    std::string tmpstr;
    size_t len = content.length();

    while (i < len) {
        if (content[i] == '\r') {
            if (i > start) {
                tmpstr = Util::String::truncateAt(content.substr(start, i - start), ';');
                lines.push_back(tmpstr);
            }
            if (i + 1 < len && content[i + 1] == '\n') {
                i += 2;  // Windows CRLF
            } else {
                i += 1;  // Classic Mac CR
            }
            start = i;
        } else if (content[i] == '\n') {
            if (i > start) {
                tmpstr = Util::String::truncateAt(content.substr(start, i - start), ';');
                lines.push_back(tmpstr);
            }
            i += 1;
            start = i;
        } else {
            i += 1;
        }
    }

    // Add last line if there's any remaining
    if (start < len) {
        tmpstr = Util::String::truncateAt(content.substr(start), ';');
        lines.push_back(tmpstr);
    }

    return lines;
}
*/

/*
std::vector<std::string> SLTNativeFunctions::SplitScriptContents(PAPYRUS_NATIVE_DECL, std::string_view scriptfilename) {
    std::vector<std::string> lines;
    fs::path filepath = GetScriptfilePath(scriptfilename);

    if (fs::exists(filepath) && fs::is_regular_file(filepath)) {
        std::ifstream file(filepath);
        if (file.good()) {
            std::string line;
            while (std::getline(file, line)) {
                line = Util::String::truncateAt(Util::String::trim(line), ';');
                lines.push_back(line);
            }
        }
    }

    return lines;
}
*/

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
        
        // Check for $" (dollar-double-quoted interpolation) - HIGHEST PRECEDENCE
        if (pos + 1 < len && input[pos] == '$' && input[pos + 1] == '"') {
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
        if (!std::isalnum(c) && c != '_' && c != '.' && c != '<' && c != '>') {
            return false;
        }
    }
    
    // Don't allow names starting or ending with dots
    return name.front() != '.' && name.back() != '.';
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
        size_t closeBrace = input.find('}', openBrace + 1);
        if (closeBrace == std::string::npos) {
            // No matching closing brace, treat as literal
            currentLiteral += input.substr(openBrace);
            break;
        }
        
        // Check for escaped closing brace }}
        if (closeBrace + 1 < input.length() && input[closeBrace + 1] == '}') {
            // This is an escaped closing brace, not end of variable
            currentLiteral += input.substr(openBrace, closeBrace - openBrace + 2);
            currentLiteral.back() = '}';  // Replace second } with single }
            pos = closeBrace + 2;
            continue;
        }
        
        // Extract variable name between braces
        std::string varName = std::string(input.substr(openBrace + 1, closeBrace - openBrace - 1));
        
        // Trim whitespace from variable name
        varName.erase(0, varName.find_first_not_of(" \t"));
        varName.erase(varName.find_last_not_of(" \t") + 1);
        
        if (!varName.empty() && IsValidVariableName(varName)) {
            
            // Add current literal if not empty
            if (!currentLiteral.empty()) {
                result.push_back(currentLiteral);
                currentLiteral.clear();
            }
            
            // Add variable name bare (with $ prefix)
            result.push_back("$" + varName);
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