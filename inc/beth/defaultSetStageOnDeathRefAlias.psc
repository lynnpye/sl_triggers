scriptname defaultsetstageondeathrefalias extends referencealias
quest property myqst auto
int property prereqstage = -1 auto
int property stagetoset auto
auto state waiting
event ondeath(actor killer)
endevent
endstate
state inactive
endstate
;This file was cleaned with PapyrusSourceHeadliner 1