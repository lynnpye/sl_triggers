scriptname mq204hrothgarpushbackscript extends objectreference  
projectile property voicelv01 auto  
projectile property voicelv02 auto  
projectile property voicelv03 auto  
sound property windsfx auto
idle property loosefullbodystagger auto
objectreference property collbox auto
bool property bdebug = true auto hidden
auto state blocking
event onupdate()
endevent
event ontriggerleave(objectreference actronaut)
endevent
event ontriggerenter(objectreference actronaut)
endevent
event onhit(objectreference akaggressor, form akweapon, projectile projectileref, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
endstate
state clear
endstate
;This file was cleaned with PapyrusSourceHeadliner 1