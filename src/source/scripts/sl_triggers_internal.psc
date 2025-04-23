scriptname sl_triggers_internal Hidden

; safe access
string Function SafeGetTranslatedString(string _translationKey) global
    return sl_triggers_internal.GetTranslatedString(_translationKey)
EndFunction

ActiveMagicEffect[] Function SafeGetActiveMagicEffectsForActor(Actor _theActor) global
    return sl_triggers_internal.GetActiveMagicEffectsForActor(_theActor)
EndFunction

bool Function SafeIsLoaded() global
    return sl_triggers_internal.IsLoaded()
EndFunction

string[] Function SafeSplitLines(string _fileString) global
    return sl_triggers_internal.SplitLines(_fileString)
EndFunction

string[] Function SafeTokenize(string _tokenString) global
    return sl_triggers_internal.Tokenize(_tokenString)
EndFunction

; direct access
string Function GetTranslatedString(string _translationKey) global native

ActiveMagicEffect[] Function GetActiveMagicEffectsForActor(Actor _theActor) global native

bool Function IsLoaded() global native

string[] Function SplitLines(string _fileString) global native

string[] Function Tokenize(string _tokenString) global native