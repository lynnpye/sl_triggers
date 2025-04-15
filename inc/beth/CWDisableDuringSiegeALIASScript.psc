scriptname cwdisableduringsiegealiasscript extends referencealias  
cwscript property cw auto
globalvariable property allowdisablingglobal auto
quest property controllingquest auto
int property controllingqueststagetoallowdisable auto
int property controllingqueststagetostopallowingdisable = 9999 auto
bool property requirecontrollingquesttoberunning = false auto
quest property secondaryquest auto
bool property requiresecondaryquesttoberunning = false auto
location property myvirtuallocation  auto
bool property requiresiegequesttobeaccepted = true auto
event oncellload()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1