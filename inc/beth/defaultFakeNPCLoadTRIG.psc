scriptname defaultfakenpcloadtrig extends objectreference
quest property myquest auto
int property prerequisitestage = -1 auto
int property stagetoset auto
actorbase property npctodisable auto
auto state waiting
event ontriggerenter(objectreference actronaut)
endevent
endstate
state finished
event onbeginstate()
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1