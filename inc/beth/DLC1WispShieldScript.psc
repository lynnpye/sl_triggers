scriptname dlc1wispshieldscript extends activemagiceffect  
spell property dlc1abkeeperwispcloak auto
magiceffect property dlc1pcvampireabsorbhealthconcaimed  auto  
magiceffect property dlc1sundamageffaimedarea  auto  
magiceffect property dlc1sundamageffaimed auto
magiceffect property dlc1pcvampireabsorbhealthffaimed auto
visualeffect property fxdlc1sckeepereffect auto
event oneffectstart(actor target, actor caster) 
endevent
event oneffectfinish(actor aktarget, actor akcaster)  
endevent
event ondying(actor mykiller) 
endevent
event onmagiceffectapply(objectreference akcaster, magiceffect akeffect)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1