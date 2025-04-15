scriptname dunmiddenatronachforgescript extends objectreference
objectreference property offeringbox auto
objectreference property conjurelocation auto
objectreference property masterspear auto
ingredient property firesalts auto
ingredient property voidsalts auto
ingredient property frostsalts auto
spell property flameatronach auto
spell property stormatronach auto
spell property frostatronach auto
actorbase property deadskeever auto
explosion property failureexplosion auto
objectreference property castingnpc auto
actorbase property fireactor auto
actorbase property voidactor auto
actorbase property frostactor auto
spell property debugspell auto
event oninit()
endevent
state ready
event onbeginstate()
endevent
event onactivate(objectreference actronaut)
endevent
endstate
state busy
event onbeginstate()
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1