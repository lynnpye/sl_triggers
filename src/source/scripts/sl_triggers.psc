scriptname sl_triggers Hidden

sl_triggersMain Function Main() global
    return sl_triggersStatics.GetSLTMain()
endFunction

; GetForm -> Form
; string someFormofFormIdentification - accepts the following string formats:
;   "<int>"             - parsed as decimal; treated like a FormID() on the C++ side; attempts to load as such and return; note that this is treated as an absolute FormID and will vary based on load order
;   "0x<int>"           - parsed as hexadecimal; treated like a FormID() on the C++ side; attempts to load as such and return; note that this is treated as an absolute FormID and will vary based on load order
;   "<modfile>:<int>"   - parsed as decimal; treated like a mod filename and relative FormID on the C++ side; attempts to load as such and return
;   "<modfile>:0x<int>" - parsed as hexadecimal; treated like a mod filename and relative FormID on the C++ side; attempts to load as such and return
;   "<int>|<modfile>"   - parsed as decimal; treated like a relative FormID and mod filename on the C++ side; attempts to load as such and return
;   "0x<int>|<modfile>" - parsed as hexadecimal; treated like a relative FormID and mod filename on the C++ side; attempts to load as such and return
Form Function       GetForm(string someFormOfFormIdentification) global native
string Function     GetNumericLiteral(string token) global native
string[] Function   GetScriptsList() global native
int Function        GetSessionId() global native

; GetTimestamp -> string
; returns - current, local realtime timestamp formatted as YYYYMMDDhhmmss (Year, Month, Day, hour, minute, second; all padded to the indicated number of digits with leading zeroes)
;   so 2020, October 31, 3:47:23 PM
;   would become "20201031034723"
string Function     GetTimestamp() global
    return sl_triggers.GetTimestampFromComponents(sl_triggers.NormalizeTimestamp(""))
EndFunction

; Pad2 -> string
; int value - integer to pad to 2 decimal digits with '0'; if value is > 99, returns "FF"; if value is < 0, returns "NN"
; returns - decimal converted to string, padded with leading 0's, with only 2 digits allowed; "FF" if value > 99; "NN" if value is < 0
string Function     Pad2(int value) global
    string s = value as string
    if value < 0
        return "--"
    elseif value < 10
        return "0" + s
    elseif value < 100
        return s
    endif
    return "FF"
EndFunction

; Pad4 -> string
; int value - integer to pad to 4 decimal digits with '0'; if value is > 9999, returns "FFFF"; if value is < 0, returns "NNNN"
; returns - decimal converted to string, padded with leading 0's, with only 4 digits allowed; "FFFF" if value > 99; "NNNN" if value is < 0
string Function     Pad4(int value) global
    string s = value as string
    if value < 0
        return "--"
    elseif value < 10
        return "000" + s
    elseif value < 100
        return "00" + s
    elseif value < 1000
        return "0" + s
    elseif value < 10000
        return s
    endif
    return "FFFF"
EndFunction
string Function     GetTimestampFromComponents(int[] timestampComponents) global
    if !timestampComponents || timestampComponents.Length != 6
        return ""
    endif
    return Pad4(timestampComponents[0]) + Pad2(timestampComponents[1]) + Pad2(timestampComponents[2]) + Pad2(timestampComponents[3]) + Pad2(timestampComponents[4]) + Pad2(timestampComponents[5])
EndFunction
string Function     GetTopicInfoResponse(TopicInfo tinfo) global native
string Function     GetTranslatedString(string _translationKey) global native
int Function        NormalizeScriptfilename(string scriptfilename) global native
int[] Function      NormalizeTimestamp(string optionalSourceTimestamp = "") global native
int[] Function      NormalizeTimestampComponents(int[] optionalSourceTimestampComponents = none) global native
bool Function       SmartEquals(string a, string b) global native
string[] Function   SplitScriptContentsAndTokenize(string _scriptfilename) global native
string[] Function   Tokenize(string _tokenString) global native
string[] Function   Tokenizev2(string _tokenString) global native
string[] Function   TokenizeForVariableSubstitution(string _tokenString) global native
string Function     Trim(string str) global native