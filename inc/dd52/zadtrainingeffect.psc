scriptname zadtrainingeffect extends activemagiceffect
zadlibs property libs auto
sexlabframework property sexlab auto
actor property target auto
bool property terminate auto
function ontrainingdaypassed(int daysremaining)
endfunction
function ontrainingcomplete()
endfunction
int function gettrainingrange()
endfunction
function ontrainingviolation(string eventname, string argstring, float argnum, form sender)
endfunction
function doregistermodevent()
endfunction
event onupdategametime()
endevent
float function initnextticktime()
endfunction
function doregister()
endfunction
int function moddaysremaining(int changeby, int maxrange)
endfunction
event oneffectstart(actor aktarget, actor akcaster)
endevent
event oneffectfinish(actor aktarget, actor akcaster)
endevent
event onload()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1