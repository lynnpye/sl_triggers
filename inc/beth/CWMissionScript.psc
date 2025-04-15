scriptname cwmissionscript extends quest
int property missionnumber auto conditional hidden   ;which "slot" in the campaign does this mission fill... used for mission hooks dialogue in cwcampaign -- formerly this was handled by passing in xmarkers, but know uses the numeric data of the script event
int property acceptedmission auto conditional hidden   ;player has accepted the mission
int property objectivecompleted auto conditional hidden  ;player has completed the objective (ie finished the quest and needs to report success)
float property failday auto conditional hidden    ;used by cwmissionpollforfaildayscript: after accepting the quest, the player has until this gamedayspassed value to complete the mission or it fails
int property campaignphase auto conditional hidden   ;set in registermissiontypewithcampaign() -- what phase the campaign was in when this mission quest started (used to make sure it's in the correct phases)
int property countcampaigns auto conditional  hidden   ;set in registermissiontypewithcampaign() -- what the countcampaigns property in cwscript was when this mission started (used to make sure it's in the correct campaign)
int property foundrendezvous auto conditional hidden   ;player has rendezvoused with his team
int property countresources auto conditional hidden   ;count of resource objects in the attack point garrison
int property countfarms auto conditional hidden    ;count of farm resource objects
int property countmills auto conditional hidden    ;count of farm resource objects
int property countmines auto conditional hidden    ;count of farm resource objects
int property resource1type auto conditional hidden   ;the type of resource in alias resourceobject1
referencealias property fieldco auto
referencealias property missionnumberref auto
referencealias property cwcampaignfieldco auto
quest property cw  auto  
quest property cwcampaign auto  
quest property cwcampaignobj auto  
cwscript property cws auto hidden
cwcampaignscript property cwcampaigns auto hidden
event oninit()
endevent
event onstoryscript(keyword akkeyword, location aklocation, objectreference akref1, objectreference akref2, int aivalue1, int aivalue2)
endevent
function playeracceptsmission()
endfunction
function trytoresetsoldieralias(referencealias aliastoreset)
endfunction
function trytoresetenemysoldieralias(referencealias aliastotry)
endfunction
function enablemapmarkeralias(referencealias mapmarkeralias)
endfunction
function createaliasedsoldierattacker(location holdlocation, referencealias aliastofill, objectreference referencetoplaceat, bool createdisabled = false, bool isguard = true, bool startinfactionnpc = true, int ailevelmod = 4, encounterzone akzone = none)
endfunction
function createaliasedsoldierdefender(location holdlocation, referencealias aliastofill, objectreference referencetoplaceat, bool createdisabled = false, bool isguard = true, bool startinfactionnpc = true, int ailevelmod = 4, encounterzone akzone = none)
endfunction
function createaliasedsoldierally(referencealias aliastofill, objectreference referencetoplaceat, bool createdisabled = false, bool isguard = true, bool startinfactionnpc = true, int ailevelmod = 4, encounterzone akzone = none)
endfunction
function createaliasedsoldierenemy(referencealias aliastofill, objectreference referencetoplaceat, bool createdisabled = false, bool isguard = true, bool startinfactionnpc = true, int ailevelmod = 4, encounterzone akzone = none)
endfunction
function createaliasedcourierally(referencealias aliastofill, objectreference referencetoplaceat, bool createdisabled = false, int ailevelmod = 4, encounterzone akzone = none)
endfunction
function createaliasedcourierenemy(referencealias aliastofill, objectreference referencetoplaceat, bool createdisabled = false, int ailevelmod = 4, encounterzone akzone = none)
endfunction
function createaliasedprisonerally(referencealias aliastofill, objectreference referencetoplaceat, bool createdisabled = false, int ailevelmod = 4, encounterzone akzone = none)
endfunction
function createaliasedprisonerenemy(referencealias aliastofill, objectreference referencetoplaceat, bool createdisabled = false, int ailevelmod = 4, encounterzone akzone = none)
endfunction
function createaliasedsoldierimperial(referencealias aliastofill, objectreference referencetoplaceat, bool createdisabled = false, bool isguard = true, bool startinfactionnpc = true, int ailevelmod = 4, encounterzone akzone = none)
endfunction
function createaliasedsoldiersons(referencealias aliastofill, objectreference referencetoplaceat, bool createdisabled = false, bool isguard = true, bool startinfactionnpc = true, int ailevelmod = 4, encounterzone akzone = none)
endfunction
function createaliasedcourierimperial(referencealias aliastofill, objectreference referencetoplaceat, bool createdisabled = false, int ailevelmod = 4, encounterzone akzone = none)
endfunction
function createaliasedcouriersons(referencealias aliastofill, objectreference referencetoplaceat, bool createdisabled = false, int ailevelmod = 4, encounterzone akzone = none)
endfunction
function createaliasedprisonerimperial(referencealias aliastofill, objectreference referencetoplaceat, bool createdisabled = false, int ailevelmod = 4, encounterzone akzone = none)
endfunction
function createaliasedprisonersons(referencealias aliastofill, objectreference referencetoplaceat, bool createdisabled = false, int ailevelmod = 4, encounterzone akzone = none)
endfunction
function createmissionaliasedactor(referencealias aliastofill,  actorbase actortoplace, objectreference referencetoplaceat, bool createdisabled = false, int ailevelmod = 4, encounterzone akzone = none)
endfunction
function addaliastonpcfaction(referencealias aliastoadd)
endfunction
function resetcommonmissionproperties()
endfunction
function setmissionfailday() ;usually called by stage 10 and as a safety in cwmissionpollforfaildayscript
endfunction
function registermissiontypewithcampaign(int type, int resolutiontype = 0)
endfunction
function flagfieldcowithpotentialmissionfactions(int missiontype = -1, bool shouldremovefromfactions = false, int forcemissionnumber = 0)
endfunction
function flagfieldcowithactivequestfaction(int missiontype = -1, bool shouldremovefromfactions = false)
endfunction
function flagfieldcowithmissionresultfaction(int missiontype = -1, bool missionfailure = false)
endfunction
function removefieldcofromhooksacceptedfaction()
endfunction
function processfieldcofactionsonquestshutdown()
endfunction
function setresourcecountproperties(referencealias resourceobject1, referencealias resourceobject2, referencealias resourceobject3)
endfunction
function registerresourceobjectaliasesforupdate(referencealias resourceobject1 = none, referencealias resourceobject2 = none, referencealias resourceobject3 = none)
endfunction
function unregisterresourceobjectaliasesforupdate(referencealias resourceobject1, referencealias resourceobject2, referencealias resourceobject3)
endfunction
function registerlocationattacked(location holdlocation, location attackedlocation, int ifaction = 0)
endfunction
function toggleoffcomplexwiinteractions(locationalias locationaliastotoggle)
endfunction
function toggleoncomplexwiinteractions(locationalias locationaliastotoggle)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1