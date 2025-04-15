scriptname dlc1vq01puzzlebrazierscript extends objectreference  
message property wontbudge auto
objectreference property puzzlecontroller auto
bool property solved = false auto hidden
bool property locked = false auto hidden
int property brazierid auto
objectreference property xmarkerinner auto
objectreference property xmarkerouter auto
bool property isanimating = false auto hidden
effectshader property castshader auto 
visualeffect property targvfx auto 
sound property qstseranatombbrazierfirelpm auto
sound property fxseranatombdrainlife2d auto
int property flamesoundinstanceid auto hidden
auto state mid
event oncellattach()
endevent 
event onbeginstate()
endevent
event onactivate(objectreference triggerref)
endevent
endstate
state inner
event onbeginstate()
endevent
event onactivate(objectreference triggerref)
endevent
event onendstate()
endevent
endstate
state outer
event onbeginstate()
endevent
event onactivate(objectreference triggerref)
endevent
event onendstate()
endevent
endstate
state done
event onbeginstate()
endevent
event onactivate(objectreference triggerref)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1