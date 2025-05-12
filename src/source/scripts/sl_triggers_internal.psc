scriptname sl_triggers_internal Hidden

import sl_triggersStatics

; safe access

bool Function SafePrecacheLibraries(string[] _scriptnames) global
    return sl_triggers_internal._PrecacheLibraries(_scriptnames)
EndFunction

bool Function SafeRunOperationOnActor(Actor CmdTargetActor, sl_triggersCmd CmdPrimary, string[] param) global
    return sl_triggers_internal._RunOperationOnActor(CmdTargetActor, CmdPrimary as ActiveMagicEffect, param)
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

bool Function SafeDeleteTrigger(string _extensionKey, string _triggerKey) global
    return sl_triggers_internal._DeleteTrigger(_extensionKey, _triggerKey)
EndFunction

int Function SafeGetSessionId() global
    return sl_triggers_internal._GetSessionId()
EndFunction

bool Function SafeSmartEquals(string a, string b) global
    return sl_triggers_internal._SmartEquals(a, b)
EndFunction

Form Function SafeFindFormByEditorId(string editorId) global
    return sl_triggers_internal._FindFormByEditorId(editorId)
EndFunction

; direct access

bool Function _PrecacheLibraries(string[] _scriptnames) global native

bool Function _RunOperationOnActor(Actor CmdTargetActor, ActiveMagicEffect CmdPrimary, string[] _param) global native

string[] Function _SplitLinesTrimmed(string _fileString) global native

string Function _GetTranslatedString(string _translationKey) global native

ActiveMagicEffect[] Function _GetActiveMagicEffectsForActor(Actor _theActor) global native

bool Function _IsLoaded() global native

string[] Function _SplitLines(string _fileString) global native

string[] Function _Tokenize(string _tokenString) global native

bool Function _DeleteTrigger(string _extensionKey, string _triggerKey) global native

int Function _GetSessionId() global native

bool Function _SmartEquals(string a, string b) global native

Form Function _FindFormByEditorId(string editorId) global native