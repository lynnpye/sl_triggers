scriptname mg06armillaryscript extends objectreference  conditional
quest property mg06  auto  
int property readyforspells auto conditional
int property positionvar auto conditional
magiceffect property flameeffect  auto
magiceffect property frosteffect  auto
function attenuatefire(int statenumber, int animeventnumber)
endfunction
function attenuatefrost(int statenumber, int animeventnumber)
endfunction
event onload()
endevent
event onanimationevent(objectreference source, string eventstring)
endevent
state initial
event onactivate(objectreference triggerref)
endevent
endstate
state position01
event onmagiceffectapply(objectreference caster, magiceffect spelleffect)
endevent
endstate
state position02
event onmagiceffectapply(objectreference caster, magiceffect spelleffect)
endevent
endstate
state position03
event onmagiceffectapply(objectreference caster, magiceffect spelleffect)
endevent
endstate
state position04
event onmagiceffectapply(objectreference caster, magiceffect spelleffect)
endevent
endstate
state position05
event onmagiceffectapply(objectreference caster, magiceffect spelleffect)
endevent
endstate
state position06
event onmagiceffectapply(objectreference caster, magiceffect spelleffect)
endevent
endstate
objectreference property dome01ref  auto  
objectreference property dome02ref  auto  
objectreference property dome03ref  auto  
referencealias property mg06crystal  auto  
objectreference property button01  auto  
objectreference property button02  auto  
objectreference property button03  auto  
keyword property magicdamagefire  auto  
keyword property magicdamagefrost  auto  
;This file was cleaned with PapyrusSourceHeadliner 1