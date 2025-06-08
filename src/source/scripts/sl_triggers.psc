scriptname sl_triggers Hidden

sl_triggersMain Function Main() global ; YES - YOU CAN USE THIS ONE
    return MainQuest() as sl_triggersMain
endFunction

int Function        GetActiveScriptCount() global native ; YES - YOU CAN USE THIS ONE
Form Function       GetForm(string someFormOfFormIdentification) global native ; YES - YOU CAN USE THIS ONE
string[] Function   GetScriptsList() global native ; YES - YOU CAN USE THIS ONE
int Function        GetSessionId() global native ; YES - YOU CAN USE THIS ONE
string Function     GetTranslatedString(string _translationKey) global native ; YES - YOU CAN USE THIS ONE
bool Function       IsLoaded() global native ; YES - YOU CAN USE THIS ONE
Quest Function      MainQuest() global native ; YES - YOU CAN USE THIS ONE
bool Function       SmartEquals(string a, string b) global native ; YES - YOU CAN USE THIS ONE
string[] Function   Tokenize(string _tokenString) global native ; YES - YOU CAN USE THIS ONE
