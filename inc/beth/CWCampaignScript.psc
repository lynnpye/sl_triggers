scriptname cwcampaignscript extends quest  conditional
globalvariable property debugon auto conditional     ;0 = unset, 1 = set - show warnings
int property initcampaign auto conditional hidden ;0 = unset, 1 = running through initialization quest stages, -1 = finished
int property costpatrol auto conditional hidden 
int property ownerpatrol1 auto conditional hidden 
int property ownerpatrol2 auto conditional hidden 
int property ownerpatrol3 auto conditional hidden 
int property ownerpatrol4 auto conditional hidden 
int property ownerpatrol5 auto conditional hidden 
int property mission1type auto conditional  hidden       
int property mission2type auto conditional hidden 
int property mission3type auto conditional hidden 
int property resolutionmissiontype auto conditional hidden
int property acceptedhooks auto conditional hidden      ;0 = un/reset, 1 = player has heard the opening mission hooks (unlocks mission topics)
int property acceptedmission auto conditional hidden     ;0 = un/reset, 1 = player has accepted a mission (suppresses other mission topics)
int property acceptedtutorialhooks auto conditional hidden   ;0 = un/reset, 1 = player has heard the opening mission hooks (unlocks mission topics)
int property resolutionphase auto conditional hidden   ; n = at what cwcampaignphase are we considered to be in the "resolution" phase, meaning the final mission (which can also resolve offscreen if player is absent)
int property resolveoffscreen auto conditional hidden   ;0 = un/reset, 1 = waiting for cw to resolve offscreen and set this quest's stage 255 to stop it
int property currentattackdelta auto conditional hidden
float property acceptdays auto conditional  hidden    ;(set in stage 1) how many days we allow the player to accept a mission before advancing the phase without him
float property nextphaseday auto conditional hidden    ;at start of each phase, gamedayspassed + acceptdays, after which we advance the phase
float property missiondays auto conditional hidden    ;(set in stage 1) how many days we allow the player to complete an accepted mission before we consider it a failure
int property failedmission auto conditional hidden    ;0 = unset, -n = player got dialog about failing mission, n = player just failed a mission of the numeric mission type and should get dialogue about it (see comment under property "mission1type" above
int property completedmission auto conditional hidden   ;0 = unset, -n player got dialog about completing mission, n = player just completed a mission of the numeric mission type and should get dialgoue about it (see comment under property "mission1type" above
int property missionacceptancepollwait auto hidden       ;how long to wait between ticks to poll for missionacceptance (see pollformissionacceptance())
int property attackdeltabonusforkillingcapitalgarrison auto hidden      ;how many points to add to the attackdelta if the player killed all the guards in the capital location
float property attackdeltagarrisonvaluemodifierfordestroyingresource auto hidden  ;a multiplier to a garrison's cost when turning that garrison into a currentattackdelta points... when the player destroys a resource, the garrison should contribute less to the attack delta. this is the multiplier that reflects that. set in oninit()
quest property cw  auto  
quest property cwmission00 auto
quest property cwsiege auto
referencealias property campaignstartmarker auto
referencealias property rikke auto
referencealias property galmar auto
referencealias property genericfieldcoimperial auto
referencealias property genericfieldcosons auto
referencealias property fieldco auto   ;actual field officer for player's faction (rikke, or galmar)
referencealias property enemyfieldco auto  ;actual field officer for player's enemy (generic field commander imperial / sons)
locationalias property hold  auto
locationalias property garrison1 auto
locationalias property garrison2 auto
locationalias property garrison3 auto
locationalias property garrison4 auto
referencealias property garrison1resourceobject auto
referencealias property garrison2resourceobject auto
referencealias property garrison3resourceobject auto
referencealias property garrison4resourceobject auto
locationalias property fort auto
locationalias property garrisondefenderonly1 auto
locationalias property garrisondefenderonly2 auto
locationalias property garrisondefenderonly3 auto
locationalias property garrisondefenderonly4 auto
locationalias property garrisondefenderonly5 auto
locationalias property garrisondefenderonly6 auto
referencealias property garrisondefenderonly1resourceobject auto
referencealias property garrisondefenderonly2resourceobject auto
referencealias property garrisondefenderonly3resourceobject auto
referencealias property garrisondefenderonly4resourceobject auto
locationalias property capital auto
locationalias property capitalhq auto
locationalias property campimperial auto
locationalias property campsons auto
locationalias property fieldhq auto
locationalias property enemyfieldhq auto
referencealias property campenableimperial auto
referencealias property campenablesons auto
referencealias property campimperiallocationcentermarker auto
referencealias property campsonslocationcentermarker auto
referencealias property capitalhqmarker auto
locationalias property patrols auto
referencealias property patrolsdefaultenableimperial auto
referencealias property patrolsdefaultenablesons auto
referencealias property patrolsenableimperial1 auto
referencealias property patrolsenableimperial2 auto
referencealias property patrolsenableimperial3 auto
referencealias property patrolsenableimperial4 auto
referencealias property patrolsenableimperial5 auto
referencealias property patrolsenablesons1 auto
referencealias property patrolsenablesons2 auto
referencealias property patrolsenablesons3 auto
referencealias property patrolsenablesons4 auto
referencealias property patrolsenablesons5 auto
referencealias property cwcampaignobjfieldco auto
referencealias property cwcampaignobjfactionleader auto
referencealias property cwcampaignobjcampaignstartmarker auto
locationalias property cwcampaignobjcampaignhold auto
globalvariable property gamedayspassed auto
globalvariable property cwcampaignphase auto
globalvariable property resourcedestroyedatstage auto
globalvariable property cwdebugskippurchase auto  ;if == 1, skips purchaing garrisons
keyword property cwowner auto
keyword property cwcost auto
keyword property cwpurchasedbyattacker auto
keyword property cwmissionstart auto
keyword property cwresolution01start  auto  ;attack settlement capital resolution mission
keyword property cwresolution02start  auto  ;defend settlement capital resolution mission
keyword property cwmissiontutorialstart auto
keyword property cwsiegestart auto  ;used to start siege attack and defend quests for cities
keyword property loctypecity auto
keyword property loctypehabitation auto
locationreftype property cwsoldier auto
locationreftype property cwpatroldefault auto
locationreftype property cwpatrol1 auto
locationreftype property cwpatrol2 auto
locationreftype property cwpatrol3 auto
locationreftype property cwpatrol4 auto
locationreftype property cwpatrol5 auto
objectreference property cwmission1ref auto ;passed in to sendstoryevent when generating mission quests as a way to identify which mission #
objectreference property cwmission2ref auto ;passed in to sendstoryevent when generating mission quests as a way to identify which mission #
objectreference property cwmission3ref auto ;passed in to sendstoryevent when generating mission quests as a way to identify which mission #
form property resourceobjectfarm auto  ;*** !!! temporarily set in oninit() event using getform().... remove that from the oninit() event
form property resourceobjectmill auto  ;*** !!! temporarily set in oninit() event using getform().... remove that from the oninit() event
form property resourceobjectmine auto  ;*** !!! temporarily set in oninit() event using getform().... remove that from the oninit() event
cwscript property cws auto hidden
event oninit()
endevent
function resetcampaign()
endfunction
function purchasegarrisons()
endfunction
function purchasegarrisonlocationalias(locationalias garrisonalias)
endfunction
function purchasegarrisonlocation(location garrisonlocation)
endfunction
function unsetpurchasedlocations()
endfunction
function setpurchasedlocation(location locationthatwaspurchased, int owningfaction)
endfunction
function callsetownerforpurchasedlocations()
endfunction
function resetdefenderonlygarrisons()
endfunction
function resetdefenderonlygarrison(int garrisontoreset)
endfunction
location function returnlocationfordefenderonlygarrison(int garrisontoget)
endfunction
function resetcamps()
endfunction
int function purchasepatrolandreturnnewowner(int whichpatroltopurchase)
endfunction
function resetpatrols()
endfunction
function enablepatrols()
endfunction
function enabledefaultpatrols()
endfunction
function enablepatrol(int whichpatroltoenable)
endfunction
objectreference function getenablemarkerforpatrol(int whichpatrol)
endfunction
function setcwcampaignfieldcoaliases()
endfunction
function advancecampaignphase(int optionalphasetosetto = -1)
endfunction
function startresolutionmission()
endfunction
function setcurrentattackdelta()
endfunction
int function getcurrentattackdelta()
endfunction
int function getattackdeltapointsforcapital(location capitallocation)
endfunction
float function getattackdeltapointsfordefenderonlygarrison(location garrison, objectreference resourceobject)
endfunction
float function getattackdeltapointsforgarrison(location garrison, objectreference resourceobject)
endfunction
int function getattackdeltapointsforpatrols()
endfunction
function addattackdeltamissionbonus(int valuetoadd)
endfunction
function subtractattackdeltamissionbonus(int valuetosubtract)
endfunction
int function getattackdeltamissionbonus()
endfunction
int function getcountfarms(referencealias resourceobject1, referencealias resourceobject2, referencealias resourceobject3)
endfunction
int function getcountmills(referencealias resourceobject1, referencealias resourceobject2, referencealias resourceobject3)
endfunction
int function getcountmines(referencealias resourceobject1, referencealias resourceobject2, referencealias resourceobject3)
endfunction
int function getresourcetype(referencealias resourceobject)
endfunction
function forcefieldhqaliases()
endfunction
function playerjoinsactivecampaign()
endfunction
function updatecwcampaignobjaliases()
endfunction
function starttutorialmission()
endfunction
function stoptutorialmission()
endfunction
objectreference function getattackerfieldhqcentermarker()
endfunction
objectreference function getcapitalhqmarker()
endfunction
objectreference  function getfieldhqmarker()
endfunction
objectreference  function getenemyfieldhqmarker()
endfunction
function startmissions()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1