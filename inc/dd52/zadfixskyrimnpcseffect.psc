scriptname zadfixskyrimnpcseffect extends activemagiceffect
armor property deviceinventory auto
armor property devicerendered auto
actor property target auto
bool property terminate auto
string property devicename auto
zadlibs property libs auto
event oneffectstart(actor aktarget, actor akcaster)
endevent
event oneffectfinish(actor aktarget, actor akcaster)
endevent
function ondeviceremoved(string eventname, string argstring, float argnum, form sender)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1