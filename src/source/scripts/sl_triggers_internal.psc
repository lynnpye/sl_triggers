scriptname sl_triggers_internal Hidden

import sl_triggersStatics

; safe access
bool Function SafeCustomResolve(string[] _scriptnames, Actor CmdTargetActor, sl_triggersCmd CmdPrimary, string _code) global
    return sl_triggers_internal._CustomResolve(_scriptnames, CmdTargetActor, CmdPrimary as ActiveMagicEffect, _code)
EndFunction

bool Function SafeCustomResolveActor(string[] _scriptnames, Actor CmdTargetActor, sl_triggersCmd CmdPrimary, string _code) global
    return sl_triggers_internal._CustomResolveActor(_scriptnames, CmdTargetActor, CmdPrimary as ActiveMagicEffect, _code)
EndFunction

bool Function SafeCustomResolveCond(string[] _scriptnames, Actor CmdTargetActor, sl_triggersCmd CmdPrimary, string _p1, string _p2, string _oper) global
    return sl_triggers_internal._CustomResolveCond(_scriptnames, CmdTargetActor, CmdPrimary as ActiveMagicEffect, _p1, _p2, _oper)
EndFunction

bool Function SafeRunOperationOnActor(string[] _scriptnames, Actor CmdTargetActor, sl_triggersCmd CmdPrimary, string[] param) global
    return sl_triggers_internal._RunOperationOnActor(_scriptnames, CmdTargetActor, CmdPrimary as ActiveMagicEffect, param)
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
bool Function _CustomResolve(string[] _scriptnames, Actor CmdTargetActor, ActiveMagicEffect CmdPrimary, string _code) global native

bool Function _CustomResolveActor(string[] _scriptnames, Actor CmdTargetActor, ActiveMagicEffect CmdPrimary, string _code) global native

bool Function _CustomResolveCond(string[] _scriptnames, Actor CmdTargetActor, ActiveMagicEffect CmdPrimary, string _p1, string _p2, string _oper) global native

bool Function _RunOperationOnActor(string[] _scriptnames, Actor CmdTargetActor, ActiveMagicEffect CmdPrimary, string[] _param) global native

string[] Function _SplitLinesTrimmed(string _fileString) global native

string Function _GetTranslatedString(string _translationKey) global native

ActiveMagicEffect[] Function _GetActiveMagicEffectsForActor(Actor _theActor) global native

bool Function _IsLoaded() global native

string[] Function _SplitLines(string _fileString) global native

string[] Function _Tokenize(string _tokenString) global native