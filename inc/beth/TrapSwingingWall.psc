scriptname trapswingingwall extends movingtrap
float property initialdelay = 0.25 auto
string property fireanim = "90for" auto hidden
string property fireevent = "done" auto hidden
string property resetanim = "90back" auto hidden
string property resetevent = "transstop" auto hidden
string property startswunganim = "90end" auto hidden
string property rearmanim = "rearm" auto hidden
string property rearmevent = "transstart" auto hidden
string property halfanim = "90half" auto hidden
string property halfanimevent = "transhalf" auto hidden
string property ninetyfireanim = "90for" auto hidden
string property ninetyresetanim = "90back" auto hidden
string property ninetystartswunganim = "90end" auto hidden
string property ninetyhalfanim = "90half" auto hidden
string property oneeightyfireanim = "180for" auto hidden
string property oneeightyresetanim = "180back" auto hidden
string property oneeightystartswunganim = "180end" auto hidden
string property oneeightyhalfanim = "180half" auto hidden
string property twoseventyfireanim = "270for" auto hidden
string property twoseventyresetanim = "270back" auto hidden
string property twoseventystartswunganim = "270end" auto hidden
string property twoseventyhalfanim = "270half" auto hidden
bool property startswung = false auto
bool property animssetup = false auto hidden
int property actorsintrigger = 0 auto hidden
int property rotation = 0 auto
event ontriggerenter(objectreference triggerref)
endevent
event ontriggerleave(objectreference triggerref)
endevent
event oncellattach()
endevent
function firetrap()
endfunction
function resetlimiter()
endfunction
function setupanims()
endfunction
event onreset()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1