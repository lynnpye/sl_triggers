scriptname sprigganfxscript extends activemagiceffect  
visualeffect property sprigganfxattacheffect auto
spell property crsprigganheal01 auto
spell property crspriggancallcreatures auto
idle property ffselfidle  auto  
event oneffectstart(actor target, actor caster)
endevent
event oneffectfinish(actor aktarget, actor akcaster)
endevent
event ongetup(objectreference akfurniture)
endevent
event ondeath(actor mykiller)
endevent
event oncombatstatechanged(actor aktarget, int aecombatstate)
endevent
event onenterbleedout()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1