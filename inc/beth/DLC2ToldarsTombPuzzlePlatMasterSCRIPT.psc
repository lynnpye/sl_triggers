scriptname dlc2toldarstombpuzzleplatmasterscript extends objectreference hidden 
keyword property linkcustom01 auto
keyword property linkcustom02 auto
keyword property linkcustom03 auto
keyword property linkcustom04 auto
keyword property linkcustom05 auto
keyword property linkcustom06 auto
keyword property linkcustom07 auto
keyword property linkcustom08 auto
keyword property linkcustom09 auto
objectreference property hazard01 auto 
objectreference property hazard02 auto 
objectreference property hazard03 auto 
objectreference property hazard04 auto 
objectreference property hazard05 auto 
objectreference property hazard06 auto 
int property lvlthreshold01 auto
int property lvlthreshold02 auto
int property lvlthreshold03 auto
int property lvlthreshold04 auto
int property lvlthreshold05 auto
bool property bpuzzlesolved = false auto hidden
int property icountsafehits auto hidden
quest property myquest auto
int property stagetosetonfirstfail auto
int property stagetosetonfirsthalfwaypoint auto
int property stagetosetoncomplete auto
bool property balreadyfailedonce auto
bool property balreadyhithalfwaypoint auto
bool property showdebugmessages = true auto
event ontriggerleave(objectreference triggerref)
endevent
function pressureplatehit(bool bsafehit)
endfunction
function suspendplates()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1