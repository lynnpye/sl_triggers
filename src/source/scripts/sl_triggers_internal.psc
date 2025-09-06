scriptname sl_triggers_internal Hidden

bool Function           DeleteTrigger(string _extensionKey, string _triggerKey) global native
string[] Function       GetTriggerKeys(string extensionKey) global native
Function                LogDebug(string logmsg) global native
Function                LogError(string logmsg) global native
Function                LogInfo(string logmsg) global native
Function                LogWarn(string logmsg) global native
string[] Function       MCMGetAttributeData(bool isTriggerAttribute, string extensionKey, string attrName, string info) global native
string[] Function       MCMGetLayout(bool isTriggerAttribute, string extensionKey, string dataFile = "") global native
string[] Function       MCMGetLayoutData(bool isTriggerAttribute, string extensionKey, string layout, int row) global native
bool Function           RunOperationOnActor(Actor CmdTargetActor, ActiveMagicEffect CmdPrimary, string[] _param) global native
Function                SetExtensionEnabled(string extensionKey, bool enabledState) global native
Function                SetCombatSinkEnabled(bool isEnabled) global native
Function                SetEquipSinkEnabled(bool isEnabled) global native
Function                SetHitSinkEnabled(bool isEnabled) global native
Function                SetActivateSinkEnabled(bool isEnabled) global native
Function                SetSwimHookEnabled(bool isEnabled) global native
bool Function           IsCombatSinkEnabled() global native
bool Function           IsEquipSinkEnabled() global native
bool Function           IsHitSinkEnabled() global native
bool Function           IsActivateSinkEnabled() global native
bool Function           IsSwimHookEnabled() global native
bool Function           StartScript(Actor CmdTargetActor, string initialScriptName) global native