scriptname trapsoulgemcontroller extends objectreference
objectreference property objself auto hidden
objectreference property mymagictrap auto hidden
auto state waiting
event onbeginstate()
endevent
event onhit(objectreference akaggressor, form akweapon, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
event onmagiceffectapply(objectreference akcaster, magiceffect akeffect)
endevent
event ongrab()
endevent
endstate
state inmagictrap
event onbeginstate()
endevent
event onhit(objectreference akaggressor, form akweapon, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
event onmagiceffectapply(objectreference akcaster, magiceffect akeffect)
endevent
event ongrab()
endevent
endstate
state disarmed
event onbeginstate()
endevent
endstate
event onactivate(objectreference akactivator)
endevent
event oncellattach()
endevent
event onreset()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1