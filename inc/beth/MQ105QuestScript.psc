scriptname mq105questscript extends quest conditional
location property highhrothgarlocation auto
referencealias property alias_arngeir auto
referencealias property alias_borri auto
quest property mq106 auto
scene property einarthteachscene auto
scene property pushtrialscene auto
scene property sprinttrialscene auto
int property mq105test auto
int property targetshit  auto  conditional
int property scenecount  auto  conditional
int property isprintwordtounlock = 1 auto conditional ; set to which word to unlock (set in quest stage): 1-3
bool property pushtrialwaiting
bool function get()
endfunction
function set(bool value)
endfunction
endproperty
bool property pushtrialweakhit 
bool function get()
endfunction
function set(bool value)
endfunction
endproperty
bool property pushtrialgoodhit
bool function get()
endfunction
function set(bool value)
endfunction
endproperty
bool property sprinttrialplayerready auto conditional
event ongainlos(actor akviewer, objectreference aktarget)
endevent
globalvariable property mq105targetshit  auto  
globalvariable property mq105targetstotal auto  
function setwaiting(bool newval)
endfunction
function incrementpushtargetcount(actor target)
endfunction
function startnewtarget()
endfunction
function sprintstarttriggerchangestate(bool bonenter)
endfunction
function opensprinttrialgate(bool bdoopen = true)
endfunction
function greybeardspeakingeffect(float ftotaltime = 2.0)
endfunction
objectreference property outrotrigger  auto  
imagespacemodifier property greybeardoutroimod  auto  
quest property mq00  auto  
objectreference property outrodust1  auto  
objectreference property outrodust2  auto  
objectreference property outrodust3  auto  
objectreference property outrodust4  auto  
idle property staggeridle  auto  
wordofpower property sprintword  auto  
defaultonenter property tombtrigger  auto  
objectreference property tomb  auto  
idle property bracedpainidle  auto  
objectreference property sprinttrialgate  auto  
objectreference property sprinttrialsuccesstrigger  auto  
sound property ambrumbleshakegreybeards  auto  
;This file was cleaned with PapyrusSourceHeadliner 1