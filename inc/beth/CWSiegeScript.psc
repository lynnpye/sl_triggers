scriptname cwsiegescript extends quest conditional
cwscript property cws auto
globalvariable property cwbattlephase auto
globalvariable property cwstateattackeratgate auto
globalvariable property cwstateattackerbrokethrough auto
globalvariable property cwstateattackerlowreinforcements auto
globalvariable property cwstateattackeroutofreinforcements auto
globalvariable property cwstateattackstarted auto
globalvariable property cwstatedefenderfallingback auto
globalvariable property cwstatedefenderlaststand auto
globalvariable property cwstatedefenderlowreinforcements auto
globalvariable property cwstatedefenderoutofreinforcements auto
bool property donesettingupaliases = false auto hidden
bool property doneturningonaliases = false auto hidden
bool property wasthisanattack  auto hidden
bool property attackershavewon = false auto conditional
bool property defendershavewon = false auto conditional
int property currentcity auto conditional
locationalias property city auto
locationalias property hold auto
objectreference property textreplacedefense  auto  
objectreference property textreplaceattack  auto  
referencealias property objaliastextreplaceattackdefend auto
musictype property muscombatcivilwar auto
sound property ambcombatsoundsloop  auto  
weather property weatherwhiterun auto
weather property weathermarkarth auto
weather property weatherriften auto
weather property weathersolitude auto
weather property weatherwindhelm auto
explosion property cwcatapultexp auto
quest property da08  auto
quest property solitudeopening auto
scene property cwsiegewhiterundefendedscene auto
quest property cwpostwhiterunobj auto ;objective turned on in stage 200 in cwsiege quest, and completed in cwsiegejarlthankyoutopic fragment in cw quest
ms11questscript property ms11 auto ;ised tp call a function on ms11 to help handle murder scene not occuring duing siege
quest property cwsiegeobj auto
locationalias property cwsiegeobjcity auto
referencealias property cwsiegeobjcitygate auto
referencealias property cwsiegeobjjarl auto
referencealias property cwsiegeobjgeneral auto
referencealias property cwsiegeobjobjective1a auto
referencealias property cwsiegeobjobjective2a auto
referencealias property cwsiegeobjobjective3a auto
referencealias property cwsiegeobjobjective4a auto
referencealias property cwsiegeobjobjective1b auto
referencealias property cwsiegeobjobjective2b auto
referencealias property cwsiegeobjobjective3b auto
referencealias property cwsiegeobjobjective4b auto
referencealias property cwreservationsbalgruuf auto
referencealias property cwreservationsproventus auto
referencealias property cwreservationsirileth auto
function registermapmarkeraliases(referencealias attackersonscampmapmarkeralias, referencealias attackerimperialcampmapmarkeralias, \
referencealias mapmarkertodisable1alias, \
endfunction
function togglemapmarkersandfasttravelstartbattle(bool isattackquest)
endfunction
function togglemapmarkersandfasttravelendbattle(bool isattackquest)
endfunction
function registerimperialattackeraliases(referencealias refalias1, referencealias refalias2, referencealias refalias3, referencealias refalias4, referencealias refalias5, referencealias refalias6, referencealias refalias7, referencealias refalias8, referencealias refalias9, referencealias refalias10 )
endfunction
function registerimperialdefenderaliases(referencealias refalias1, referencealias refalias2, referencealias refalias3, referencealias refalias4, referencealias refalias5, referencealias refalias6, referencealias refalias7, referencealias refalias8, referencealias refalias9, referencealias refalias10 )
endfunction
function registersonsattackeraliases(referencealias refalias1, referencealias refalias2, referencealias refalias3, referencealias refalias4, referencealias refalias5, referencealias refalias6, referencealias refalias7, referencealias refalias8, referencealias refalias9, referencealias refalias10 )
endfunction
function registersonsdefenderaliases(referencealias refalias1, referencealias refalias2, referencealias refalias3, referencealias refalias4, referencealias refalias5, referencealias refalias6, referencealias refalias7, referencealias refalias8, referencealias refalias9, referencealias refalias10 )
endfunction
function registerattackeraliases(referencealias refalias1, referencealias refalias2, referencealias refalias3, referencealias refalias4, referencealias refalias5, referencealias refalias6, referencealias refalias7, referencealias refalias8, referencealias refalias9, referencealias refalias10 )
endfunction
function registerdefenderaliases(referencealias refalias1, referencealias refalias2, referencealias refalias3, referencealias refalias4, referencealias refalias5, referencealias refalias6, referencealias refalias7, referencealias refalias8, referencealias refalias9, referencealias refalias10 )
endfunction
function registergenericaliases( \
referencealias refalias1, referencealias refalias2 = none, referencealias refalias3 = none, referencealias refalias4 = none, referencealias refalias5 = none, referencealias refalias6 = none, referencealias refalias7 = none, referencealias refalias8 = none, referencealias refalias9 = none, referencealias refalias10 = none, \
endfunction
function registergenericattackaliases( \
referencealias refalias1, referencealias refalias2 = none, referencealias refalias3 = none, referencealias refalias4 = none, referencealias refalias5 = none, referencealias refalias6 = none, referencealias refalias7 = none, referencealias refalias8 = none, referencealias refalias9 = none, referencealias refalias10 = none, \
endfunction
function registergenericdefendaliases( \
referencealias refalias1, referencealias refalias2 = none, referencealias refalias3 = none, referencealias refalias4 = none, referencealias refalias5 = none, referencealias refalias6 = none, referencealias refalias7 = none, referencealias refalias8 = none, referencealias refalias9 = none, referencealias refalias10 = none, \
endfunction
function registeraliaseswithcwreinforcementscript(location siegelocationattackpoint)
endfunction
function registerspawnattackeraliaseswithcwreinforcementscript(referencealias marker1alias, referencealias marker2alias, referencealias marker3alias, referencealias marker4alias, referencealias failsafemarkeralias)
endfunction
function registerspawndefenderaliaseswithcwreinforcementscript(referencealias marker1alias, referencealias marker2alias, referencealias marker3alias, referencealias marker4alias, referencealias failsafemarkeralias)
endfunction
function setinfinitepoolsoncwreinforcementscript()
endfunction
function setpoolattackeroncwreinforcementscript(int basepool, float attackdeltamult = 1.0, float scalemult = 1.0, bool infinitepool = false)
endfunction
function setpooldefenderoncwreinforcementscript(int basepool, float attackdeltamult = 1.0, float scalemult = 1.0, bool infinitepool = false)
endfunction
function disableallaliases()
endfunction
function setupaliases(location locationofsiege)
endfunction
function turnonaliases(bool isattackquest)
endfunction
function logattackdefenderaliases()
endfunction
function logalias(referencealias aliastoprinttolog)
endfunction
function setupattackerdefenderaliases(location locationofsiege)
endfunction
function setupaliasesimperialsattacking()
endfunction
function setupaliasessonsattacking()
endfunction
function trytodisablealias(referencealias aliastotry)
endfunction
function trytoenablealias(referencealias aliastotry)
endfunction
function trytoresetalias(referencealias aliastotry)
endfunction
function disableimperialsonsaliases()
endfunction
function enableattackerdefenderaliases()
endfunction
function resetattackerdefenderaliases()
endfunction
function disablegenericaliases()
endfunction
function enablegenericaliases()
endfunction
function resetgenericaliases()
endfunction
function disablegenericattackaliases()
endfunction
function enablegenericattackaliases()
endfunction
function resetgenericattackaliases()
endfunction
function disablegenericdefendaliases()
endfunction
function enablegenericdefendaliases()
endfunction
function resetgenericdefendaliases()
endfunction
function failattackquest(locationalias cityalias)
endfunction
function faildefensequest(locationalias cityalias)
endfunction
function succeeddefensequest(locationalias holdalias, locationalias cityalias, referencealias maingateexterioralias)
endfunction
function trytoturnoncatapultalias(referencealias catapultalias)
endfunction
function trytoturnoffcatapultalias(referencealias catapultalias)
endfunction
bool function isattack()
endfunction
function startcombatsoundsloop()
endfunction
function stopcombatsoundsloop()
endfunction
function setupinteriorsiege(location siegelocation, objectreference fieldcoref, objectreference citycentermarker)
endfunction
function toggleoffcomplexwiinteractions(locationalias locationaliastotoggle)
endfunction
function toggleoncomplexwiinteractions(locationalias locationaliastotoggle)
endfunction 
scene property cwattackerstartingscene  auto  
scene property cwsiegedefenderstartingscene  auto  
quest property cwpreparecity  auto  
sound property ambcivilwarbattledistantlp  auto  
sound property ambcivilwarbattlestart  auto  
sound property ambcivilwarbattlestartdistant  auto  
objectreference property whiterunambext01  auto  
objectreference property whiterunambext02  auto  
int property ambdistantbattlesoundinstance auto
int property ambdistantbattlestartinstance auto
int property ambclosebattlesoundinstance auto
objectreference property whiterunambext03  auto  
globalvariable property cwdistantcatapultsamb  auto  
;This file was cleaned with PapyrusSourceHeadliner 1