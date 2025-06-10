scriptname sl_triggers Hidden

sl_triggersMain Function Main() global ; YES - YOU CAN USE THIS ONE
    return sl_triggersStatics.GetForm_SLT_Main() as sl_triggersMain
endFunction

Form Function       GetForm(string someFormOfFormIdentification) global native ; YES - YOU CAN USE THIS ONE
string[] Function   GetScriptsList() global native ; YES - YOU CAN USE THIS ONE
int Function        GetSessionId() global native ; YES - YOU CAN USE THIS ONE
string Function     GetTranslatedString(string _translationKey) global native ; YES - YOU CAN USE THIS ONE
string[] Function   Tokenize(string _tokenString) global native ; YES - YOU CAN USE THIS ONE