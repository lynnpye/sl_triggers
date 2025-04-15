scriptname wetriggerscript extends objectreference 
keyword property weroadstart auto
keyword property westart auto
objectreference property weholdimperialref auto  ;this is a marker we pass into the sendstoryevent as a way of saying which civil war faction controls the hold this trigger is in
objectreference property weholdsonsref auto  ;this is a marker we pass into the sendstoryevent as a way saying which civil war faction controls the hold this trigger is in
objectreference property weholdimperialcontestedref auto  ;this is a marker we pass into the sendstoryevent as a way of saying which civil war faction controls the hold this trigger is in && the hold is contested
objectreference property weholdsonscontestedref auto  ;this is a marker we pass into the sendstoryevent as a way of saying which civil war faction controls the hold this trigger is in && the hold is contested
quest property cw auto
location property myholdlocation auto
bool property roadencounter auto
bool property triggeronload auto
int property eventnum auto
bool property eventnumclearedafterspawning = true auto
int property myhold auto hidden      ;an integer associated with myholdlocation in terms of cws.contestedhold... 1 = haafingar, 2 = reach, etc. see cwscript
int property myholdowner auto hidden    ;an integer associated with myholdlocation in terms of cws.<hold>owner... 1 = imperials, 2 = sons, etc. see cwscript
bool property myholdiscontested auto hidden  ;true = my hold is currently the contested hold of the civil war
bool property off auto hidden      ;will no longer respond to ontriggerenter()
cwscript property cws auto hidden
event oninit()
endevent
state off
event ontriggerenter(objectreference akactionref)
endevent
event onload()
endevent
function startencounter()
endfunction
endstate
event ontriggerenter(objectreference akactionref)
endevent
event oncellload()
endevent
function startencounter()
endfunction
function rearmtrigger()
endfunction
objectreference function getmyholdfactioncontrollermarker()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1