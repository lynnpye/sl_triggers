scriptname mq101bearscript extends referencealias  
int property deathstage = 750 auto  
int property combatstage =730 auto  
int property prereqstage = 500 auto
event oncombatstatechanged(actor aktarget, int aecombatstate)
endevent
event ondeath(actor akkiller)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1