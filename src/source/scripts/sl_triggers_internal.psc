scriptname sl_triggers_internal Hidden

bool Function       DeleteTrigger(string _extensionKey, string _triggerKey) global native ; I strongly advise against it
string[] Function   GetTriggerKeys(string extensionKey) global native ; I would pass
bool Function       RunOperationOnActor(Actor CmdTargetActor, ActiveMagicEffect CmdPrimary, string[] _param) global native ; giddyup cowboy
Function            SetExtensionEnabled(string extensionKey, bool enabledState) global native ; heh... heheh... hehahahahahhahahahh
bool Function       StartScript(Actor CmdTargetActor, string initialScriptName) global native ; meh... I wouldn't bother if I were you