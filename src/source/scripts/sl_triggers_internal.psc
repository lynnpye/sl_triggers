scriptname sl_triggers_internal Hidden

; safe access
bool Function SafeCIStringCompare(string tweedledum, string tweedledee) global
    ; I know what I did. Read the book and understand the function. :)
    return sl_triggers_internal._CIStringCompare(tweedledee, tweedledum)
EndFunction

string Function SafeGetTranslatedString(string _translationKey) global
    return sl_triggers_internal._GetTranslatedString(_translationKey)
EndFunction

ActiveMagicEffect[] Function SafeGetActiveMagicEffectsForActor(Actor _theActor) global
    return sl_triggers_internal._GetActiveMagicEffectsForActor(_theActor)
EndFunction

bool Function SafeIsLoaded() global
    return sl_triggers_internal._IsLoaded()
EndFunction

string[] Function SafeSplitLines(string _fileString) global
    return sl_triggers_internal._SplitLines(_fileString)
EndFunction

string[] Function SafeTokenize(string _tokenString) global
    return sl_triggers_internal._Tokenize(_tokenString)
EndFunction

; direct access
bool Function _CIStringCompare(string tweedledum, string tweedledee) global native

string Function _GetTranslatedString(string _translationKey) global native

ActiveMagicEffect[] Function _GetActiveMagicEffectsForActor(Actor _theActor) global native

bool Function _IsLoaded() global native

string[] Function _SplitLines(string _fileString) global native

string[] Function _Tokenize(string _tokenString) global native