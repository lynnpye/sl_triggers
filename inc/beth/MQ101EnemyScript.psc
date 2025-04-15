scriptname mq101enemyscript extends referencealias  
int property ondeathstage  auto  
int property onhitstage  auto  
int property oncombatstage  auto  
int property prereqstage auto
int property myfactionpath = 1 auto
event oncombatstatechanged(actor aktarget, int aecombatstate)
endevent
event ondeath(actor akkiller)
endevent
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1