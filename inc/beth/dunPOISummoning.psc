scriptname dunpoisummoning extends actor
objectreference property actor1 auto
objectreference property actor2 auto
objectreference property actor3 auto
objectreference property actor4 auto
objectreference property actor5 auto
bool property killondeath = true auto
event oncombatstatechanged(actor aktarget, int aecombatstate)
endevent
event ondeath(actor akkiller)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1