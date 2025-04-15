scriptname traptriggerhinge extends traptriggerbase
keyword property trapkeyword auto
message property lockpickmessage auto
sound property disarmsound auto
event oncellload()
endevent
auto state active
event onbeginstate()
endevent
event ontriggerenter(objectreference triggerref)
endevent
event ontriggerleave(objectreference triggerref)
endevent
event onmagiceffectapply(objectreference akcaster, magiceffect akeffect)
endevent
event onactivate(objectreference triggerref)
endevent
event onlockstatechanged()
endevent
event onhit(objectreference akaggressor, form akweapon, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
endstate
state disarmed
event onbeginstate()
endevent
endstate
state triggered
event onbeginstate()
endevent
endstate
event ontriggerenter(objectreference triggerref)
endevent
event ontriggerleave(objectreference triggerref)
endevent
state inactive
endstate
event onreset()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1