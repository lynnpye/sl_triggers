scriptname cwscript extends quest  conditional
globalvariable property debugon auto conditional  ;###this is largely obsolete property, but there are a few things that still refer to it. see the log() function below for the new way to do this ;0 = unset, 1 = set - show warnings
globalvariable property cwdebugforceattacker auto
globalvariable property cwdebugforcehold auto
globalvariable property cwdebugallowcampaignsinfinalholds auto
int property debugforceoffscreenresult auto conditional hidden  ;the next time the campaign updates it's script, it will force an offscreen resolution, note: this also forces the quest delay time to be a frame long to speed everything up
int property debugdbtraces auto conditional hidden     ;0 = unset, 1 = export warnings that are database friendly
int property debugtreatcitycapitalsastowns auto conditional hidden ;0 = unset, 1 = causes cities such as whiterun, to be considered towns and start minor hold resolution quests
int property debugstartingcampaignphase auto conditional hidden  ;0 = unset, n = the phase that the campaign starts in, for example, you could force the campaign to always start in the resolution phase if you need to test a resolution quest
int property debugallownonadjacentholds auto conditional hidden  ;0 = unset, 1 = allow attacks against holds where attacker has no adjacent holds
int property debugskipsetownercalls auto hidden  ;0 unset, 1 = ignore calls to setowner... breaks things but causes civil war campaign to start much faster for certain types of play testing
int property countcampaigns auto conditional hidden     ;how many campaigns have run
int property countwinimperials auto conditional hidden     ;how many times have the imperials won a campaign
int property countwinsons auto conditional hidden      ;how many times have the sons won a campaign
int property countwinreachimperials auto conditional hidden
int property countwinreachsons auto conditional hidden
int property countwinhjaalmarchimperials auto conditional hidden
int property countwinhjaalmarchsons auto conditional hidden
int property countwinwhiterunimperials auto conditional hidden
int property countwinwhiterunsons auto conditional hidden
int property countwinfalkreathimperials auto conditional hidden
int property countwinfalkreathsons auto conditional hidden
int property countwinpaleimperials auto conditional hidden
int property countwinpalesons auto conditional hidden
int property countwinwinterholdimperials auto conditional hidden
int property countwinwinterholdsons auto conditional hidden
int property countwinriftimperials auto conditional hidden
int property countwinriftsons auto conditional hidden
int property campaignrunning auto conditional hidden     ;(set in cwcampaign stage 0) 0 = not running, 1 = busy setting up campaign, 2 = done setting up and other quests and scripts can assume its safe to poke the campaign
float property resolutionattackdeltamultiplier auto conditional  hidden ;(set in the "init" block below) the value that gets multipled to the attack delta in the offscreen resolution formula before being added to the die roll
float property resolutiondieroll auto conditional  hidden   ;1-100, gets adding to the attackdelta*multiplier in the offscreen resolution formula
bool property resolutionforced auto conditional hidden    ;true = defender is forced to be the winner because the player wasn't yet involved in the campaign for the hold which was a major hold with a city (we don't want cities changing hands if the player never got involved)
float property resolutionresult auto conditional  hidden   ;> 50 = attacker wins, <= 50 means defender wins
int property playerallegiance auto conditional hidden    ;0 = unset, 1 = player joined imperials, 2 = sons of skyrim -- note before the player commits in the main quest, the system still needs him to be on a "side" because it assumes he always is on a side, in cw stage 0 it puts him in imperials if he isn't already commited
int property playerjoinedcampaginreach auto conditional hidden  ;0 = unset, 1 = player took a mission in that hold. until this = 1 any offscreen resolution will always fail for the attacker. this ensures that the player has a chance to see "pre-switched" state and see the new jarl's plot  arc.
int property playerjoinedcampaginwhiterun auto conditional hidden 
int property playerjoinedcampaginrift auto conditional hidden
int property playerjoinedcurrentcampaign auto hidden  ;used for determining salary, set in cwmissionscript playeracceptsmission()
int property tutorialmissioncomplete auto conditional hidden  ;0 = unset, 1 = player completed the tutorial mission -- this changes the behavior of the resolution phase. (see cwcampaignscript startmissions()) until the player completes the tutorial, resolution phase will finish offscreen immediately. 
int property playergotintro auto conditional hidden      ;player got the "do i know you? i was at helgen? oh, you were at helgen" stuff from one of the factions, used to make the other faction recognize you right away so you don't have go through all that again
int property playerinvolved auto conditional hidden     ;0 = unset, 1 = the player is now involved in the civil war
int property warisactive auto conditional hidden      ;0 = not set, 1 = active and player can get missions from field cos, -1 = paused and should not start new missions
bool property enemyfortsaddedbacktowar auto conditional hidden ;see addenemyfortsbacktowar()
int property playerreport auto conditional  hidden     ;see finishcampaign() - 0 = un/reset, 1 = player should report, 2 = player reported to faction head after campaign
bool property whiterunsiegestarted auto hidden      ;used by cwfieldcoscript if the whiterun siege has started, don't try starting it again
bool property whiterunsiegefinished auto conditional hidden   ;means the initial siege of whiterun has either been won, or lost
int property contestedholdwinner auto conditional hidden    ;1 = imperials, 2 = sons
int property contestedholdwintype auto conditional hidden    ;0 = unset, 1 = attacker won, 2 defender won
float property attackercointoss auto conditional hidden   ;0 = unset, 1 = imperials, 2=sons of skyrim (see cw stage 10)
int property previousattacker auto conditional hidden     ;0 = unset, 1 = imperials, 2=sons of skyrim
int property consecutiveattacks auto conditional hidden   ;0 = unset/reset, # = number of times the same side attacked (used to force change if randomly picks the same one too many times in arow)
int property iimperials   = 1   auto hidden
int property isons   = 2   auto hidden
int property ibothfactions  = 3   auto hidden
int property icurrentowner   = -999  auto hidden ;used by setowner and it's related functions (means just reset the garrison, don't change the owner)
int property attacker auto conditional hidden      ;0 = unset, 1 = imperials, 2=sons of skyrim
int property defender auto conditional hidden      ;0 = unset, 1 = imperials, 2=sons of skyrim
int property choosinghold auto conditional  hidden     ;0 = unset, ;n = iteration of trying to chose a hold to attack, -n means successful after n tries (see game mode block)
int property ihaafingar   = 1 auto hidden  ;* can't be contested
int property ireach    = 2 auto hidden
int property ihjaalmarch  = 3 auto hidden
int property iwhiterun   = 4 auto hidden
int property ifalkreath   = 5 auto hidden
int property ipale    = 6 auto hidden
int property iwinterhold  = 7 auto hidden
int property ieastmarch   = 8 auto hidden ;* can't ne contested
int property irift    = 9 auto hidden
int property contestedhold auto conditional hidden
int property previouscontestedhold auto conditional hidden
int property ownerhaafingar auto conditional hidden
int property ownerreach auto conditional hidden 
int property ownerhjaalmarch auto conditional hidden
int property ownerwhiterun auto conditional hidden
int property ownerfalkreath auto conditional hidden
int property ownerpale auto conditional hidden
int property ownerwinterhold auto conditional hidden
int property ownereastmarch auto conditional hidden
int property ownerrift auto conditional hidden
int property ownercontestedhold auto conditional hidden  ;0 = unset, 1 = imperial controlled, 2 = sons of skyrim controlled
int property countholdsimperial auto conditional hidden ;how many holds do the imperials currently control
int property countholdssons auto conditional hidden ;how many holds to the sons currently control
int property strvaluehaafingar auto hidden
int property strvaluereach auto hidden
int property strvaluehjaalmarch auto hidden 
int property strvaluewhiterun auto hidden 
int property strvaluefalkreath auto hidden
int property strvaluepale auto hidden
int property strvaluewinterhold auto hidden
int property strvalueeastmarch auto hidden
int property strvaluerift auto hidden
int property strhaafingarimperial auto conditional hidden
int property strhaafingarsons auto conditional hidden
int property strreachimperial auto conditional hidden
int property strreachsons auto conditional hidden
int property strhjaalmarchimperial auto conditional hidden
int property strhjaalmarchsons auto conditional hidden
int property strwhiterunimperial auto conditional hidden
int property strwhiterunsons auto conditional hidden
int property strfalkreathimperial auto conditional hidden
int property strfalkreathsons auto conditional hidden
int property strpaleimperial auto conditional hidden     
int property strpalesons auto conditional hidden
int property strwinterholdimperial auto conditional hidden
int property strwinterholdsons auto conditional hidden
int property streastmarchimperial auto conditional hidden
int property streastmarchsons auto conditional hidden
int property strriftimperial auto conditional hidden
int property strriftsons auto conditional hidden
int property strcontestedholdimperial auto conditional hidden ;same as above, but localized for currently contested hold
int property strcontestedholdsons auto conditional hidden
int property strattacker auto conditional hidden    ;same as above, but localized for the current attacker
int property strdefender auto conditional hidden    ;same as above, but localized for the current defender
int property maxattackdelta auto conditional hidden   ;the max attack delta can be
int property attackdelta auto conditional hidden    ;current relative attacker strength - initally equal to (strattacker - strdefender), it is modified by completing objectives in free form game play and missions
int property purchasedelta auto conditional hidden   ;the attackdelta in a form that can be subtracted from to "pay for" locations in the contested hold (see each campaign quest stage 20)
int property icostnoncontestable auto hidden
int property icostfort auto hidden
int property icostsmall auto hidden
int property icostmedium auto hidden
int property icostlarge auto hidden
int property icostpatrol auto hidden
location property lastlocattackedbyimperials auto hidden
location property lastlocattackedbysons auto hidden
location property lastlocattacked auto hidden
bool property winholdandsetowneralreadysetkeyword auto hidden  ;used in conjunction with winholdandsetownerkeyworddataonly and winholdandsetowner
bool property winningholdandsettingownerpleasewait auto hidden  ;used in conjunction with winholdandsetownerkeyworddataonly and winholdandsetowner
bool property waitingforcwresetgarrisonquest1 auto hidden  ;see setowner() function below - set in setowner() cleared in cwresetgarrison1 shutdown stage
bool property waitingforcwresetgarrisonquest2 auto hidden  ;see setowner() function below - set in setowner() cleared in cwresetgarrison2 shutdown stage
bool property waitingforcwresetgarrisonquest3 auto hidden  ;see setowner() function below - set in setowner() cleared in cwresetgarrison3 shutdown stage
bool property waitingforcwresetgarrisonquest4 auto hidden  ;see setowner() function below - set in setowner() cleared in cwresetgarrison4 shutdown stage
bool property waitingforcwresetgarrisonquest5 auto hidden  ;see setowner() function below - set in setowner() cleared in cwresetgarrison5 shutdown stage
bool property waitingforcwresetgarrisonquest6 auto hidden  ;see setowner() function below - set in setowner() cleared in cwresetgarrison6 shutdown stage
bool property waitingforcwresetgarrisonquest7 auto hidden  ;see setowner() function below - set in setowner() cleared in cwresetgarrison7 shutdown stage
bool property waitingforcwresetgarrisonquest8 auto hidden  ;see setowner() function below - set in setowner() cleared in cwresetgarrison8 shutdown stage
int property init auto hidden         ;the 1 = oninit() event was called
int property playerrank auto conditional hidden    ;the rank the player is in the faction
int property countmissionsuccess auto conditional hidden  ;the number of successful missions
float property basesalary auto hidden       ;amount in gold the player's base campaign salary is
float property salarymultrank1 auto  hidden     ;multiplier to basesalary based on player rank
float property salarymultrank2 auto  hidden      ;multiplier to basesalary based on player rank
float property salarymultrank3 auto  hidden     ;multiplier to basesalary based on player rank
float property salarymultrank4 auto  hidden     ;multiplier to basesalary based on player rank
int property salary auto conditional hidden     ;holds the total of uncollected player salary see contributesalarypool() and paysalary(), used as condition on dialogue
bool property buddydialogueallowed auto conditional hidden  ;set in stage 30 of cw02a/b and conditioned in buddy dialogue so you don't get the dialogue before korvanjund
int property cwmission03done auto conditional hidden   ;used by story manager, set in mission quest stage results
int property cwmission04done auto conditional hidden ;used by story manager, set in mission quest stage results
int property cwmission07done auto conditional hidden ;used by story manager, set in mission quest stage results
bool property haafingarfortbattlecomplete auto hidden  ;set in cwfortsiegefort stage 9000
bool property eastmarchfortbattlecomplete auto hidden  ;set in cwfortsiegefort stage 9000
globalvariable property cwmaxconsecutiveattacks  auto    ;this is a global variable so we can more easily tweak this setting as we play
globalvariable property gamedayspassed auto     ;pointer to gamedayspassed
globalvariable property cwattacker auto      ;set in startnewcampaign() same as attacker property
globalvariable property cwdefender auto      ;set in startnewcampaign() same as defender property
globalvariable property cwplayerallegiance auto    ;global value that holds the playerallegiance property value
globalvariable property timescale auto
globalvariable property cwcountholdsimperial auto    ;holds countholdsimperial property, set in setholdsimperial() function, called by setholdsproperty() function
globalvariable property cwcountholdssons auto     ;holds countholdsimperial property, set in setholdsimperial() function, called by setholdsproperty() function
globalvariable property cwcontestedhold auto     ;holds the same value as contestedhold, used for conditions in dialogue, packages, etc.
globalvariable property cwreinforcementpoolattacker auto  ;holds the cwreinforcementcontrollerscript.poolattacker value for the current siege.
globalvariable property cwreinforcementpooldefender auto  ;holds the cwreinforcementcontrollerscript.poolattacker value for the current siege.
globalvariable property cwmissionfailday auto     ;holds the timestamp left before the active mission fails. used mission journal. see cwmissionpollforfaildayscript
globalvariable property cwmissionsforrank1 auto    ;holds the number of successful missions needed for increasing the player's faction rank
globalvariable property cwmissionsforrank2 auto    ;holds the number of successful missions needed for increasing the player's faction rank
globalvariable property cwmissionsforrank3 auto    ;holds the number of successful missions needed for increasing the player's faction rank
globalvariable property cwmissionsforrank4 auto    ;holds the number of successful missions needed for increasing the player's faction rank
globalvariable property cwcountmissionsdone auto  ;deprecated/obsolete -- used to conditionalize story manager to allow each quest 
globalvariable property cwthreatbridgeimperial auto
globalvariable property cwthreatbridgesons auto
globalvariable property cwthreatfenceimperial auto
globalvariable property cwthreatfenceimperialarcher auto
globalvariable property cwthreatfenceimperialmage auto
globalvariable property cwthreatfencesons auto
globalvariable property cwthreatfencesonsarcher auto
globalvariable property cwthreatfencesonsmage auto
globalvariable property cwthreathouseimperial auto
globalvariable property cwthreathousesons auto
globalvariable property cwthreatrockimperial auto
globalvariable property cwthreatrocksons auto
globalvariable property cwthreatstablesimperial auto
globalvariable property cwthreatstablessons auto
globalvariable property cwthreattowerimperial auto
globalvariable property cwthreattowerimperialarcher auto
globalvariable property cwthreattowerimperialmage auto
globalvariable property cwthreattowersons auto
globalvariable property cwthreattowersonsarcher auto
globalvariable property cwthreattowersonsmage auto
globalvariable property cwthreattreeimperial auto
globalvariable property cwthreattreesons auto
globalvariable property cwthreatwallimperial auto
globalvariable property cwthreatwallimperialarcher auto
globalvariable property cwthreatwallimperialmage auto
globalvariable property cwthreatwallsons auto
globalvariable property cwthreatwallsonsarcher auto
globalvariable property cwthreatwallsonsmage auto
globalvariable property cwthreatwindowimperial auto
globalvariable property cwthreatwindowimperialarcher auto
globalvariable property cwthreatwindowimperialmage auto
globalvariable property cwthreatwindowsons auto
globalvariable property cwthreatwindowsonsarcher auto
globalvariable property cwthreatwindowsonsmage auto
globalvariable property cwbattlephase auto
globalvariable property cwpercentpoolremainingattacker auto  ;for use with cwreinforcementcontrollerscript
globalvariable property cwpercentpoolremainingdefender auto  ;for use with cwreinforcementcontrollerscript
globalvariable property cwobjeastmarch auto
globalvariable property cwobjfalkreath auto
globalvariable property cwobjhaafingar auto
globalvariable property cwobjhjaalmarch auto
globalvariable property cwobjpale auto
globalvariable property cwobjreach auto
globalvariable property cwobjrift auto
globalvariable property cwobjwhiterun auto
globalvariable property cwobjwinterhold auto
globalvariable property cwstateattackstarted auto
globalvariable property cwstateattackeratgate  auto  
globalvariable property cwstateattackerbrokethrough  auto  
globalvariable property cwstateattackerlowreinforcements  auto  
globalvariable property cwstateattackeroutofreinforcements  auto  
globalvariable property cwstatedefenderfallingback  auto  
globalvariable property cwstatedefenderlaststand  auto  
globalvariable property cwstatedefenderlowreinforcements  auto  
globalvariable property cwstatedefenderoutofreinforcements  auto  
quest property cwobj auto
quest property cwcampaign auto
cwcampaignscript property cwcampaigns auto
quest property cwreset auto
quest property cwresetgarrison1 auto
quest property cwresetgarrison2 auto
quest property cwresetgarrison3 auto
quest property cwresetgarrison4 auto
quest property cwresetgarrison5 auto
quest property cwresetgarrison6 auto
quest property cwresetgarrison7 auto
quest property cwresetgarrison8 auto
quest property cwcampaignobj auto
quest property cwmiscobj auto
quest property cwsiegeattackobj auto
quest property cwsiegedefendobj auto
cwsiegescript property cwsieges auto
cwalliesscript property cwalliess auto
quest property cwsiegeobj auto
quest property cwpreparecity auto
quest property cwcitizensflee auto
quest property cwfortsiegecapital auto
quest property cwfortsiegefort auto
quest property cwmission03 auto
quest property cwmission04 auto
quest property cwmission07 auto
quest property cwfinale auto
quest property cw00a auto 
quest property cw00b auto 
quest property cw01a auto 
quest property cw01b auto 
quest property cw03 auto  ;used by the cwfieldcoscript to test the quest stage to start the siege of whiterun
quest property cwfin auto
quest property mq302 auto  ;peace treaty - need to stop this if taking the second to last holds
wifunctionsscript property wis auto
favordialoguescript property dialoguefavorgenerics auto
cwthreatcombatbarksscript property cwthreatcombatbarkss auto
locationalias property cwobjquestnamelocation auto  ;see stage 1 and 2
referencealias property aliasfactionleader auto
referencealias property aliastullius auto
referencealias property aliasulfric auto
referencealias property imperialfactionhqmarker auto
referencealias property sonsfactionhqmarker auto
referencealias property exiledimperialmarker auto
referencealias property exiledsonsmarker auto
referencealias property tullius auto
referencealias property rikke auto
referencealias property ulfric auto
referencealias property galmar auto
referencealias property fieldco auto
referencealias property alias_fieldcoimperialeastmarchcamp auto
referencealias property alias_fieldcoimperialeastmarchhq auto
referencealias property alias_fieldcoimperialfalkreathcamp auto
referencealias property alias_fieldcoimperialfalkreathhq auto
referencealias property alias_fieldcoimperialhaafingarcamp auto
referencealias property alias_fieldcoimperialhaafingarhq auto
referencealias property alias_fieldcoimperialhjaalmarchcamp auto
referencealias property alias_fieldcoimperialhjaalmarchhq auto
referencealias property alias_fieldcoimperialpalecamp auto
referencealias property alias_fieldcoimperialpalehq auto
referencealias property alias_fieldcoimperialreachcamp auto
referencealias property alias_fieldcoimperialreachhq auto
referencealias property alias_fieldcoimperialriftcamp auto
referencealias property alias_fieldcoimperialrifthq auto
referencealias property alias_fieldcoimperialwhiteruncamp auto
referencealias property alias_fieldcoimperialwhiterunhq auto
referencealias property alias_fieldcoimperialwinterholdcamp auto
referencealias property alias_fieldcoimperialwinterholdhq auto
referencealias property alias_fieldcosonseastmarchcamp auto
referencealias property alias_fieldcosonseastmarchhq auto
referencealias property alias_fieldcosonsfalkreathcamp auto
referencealias property alias_fieldcosonsfalkreathhq auto
referencealias property alias_fieldcosonshaafingarcamp auto
referencealias property alias_fieldcosonshaafingarhq auto
referencealias property alias_fieldcosonshjaalmarchcamp auto
referencealias property alias_fieldcosonshjaalmarchhq auto
referencealias property alias_fieldcosonspalecamp auto
referencealias property alias_fieldcosonspalehq auto
referencealias property alias_fieldcosonsreachcamp auto
referencealias property alias_fieldcosonsreachhq auto
referencealias property alias_fieldcosonsriftcamp auto
referencealias property alias_fieldcosonsrifthq auto
referencealias property alias_fieldcosonswhiteruncamp auto
referencealias property alias_fieldcosonswhiterunhq auto
referencealias property alias_fieldcosonswinterholdcamp auto
referencealias property alias_fieldcosonswinterholdhq auto
locationalias property cwsiegecity auto
locationalias property cwfortsiegecapitalfort auto ;fort alias in cwfortsiegecapital
faction property playerfaction auto
faction property cwbuddies auto
faction property cwimperialfaction auto
faction property cwsonsfaction auto
faction property cwimperialfactionnpc auto
faction property cwsonsfactionnpc auto
faction property cwdisaffectedsoldierfaction auto  ;used for soldiers who will switch sides in cwmissions (see cwmission06 for an example)
faction property crimefactionimperial auto  ;general crime group for faction, soldiers who are attacking in a campagin should have this faction - sends criminals to faction hq
faction property crimefactionsons auto   ;general crime group for faction, soldiers who are attacking in a campagin should have this faction - sends criminals to faction hq
faction property isguardfaction auto
faction property crimefactionhaafingar auto     
faction property crimefactionreach auto     
faction property crimefactionhjaalmarch auto     
faction property crimefactionwhiterun auto     
faction property crimefactionfalkreath auto     
faction property crimefactionpale auto     
faction property crimefactionwinterhold auto     
faction property crimefactioneastmarch auto     
faction property crimefactionrift auto     
faction property cwdialoguesoldierfaction auto
faction property cwdialoguesoldierwaitingtoattackfaction auto
faction property cwdialoguesoldierwaitingtodefendfaction auto
faction property cwjobfortcommanderfaction auto
faction property cwjobfortgatekeeperfaction auto
faction property cwjobfortjailorfaction auto
faction property cwjobfortpatrolexteriorfaction auto
faction property cwsoldierattackerfaction auto
faction property cwsoldierdefenderfaction auto
faction property cwsoldierarcherfaction auto
faction property cwsoldiermagefaction auto
faction property cwsurrendertemporaryallies auto
faction property govimperial auto
faction property govsons auto
faction property cwfieldcoactivemissionfaction auto
faction property cwfieldcofailedmissionfaction auto
faction property cwfieldcohooksacceptedfaction auto
faction property cwfieldcopotentialmission1faction auto
faction property cwfieldcopotentialmission2faction auto
faction property cwfieldcosuccessfulmissionfaction auto
faction property favorallowbribefaction auto
faction property cwrewardfactionfalkreath auto
faction property cwrewardfactionhjaalmarch auto
faction property cwrewardfactionpale auto
faction property cwrewardfactionreach auto
faction property cwrewardfactionrift auto
faction property cwrewardfactionwhiterun auto
faction property cwrewardfactionwinterhold auto
location property haafingarholdlocation auto
location property forthraggstadlocation auto
location property solitudelocation auto ;capital
location property solitudesawmilllocation auto
location property katlasfarmlocation auto
location property dragonbridgelocation auto
location property militarycamphaafingarsonslocation auto
location property reachholdlocation auto
location property fortsungardlocation auto
location property markarthlocation auto ;capital
location property cidhnaminelocation auto
location property lefthandminelocation auto
location property salviusfarmlocation auto
location property karthwastenlocation auto
location property oldhroldanlocation auto
location property kolskeggrminelocation auto
location property militarycampreachimperiallocation auto
location property militarycampreachsonslocation auto
location property hjaalmarchholdlocation auto
location property fortsnowhawklocation auto
location property morthallocation auto ;capital
location property stonehillslocation auto 
location property militarycamphjaalmarchimperiallocation auto
location property militarycamphjaalmarchsonslocation auto
location property whiterunholdlocation auto
location property fortgreymoorlocation auto
location property whiterunlocation auto ;capital
location property battlebornfarmlocation auto
location property chillfurrowfarmlocation auto
location property pelagiafarmlocation auto
location property roriksteadlocation auto
location property riverwoodlocation auto
location property militarycampwhiterunimperiallocation auto
location property militarycampwhiterunsonslocation auto
location property falkreathholdlocation auto
location property fortneugradlocation auto
location property falkreathlocation auto ;capital
location property helgenlocation auto
location property halfmoonmilllocation auto
location property militarycampfalkreathimperiallocation auto
location property militarycampfalkreathsonslocation auto
location property paleholdlocation auto
location property fortdunstadlocation auto
location property dawnstarlocation auto ;capital
location property angasmilllocation auto
location property loreiusfarmlocation auto
location property militarycamppaleimperiallocation auto
location property militarycamppalesonslocation auto
location property winterholdholdlocation auto
location property fortkastavlocation auto
location property winterholdlocation auto  ;capital
location property whistlingminelocation auto
location property militarycampwinterholdimperiallocation auto
location property militarycampwinterholdsonslocation auto
location property eastmarchholdlocation auto
location property fortamollocation auto
location property windhelmlocation auto ;capital
location property brandymugfarmlocation auto
location property hlaalufarmlocation auto
location property hollyfrostfarmlocation auto
location property kynesgrovelocation auto
location property darkwatercrossinglocation auto
location property mixwatermilllocation auto
location property militarycampeastmarchimperiallocation auto
location property riftholdlocation auto
location property fortgreenwalllocation auto
location property riftenlocation auto ;capital
location property snowshodfarmlocation auto
location property merryfairfarmlocation auto
location property ivarsteadlocation auto
location property shorsstonelocation auto
location property heartwoodmilllocation auto
location property sarethifarmlocation auto
location property militarycampriftimperiallocation auto
location property militarycampriftsonslocation auto
actorbase property cwsoldierimperial auto
actorbase property cwsoldierimperialnotguard auto
actorbase property cwsoldiersons auto
actorbase property cwsoldiersonsnotguard auto
actorbase property cwsoldierimperialnonnpcfaction auto
actorbase property cwsoldierimperialnotguardnonnpcfaction auto
actorbase property cwsoldiersonsnonnpcfaction auto
actorbase property cwsoldiersonsnotguardnonnpcfaction auto
actorbase property cwcourierimperial auto
actorbase property cwcouriersons auto
actorbase property cwprisonerimperial auto
actorbase property cwprisonersons auto
actorbase property cwprisonerimperiala auto
actorbase property cwprisonerimperialb auto
actorbase property cwprisonerimperialc auto
actorbase property cwprisonerimperiald auto
actorbase property cwprisonersonsa auto
actorbase property cwprisonersonsb auto
actorbase property cwprisonersonsc auto
actorbase property cwprisonersonsd auto
outfit property cwsoldierimperialsoldieroutfit auto
outfit property cwsoldiersonssoldieroutfit auto
miscobject property gold001 auto  ;pointer to gold001 object
leveleditem property cwcourierdocumentsimperial auto  ;until we have leveleditem objects that i can point at in the editor, these are being set with getform() in the oninit() block below... that needs to be removed from oninit() block as soon as these are leveleditem that i can set in the editor.
leveleditem property cwcourierdocumentssons auto   ;until we have leveleditem objects that i can point at in the editor, these are being set with getform() in the oninit() block below... that needs to be removed from oninit() block as soon as these are leveleditem that i can set in the editor.
leveleditem property cwrank1rewardimperial auto     ;reward player gets when gaining faction rank 
leveleditem property cwrank2rewardimperial auto     ;reward player gets when gaining faction rank
leveleditem property cwrank3rewardimperial auto     ;reward player gets when gaining faction rank
leveleditem property cwrank4rewardimperial auto     ;reward player gets when gaining faction rank
leveleditem property cwrank1rewardsons auto ;-intially same as imperial reward, flavored as taken from an imperial officer    ;reward player gets when gaining faction rank 
leveleditem property cwrank2rewardsons auto     ;reward player gets when gaining faction rank
leveleditem property cwrank3rewardsons auto     ;reward player gets when gaining faction rank
leveleditem property cwrank4rewardsons auto     ;reward player gets when gaining faction rank
leveleditem property cwmissionreward auto ;reward player gets after each successful mission
leveleditem property cwsoldierimperialgear auto
leveleditem property cwsoldiersonsgear auto
leveleditem property cwbeararmorplayerreward auto
package property cwgalmaratcampfalkreath auto
package property cwgalmaratcamphaafingar auto
package property cwgalmaratcamphjaalmarch auto
package property cwgalmaratcamppale auto
package property cwgalmaratcampreach auto
package property cwgalmaratcamprift auto
package property cwgalmaratcampwinterhold auto
package property cwrikkeatcampeastmarch auto
package property cwrikkeatcampfalkreath auto
package property cwrikkeatcamphjaalmarch auto
package property cwrikkeatcamppale auto
package property cwrikkeatcampreach auto
package property cwrikkeatcamprift auto
package property cwrikkeatcampwinterhold auto
objectreference property cwfieldcomaptablemarkereastmarchcampimperial auto
objectreference property cwfieldcomaptablemarkerfalkreathcampimperial auto
objectreference property cwfieldcomaptablemarkerhjaalmarchcampimperial auto
objectreference property cwfieldcomaptablemarkerpalecampimperial auto
objectreference property cwfieldcomaptablemarkerreachcampimperial auto
objectreference property cwfieldcomaptablemarkerriftcampimperial auto
objectreference property cwfieldcomaptablemarkerwhiteruncampimperial auto
objectreference property cwfieldcomaptablemarkerwinterholdcampimperial auto
objectreference property cwfieldcomaptablemarkerfalkreathcampsons auto
objectreference property cwfieldcomaptablemarkerhaafingarcampsons auto
objectreference property cwfieldcomaptablemarkerhjaalmarchcampsons auto
objectreference property cwfieldcomaptablemarkerpalecampsons auto
objectreference property cwfieldcomaptablemarkerreachcampsons auto
objectreference property cwfieldcomaptablemarkerriftcampsons auto
objectreference property cwfieldcomaptablemarkerwhiteruncampsons auto
objectreference property cwfieldcomaptablemarkerwinterholdcampsons auto
objectreference property cwgarrisonenablemarkersonscampfalkreath auto
actor property ulfricref auto
actor property generaltulliusref auto
actor property hadvarref auto
actor property ralofref auto
objectreference property cwcampaignstartmarkerreach auto
objectreference property cwcampaignstartmarkerhjaalmarch auto
objectreference property cwcampaignstartmarkerwhiterun auto
objectreference property cwcampaignstartmarkerfalkreath auto
objectreference property cwcampaignstartmarkerpale auto
objectreference property cwcampaignstartmarkerwinterhold auto
objectreference property cwcampaignstartmarkerrift auto
objectreference property cwcampaignstartmarkerhaafingar auto
objectreference property cwcampaignstartmarkereastmarch auto
objectreference property militarycampeastmarchimperialmapmarker auto 
objectreference property militarycampfalkreathimperialmapmarker auto 
objectreference property militarycampfalkreathsonsmapmarker auto 
objectreference property militarycamphaafingarsonsmapmarker auto 
objectreference property militarycamphjaalmarchimperialmapmarker auto 
objectreference property militarycamphjaalmarchsonsmapmarker auto 
objectreference property militarycamppaleimperialmapmarker auto 
objectreference property militarycamppalesonsmapmarker auto 
objectreference property militarycampreachimperialmapmarker auto 
objectreference property militarycampreachsonsmapmarker auto 
objectreference property militarycampriftimperialmapmarker auto 
objectreference property militarycampriftsonsmapmarker auto 
objectreference property militarycampwhiterunimperialmapmarker auto 
objectreference property militarycampwhiterunsonsmapmarker auto 
objectreference property militarycampwinterholdimperialmapmarker auto 
objectreference property militarycampwinterholdsonsmapmarker auto 
objectreference property cwgarrisonenablemarkerimperialcampeastmarch auto
objectreference property cwgarrisonenablemarkersonscamphaafingar auto
keyword property cwmissionstart auto
keyword property cwgarrison auto
keyword property cwgarrisondefenderonly auto
keyword property cwfort auto
keyword property cwdiplomaticvictory auto
keyword property cwowner auto
keyword property cwcampaignstart auto
keyword property cwgovernmentstart  auto
keyword property cwcost auto
keyword property cwcampimperial auto
keyword property cwcampsons auto
keyword property cwcapital auto
keyword property cwresetgarrisonstart1 auto
keyword property cwresetgarrisonstart2 auto
keyword property cwresetgarrisonstart3 auto
keyword property cwresetgarrisonstart4 auto
keyword property cwresetgarrisonstart5 auto
keyword property cwresetgarrisonstart6 auto
keyword property cwresetgarrisonstart7 auto
keyword property cwresetgarrisonstart8 auto
keyword property cwattackcitystart auto
keyword property cwescapecitystart auto
keyword property cwpreparecitystart auto
keyword property cw1priorityspawn auto  ;for use with cwreinforcementcontrollerscript
keyword property cw2priorityspawn auto  ;for use with cwreinforcementcontrollerscript
keyword property cw3priorityspawn auto  ;for use with cwreinforcementcontrollerscript
keyword property cw4priorityspawn auto  ;for use with cwreinforcementcontrollerscript
keyword property cw5priorityspawn auto  ;for use with cwreinforcementcontrollerscript
keyword property cw1forcedspawn auto   ;for use with cwreinforcementcontrollerscript
keyword property cw2forcedspawn auto   ;for use with cwreinforcementcontrollerscript
keyword property cw3forcedspawn auto   ;for use with cwreinforcementcontrollerscript
keyword property cw4forcedspawn auto   ;for use with cwreinforcementcontrollerscript
keyword property cw5forcedspawn auto   ;for use with cwreinforcementcontrollerscript
keyword property loctypecity auto
keyword property cwsiegestart auto
keyword property cwsiegerunning auto
keyword property cwfortsiegespecialstart auto
keyword property cwfinalestart auto
keyword property cwfortsiegeminorcapitalstart auto
keyword property cwresolution01start auto  ;obsolete
keyword property cwresolution02start auto  ;obsolete
keyword property cwcitizensfleestart auto
keyword property cweventhappening auto
locationreftype property cwsoldier auto
locationreftype property cwresolutionjarlmarker auto   ;used to find markers in cwattackcity resolution quest to place jarl, house carl, and body guards to meet the player's attempt to surrender
locationreftype property cwresolutionhousecarlmarker auto ;used to find markers in cwattackcity resolution quest to place jarl, house carl, and body guards to meet the player's attempt to surrender
locationreftype property cwresolutionjarlguardmarker auto ;used to find markers in cwattackcity resolution quest to place jarl, house carl, and body guards to meet the player's attempt to surrender
message property cwcampaignwonfalkreathimperials auto
message property cwcampaignwonfalkreathsons auto
message property cwcampaignwonhjaalmarchimperials auto
message property cwcampaignwonhjaalmarchsons auto
message property cwcampaignwonpaleimperials auto
message property cwcampaignwonpalesons auto
message property cwcampaignwonreachimperials auto
message property cwcampaignwonreachsons auto
message property cwcampaignwonriftimperials auto
message property cwcampaignwonriftsons auto
message property cwcampaignwonwhiterunimperials auto
message property cwcampaignwonwhiterunsons auto
message property cwcampaignwonwinterholdimperials auto
message property cwcampaignwonwinterholdsons auto
message property cwcampaignoutcomelostattackmsgimperial auto
message property cwcampaignoutcomelostattackmsgsons auto
message property cwcampaignoutcomelostdefensemsgimperial auto
message property cwcampaignoutcomelostdefensemsgsons auto
message property cwcampaignoutcomewonattackmsgimperial auto
message property cwcampaignoutcomewonattackmsgsons auto
message property cwcampaignoutcomewondefensemsgimperial auto
message property cwcampaignoutcomewondefensemsgsons auto
message property cwcampaigntruce auto
event oninit() ;i could set these when i declare the properties however, many of these are "debug settings" and "game settings" so i prefer to set them all here
endevent
function log(string filename, string stringtoprint, int severity = 0, bool alwaysprintlog = false, bool alwaysprinttomainlog = false) global
endfunction
function addcivilwarachievment(int whichcivilwarachivement, location associatedlocation = none)
endfunction
function modobjectivebyenemysoldierdeath(actor deadsoldier, int amounttomod = 1, location hold = none)
endfunction
function modobjectivebysabotage(resourceobjectscript resourceobject, int amounttomod = 5)
endfunction
function modobjectivebymissionsuccess(location holdlocation, int amounttomod = 25)
endfunction
function modcwobjglobal(globalvariable globaltomodify, float amounttoadd)
endfunction
function completecwobj(location holdwhoseobjectivetocomplete)
endfunction
function failcwobj(location holdwhoseobjectivetofail)
endfunction
function updateobjective(location holdlocationwhoseobjectiveweshouldupdate, bool markobjectivecomplete = false, bool failobjective = false, globalvariable globaltoresetduetofailure = none)
endfunction
function displayfactionleaderobjective()
endfunction
function displayholdobjective()
endfunction
string function factionname(int cwfaction)
endfunction
string function holdname(int holdnumber)
endfunction
faction function getfaction(int factiontoreturn, bool returnnpcfaction = false)
endfunction
faction function getplayerallegiancefaction(bool returnnpcfaction = false)
endfunction
faction function getplayerallegianceenemyfaction(bool returnnpcfaction = false)
endfunction
int function getoppositefactionint(int factionwhoseoppositeyouwant)
endfunction
actor function getrikkeorgalmar(int ifaction = -1)
endfunction
bool function checkrikkegalmarnotatcamppackagelocationandmoveifneeded(actor actortocheck, package packagetocheck, location locationtocheck, objectreference markertomoveto)
endfunction
function moverikkegalmartocampifneeded(bool checkifunloaded = false)
endfunction
globalvariable function getcwobjglobal(int holdnumber)
endfunction
int function getactorallgeiance(actor actortocheck)
endfunction
bool function isimperial(actor actortocheck)
endfunction
bool function issons(actor actortocheck)
endfunction
bool function isplayerinmyfaction(actor actortocheck)
endfunction
function setplayerallegiance(int factiontojoin, int makeplayerinvolved = 0)
endfunction
function pacifyaliasforsurrender(referencealias refaliastopacify)
endfunction
function clearaliasenemyflagoncrimefactions(referencealias aliaswhosecrimefactionshouldclearplayerenemyflag)
endfunction
function clearactorsenemyflagoncrimefactions(actor actorwhosecrimefactionshouldclearplayerenemyflag)
endfunction
function playertookoath(int ifaction)
endfunction
location function getmycurrentholdlocation(objectreference reftogetcurrentholdfor)
endfunction
location function getmyeditorlocationholdlocation(objectreference reftogeteditorlocholdfor)
endfunction
faction function getcrimefactionforactorfaction(actor actortocheck)
endfunction
faction function getcrimefactionforhold(location holdlocation)
endfunction
function clearholdcrimegold(location holdlocation)
endfunction
function setcrimefactiononactorforeditorlocationshold(actor actortosetcrimefaction)
endfunction
function determineandsetcrimefactionforsoldieractor(actor actorref)
endfunction
location function getmyparentholdlocation(location locationtogetparentholdfor)
endfunction
location function getcapitallocationforhold(location holdlocation)
endfunction
location function getcamplocationforhold(location hold, int getcampforthisfaction)
endfunction
objectreference function getreferencehqfieldcoforhold(location hold, int factiontocheck)
endfunction
objectreference function getreferencecampfieldcoforhold(location hold, int factiontocheck)
endfunction
referencealias function getaliashqfieldcoforhold(location hold, int factiontocheck)
endfunction
referencealias function getaliascampfieldcoforhold(location hold, int factiontocheck)
endfunction
int function getholdid(location holdtocheck)
endfunction
int function getholdowner(int holdtocheck)
endfunction
bool function isplayerattacking(location locationtocheck)
endfunction
function discovermilitarycampmarkers(int factionid)
endfunction
bool function factionownsall(int factiontotest)
endfunction
function registereventhappening(location locationwhereeventishappening)
endfunction
function unregistereventhappening(location locationwhereeventishappening)
endfunction
function stopsiegequests()
endfunction
function stopcivilwar() ;called by cw stage 255
endfunction
function restartcivilwar() ;called in stage 256 of cw quest
endfunction
function restartcivilwarcompleteobjectiveifneeded(int objectivetocheck, location holdlocationtocheck)
endfunction
function setcountwins()
endfunction
function setcountwinsimperials()
endfunction
function setcountwinssons()
endfunction
message function getcampaignwonmessage()
endfunction
location function getlocationforhold(int hold)
endfunction
int function getintforholdlocation(location locationtogetintfor)
endfunction
objectreference function getcampaignstartmarker(int hold)
endfunction
function initializefortownerkeyworddata()
endfunction
int function getowner(location locationtocheck)
endfunction
int function getattacker(location locationtocheck)
endfunction
int function getdefender(location locationtocheck)
endfunction
bool function playersfactionisattacker(location locationtocheck)
endfunction
bool function playersfactionisdefender(location locationtocheck)
endfunction
bool function imperialsareattacking(location locationtocheck)
endfunction
bool function sonsareattacking(location locationtocheck)
endfunction
bool function isactorattacker(actor actortocheck, location locationofbattle)
endfunction
bool function isactordefender(actor actortocheck, location locationofbattle)
endfunction
int function getwinner(location locationoffinalebattle, bool attackerwon = false, bool defenderwon = false)
endfunction
function registerlocationattacked(location holdlocation, location attackedlocation, int ifaction = 0)
endfunction
function removegarrisonfromwar(location locationtoturnoff)
endfunction
function addgarrisonbacktowar(location locationtoturnon, int factiontoown = 0, bool skipsetownercall = false)
endfunction
function addenemyfortstobacktowar(bool showdebugmessage = false)
endfunction
function setownerkeyworddataonly(location locationtoset, int factiontoown)
endfunction
function setowner(location locationtoset1, int factiontoown, location locationtoset2 = none, location locationtoset3 = none, location locationtoset4 = none, \
location locationtoset5 = none, location locationtoset6 = none , location locationtoset7 = none , location locationtoset8 = none, \
endfunction
bool function setownerstartresetquest(location locationtoset, int factiontoown, keyword keywordforresetgarrisonquest)
endfunction
function winholdoffscreenifnotdoingcapitalbattles(location holdtowin, bool attackershavewon = true, bool defendershavewon = false)
endfunction
function winholdandsetownerkeyworddataonly(location holdlocationtoset, bool attackerswon, bool defenderswon)
endfunction
function winholdandsetowner(location holdlocationtoset, bool attackerswon, bool defenderswon)
endfunction
function setholdowner(location holdlocationtoset, int factiontoown)
endfunction
function setholdownerbyint(int holdtoset, int factiontoown, bool diplomaticvictory = false )
endfunction
function setcountholdproperties()
endfunction
function setcountholdsimperial()
endfunction
function setcountholdssons()
endfunction
function resetholds()
endfunction
function setinitalownerkeyworddataonly()
endfunction
function setinitialowners()
endfunction
function setownerhaafingar(int factiontoown, bool diplomaticvictory = false)
endfunction
function setownerreach(int factiontoown, bool diplomaticvictory = false)
endfunction
function setownerhjaalmarch(int factiontoown, bool diplomaticvictory = false)
endfunction
function setownerwhiterun(int factiontoown, bool diplomaticvictory = false)
endfunction
function setownerfalkreath(int factiontoown, bool diplomaticvictory = false)
endfunction
function setownerpale(int factiontoown, bool diplomaticvictory = false)
endfunction
function setownerwinterhold(int factiontoown, bool diplomaticvictory = false)
endfunction
function setownereastmarch(int factiontoown, bool diplomaticvictory = false)
endfunction
function setownerrift(int factiontoown, bool diplomaticvictory = false)
endfunction
function createmissions(location holdlocation, objectreference currentfieldco, bool forcefinalsiege = false, objectreference campaignstartmarker = none)
endfunction
function setfieldcoalias(objectreference reftoforceintofieldcoalias)
endfunction
function givemissionreward()
endfunction
function setplayerfactionrank(int ranktosetto)
endfunction
function rewardplayerforreclaiminghold()
endfunction
function setsoldieraliasdialoguefactions(referencealias soldieralias, bool addtowaitingtoattack = false, bool addtowaitingtodefend = false)
endfunction
function contributetosalarypool()
endfunction
function paysalary()
endfunction
function donatesalary()
endfunction
objectreference function getfactionhqmarkerforactor(actor actortocheck)
endfunction
objectreference function getexiledmarkerforactor(actor actortocheck)
endfunction
function startcwcitizensflee(location locationofbattle)
endfunction
function stopcwcitizensflee()
endfunction
function persuade(actor target)
endfunction
function bribe(actor target)
endfunction
function intimidate(actor target)
endfunction
function brawl(actor target)
endfunction
function givegift(actor target)
endfunction
function toggleoffcomplexwiinteractions(locationalias locationaliastotoggle)
endfunction
function toggleoncomplexwiinteractions(locationalias locationaliastotoggle)
endfunction
function toggleoffwidragons(locationalias locationaliastotoggle)
endfunction
function toggleonwidragons(locationalias locationaliastotoggle)
endfunction
function outputxmlrowopentag(string rowname)
endfunction
function outputxmlrowclosetag(string rowname)
endfunction
function outputxmlfield(string fieldname, string fieldvalue)
endfunction
function outputcampaignstatsxmlrow()
endfunction
function outputcampaignstatsxmlrowa()
endfunction
function outputcampaignstatsxmlrowb()
endfunction
function resetstrengthpoints()
endfunction
function setstrengthpoints()
endfunction
function setstrengthpointshaafingar()
endfunction
function setstrengthpointsreach()
endfunction
function setstrengthpointshjaalmarch()
endfunction
function setstrengthpointswhiterun()
endfunction
function setstrengthpointsfalkreath()
endfunction
function setstrengthpointspale()
endfunction
function setstrengthpointswinterhold()
endfunction
function setstrengthpointseastmarch()
endfunction
function setstrengthpointsrift()
endfunction
function startnewcampaign()
endfunction
int function getstrengthpoints(int factiontocheck, int holdtocheck)
endfunction
int function chooseattackingfaction(int factiontoforce = 0)
endfunction
int function validateholdtoattack(int hold, int holdowner, int attackingfaction, int attackerstengthpoints)
endfunction
int function chooseholdtoattack(int attackingfaction, int holdtoforce = 0)
endfunction
function setattackdelta()
endfunction
function startcampaignquest(int hold)
endfunction
function finishcampaign()
endfunction
function setgarrisoncost(location loctoset, int cost)
endfunction
int function getgarrisoncost(location loctogetcost)
endfunction
function setinitialcosts()
endfunction
function setinitialgarrisoncostshaafingar()
endfunction
function setinitialgarrisoncostsreach()
endfunction
function setinitialgarrisoncostshjaalmarch()
endfunction
function setinitialgarrisoncostswhiterun()
endfunction
function setinitialgarrisoncostsfalkreath()
endfunction
function setinitialgarrisoncostspale()
endfunction
function setinitialgarrisoncostswinterhold()
endfunction
function setinitialgarrisoncostseastmarch()
endfunction
function setinitialgarrisoncostsrift()
endfunction
function registermissionsuccess(location holdlocation, bool isfortbattle = false)
endfunction
function setcontestedholdwintype()
endfunction
function resolveoffscreen(int currentattackdelta = 0)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1