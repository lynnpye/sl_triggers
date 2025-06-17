scriptname sl_triggers_internal Hidden

Function            CleanupThreadContext(int threadContextHandle) global native ; move along
bool Function       DeleteTrigger(string _extensionKey, string _triggerKey) global native ; I strongly advise against it
string[] Function   GetTriggerKeys(string extensionKey) global native ; I would pass
bool Function       PrepareContextForTargetedScript(Actor _targetActor, string _scriptname) global native ; also not likely for you
int Function        Pung(int threadContextHandle) global native ; not for external application
Form Function       ResolveFormVariable(int threadContextHandle, string variableName) global native ; nope, not this one either
string Function     ResolveValueVariable(int threadContextHandle, string variableName) global native ; colder
bool Function       RunOperationOnActor(Actor CmdTargetActor, ActiveMagicEffect CmdPrimary, string[] _param) global native ; giddyup cowboy
Function            SetExtensionEnabled(string extensionKey, bool enabledState) global native ; heh... heheh... hehahahahahhahahahh
bool Function       StartScript(Actor CmdTargetActor, string initialScriptName) global native ; meh... I wouldn't bother if I were you