scriptname dlc1radiantcrimemonitorscript extends quest  
quest property parentquest auto
int property stagekillnocrime auto
int property stagekillcrime auto
int property stageassaultnocrime auto
int property stageassaultcrime auto
bool property shutdownimmediately = true auto
race property dlc1vampirebeastrace auto
event onstoryassaultactor(objectreference akvictim, objectreference akattacker, location aklocation, int aicrime)
endevent
event onstorykillactor(objectreference akvictim, objectreference akkiller, location aklocation, int aicrimestatus, int airelationshiprank)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1