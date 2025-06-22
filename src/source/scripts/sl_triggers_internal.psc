scriptname sl_triggers_internal Hidden

bool Function           DeleteTrigger(string _extensionKey, string _triggerKey) global native
string[] Function       GetTriggerKeys(string extensionKey) global native
Function                LogDebug(string logmsg) global native
Function                LogError(string logmsg) global native
Function                LogInfo(string logmsg) global native
Function                LogWarn(string logmsg) global native
bool Function           RunOperationOnActor(Actor CmdTargetActor, ActiveMagicEffect CmdPrimary, string[] _param) global native
Function                SetExtensionEnabled(string extensionKey, bool enabledState) global native
bool Function           StartScript(Actor CmdTargetActor, string initialScriptName) global native