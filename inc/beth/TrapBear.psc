scriptname trapbear extends objectreference
bool property startopen = true auto
perk property lightfoot auto
bool property checkforlightfootperk = true auto
globalvariable property lightfoottriggerpercent auto
event onreset()
endevent
event onload()
endevent
auto state closed
event onbeginstate()
endevent
event ontriggerenter(objectreference triggerref)
endevent
event onactivate(objectreference triggerref)
endevent
endstate
state open
event onbeginstate()
endevent
event ontriggerenter(objectreference triggerref)
endevent
event onactivate(objectreference triggerref)
endevent
endstate
state busy ;dummy state to prevent interaction while animating
event onbeginstate()
endevent
endstate
event ontriggerenter(objectreference triggerref)
endevent
event onactivate(objectreference triggerref)
endevent
bool function checkperks(objectreference triggerref)
endfunction
int property lvlthreshold1 auto
int property lvldamage1 auto
int property lvlthreshold2 auto
int property lvldamage2 auto
int property lvlthreshold3 auto
int property lvldamage3 auto
int property lvlthreshold4 auto
int property lvldamage4 auto
int property lvlthreshold5 auto
int property lvldamage5 auto
int property lvldamage6 auto
int property traplevel = 2 auto
function resolveleveleddamage()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1