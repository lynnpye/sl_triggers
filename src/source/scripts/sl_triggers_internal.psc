scriptname sl_triggers_internal Hidden

import sl_triggersStatics

; safe access

bool Function SafeRunOperationOnActor(string[] _scriptnames, Actor CmdTargetActor, string[] param, sl_triggersCmd CmdPrimary) global
    return sl_triggers_internal._RunOperationOnActor(_scriptnames, CmdTargetActor, param, CmdPrimary as ActiveMagicEffect)
EndFunction

bool Function SafeRunRequestedScript(string _scriptname, string _globalfuncname) global
    return sl_triggers_internal._RunRequestedScript(_scriptname, _globalfuncname)
EndFunction

string[] Function SafeSplitLinesTrimmed(string _fileString) global
    return sl_triggers_internal._SplitLinesTrimmed(_fileString)
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
bool Function _RunOperationOnActor(string[] _scriptnames, Actor CmdTargetActor, string[] _param, ActiveMagicEffect CmdPrimary) global native

bool Function _RunRequestedScript(string _scriptname, string _globalfuncname) global native

string[] Function _SplitLinesTrimmed(string _fileString) global native

string Function _GetTranslatedString(string _translationKey) global native

ActiveMagicEffect[] Function _GetActiveMagicEffectsForActor(Actor _theActor) global native

bool Function _IsLoaded() global native

string[] Function _SplitLines(string _fileString) global native

string[] Function _Tokenize(string _tokenString) global native