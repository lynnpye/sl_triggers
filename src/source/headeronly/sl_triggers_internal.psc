scriptname sl_triggers_internal hidden
string function         createtempfile(string optionalfileextension, string optionalfilename) global native
bool function           deletetrigger(string _extensionkey, string _triggerkey) global native
string[] function       gettriggerkeys(string extensionkey) global native
function                logdebug(string logmsg) global native
function                logerror(string logmsg) global native
function                loginfo(string logmsg) global native
function                logwarn(string logmsg) global native
bool function           runoperationonactor(actor cmdtargetactor, activemagiceffect cmdprimary, string[] _param) global native
function                setextensionenabled(string extensionkey, bool enabledstate) global native
function                setcombatsinkenabled(bool isenabled) global native
function                setequipsinkenabled(bool isenabled) global native
function                sethitsinkenabled(bool isenabled) global native
bool function           iscombatsinkenabled() global native
bool function           isequipsinkenabled() global native
bool function           ishitsinkenabled() global native
bool function           startscript(actor cmdtargetactor, string initialscriptname) global native
;This file was cleaned with PapyrusSourceHeadliner 1