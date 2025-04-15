scriptname weda02cultistscript extends referencealias  
quest property weda02 auto
book  property da02book auto
event oncombatstatechanged(actor aktarget, int aecombatstate)
endevent
event ondeath(actor akkiller)
endevent
event onactivate(objectreference akactionref)
endevent
event onitemremoved(form akbaseitem, int aiitemcount, objectreference akitemreference, objectreference akdestcontainer)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1