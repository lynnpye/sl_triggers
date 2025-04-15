scriptname cwfortopengatescript extends quest  conditional 
int property enteringorleaving auto hidden conditional  ;0 = unset, 1 = entering, 2 = leaving -- set in start up stage based on which marker actor is closer to
referencealias property gatelever auto
referencealias property gatekeeper auto
referencealias property triggerbox auto
scene property cwfortopengatescene auto
globalvariable property debugon auto
;This file was cleaned with PapyrusSourceHeadliner 1