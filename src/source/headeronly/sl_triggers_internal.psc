scriptname sl_triggers_internal hidden
bool function           deletetrigger(string _extensionkey, string _triggerkey) global native
string[] function       gettriggerkeys(string extensionkey) global native
function                logdebug(string logmsg) global native
function                logerror(string logmsg) global native
function                loginfo(string logmsg) global native
function                logwarn(string logmsg) global native
bool function           runoperationonactor(actor cmdtargetactor, activemagiceffect cmdprimary, string[] _param) global native
bool function           runsltrmain(activemagiceffect cmdprimary, string scriptfilename, string[] strlist, int[] intlist, float[] floatlist, bool[] boollist, form[] formlist) global native
function                setextensionenabled(string extensionkey, bool enabledstate) global native
bool function           startscript(actor cmdtargetactor, string initialscriptname) global native
;This file was cleaned with PapyrusSourceHeadliner 1