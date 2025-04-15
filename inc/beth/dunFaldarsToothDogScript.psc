scriptname dunfaldarstoothdogscript extends referencealias
spell property flameresistanceability auto
spell property flamecloakspell auto
magiceffect property dispelleffect auto
objectreference property faldardogenableobject auto
event onload()
endevent
auto state waiting
event onactivate(objectreference akactivator)
endevent
endstate
state flaming
event onupdate()
endevent
event onmagiceffectapply(objectreference akcaster, magiceffect akeffect)
endevent
endstate
state deactive
endstate
event ondeath(actor akkiller)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1