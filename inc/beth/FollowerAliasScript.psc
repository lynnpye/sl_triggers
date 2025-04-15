scriptname followeraliasscript extends referencealias
dialoguefollowerscript property dialoguefollower auto
event onupdategametime()
endevent
event onunload()
endevent
event oncombatstatechanged(actor aktarget, int aecombatstate)
endevent
event ondeath(actor akkiller)
endevent
globalvariable property playerfollowercount  auto  
faction property currenthirelingfaction auto
;This file was cleaned with PapyrusSourceHeadliner 1