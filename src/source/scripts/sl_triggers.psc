scriptname sl_triggers Hidden

sl_triggersMain Function Main() global
    return sl_triggersStatics.GetSLTMain()
endFunction

Form Function       GetForm(string someFormOfFormIdentification) global native
string Function     GetNumericLiteral(string token) global native
string[] Function   GetScriptsList() global native
int Function        GetSessionId() global native
string Function     GetTimestamp() global native
string Function     GetTopicInfoResponse(TopicInfo tinfo) global native
string Function     GetTranslatedString(string _translationKey) global native
int Function        NormalizeScriptfilename(string scriptfilename) global native
bool Function       SmartEquals(string a, string b) global native
string[] Function   SplitScriptContentsAndTokenize(string _scriptfilename) global native
string[] Function   Tokenize(string _tokenString) global native
string[] Function   Tokenizev2(string _tokenString) global native
string[] Function   TokenizeForVariableSubstitution(string _tokenString) global native
string Function     Trim(string str) global native