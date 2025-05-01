scriptname zadelectrostimeffect extends activemagiceffect
int property shockchance auto
spell property shockeffect auto
actor property target auto
zadlibs property libs auto
keyword property zad_effectelectrostim auto
event oneffectfinish(actor aktarget, actor akcaster)
endevent
event onunload()
endevent
function doregister()
endfunction
bool function sanitycheck()
endfunction
bool function istarget(string argstring)
endfunction
function onorgasm(string eventname, string argstring, float argnum, form sender)
endfunction
function onedged(string eventname, string argstring, float argnum, form sender)
endfunction
event oneffectstart(actor aktarget, actor akcaster)
endevent
event oncellattach()
endevent
event onload()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1