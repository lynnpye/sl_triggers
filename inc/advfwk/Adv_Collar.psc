scriptname adv_collar extends quest conditional
actor property playerref auto
spell property zapspell auto
globalvariable property violationreason auto
int property violation_type_slow = 0 auto hidden conditional
int property violation_type_wrong_direction = 1 auto hidden conditional
int property violation_type_location = 2 auto hidden conditional
int property violation_type_leash = 3 auto hidden conditional
int property collar_mode_leash = 0 autoreadonly hidden
int property collar_mode_lead = 1 autoreadonly hidden
int property collar_mode_location = 2 autoreadonly hidden
int property healththresh = 10 auto hidden
int property healthreduce = 25 auto hidden
int property magickareduce = 25 auto hidden
int property checkinterval = 10 auto hidden
objectreference property targetref auto hidden
int property currmode = -1 auto hidden
function maintenance()
endfunction
adv_collar function get() global
endfunction
bool function checkcollar()
endfunction
bool function zap(bool abcheckcollar = true)
endfunction
function damageplayerhealth(int aiamount, int aimin = 50) 
endfunction
function zaptimes(int aitimes = 2, bool abcheckcollar = true)
endfunction
function setleash(objectreference aktarget, int airadius = 300, scene akviolation = none, bool abzapafter = false)
endfunction
function settargetref(objectreference aktarget, int airadius = 300, int aispeed = 1, scene akviolation = none, bool abzapafter = false)
endfunction
function setlocation(location aklocation, scene akviolation = none, bool abzapafter = false)
endfunction
event onupdate()
endevent
function violation(int aireason)
endfunction
function progressupdate(float akcurrent)
endfunction
bool function ischeckvalid()
endfunction
function stoppassive()
endfunction
function pause(string askey)
endfunction
function resume(string askey)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1