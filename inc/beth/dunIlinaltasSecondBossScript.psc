scriptname dunilinaltassecondbossscript extends actor
actor property skeleton01 auto
actor property skeleton02 auto
actor property skeleton03 auto
objectreference property caster01 auto
spell property resurrection auto
spell property reanimateself auto
scene property bossfightscene auto
auto state waiting
event oncombatstatechanged(actor aktarget, int aecombatstate)
endevent
endstate
state alldone
endstate
;This file was cleaned with PapyrusSourceHeadliner 1