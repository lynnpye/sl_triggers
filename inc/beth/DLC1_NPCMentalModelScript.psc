scriptname dlc1_npcmentalmodelscript extends quest conditional
int property debugguardedtoopen
function set(int val)
endfunction
endproperty
int property debugserioustoplayful
function set(int val)
endfunction
endproperty
int property axisguardedtoopen
int function get()
endfunction
function set(int newvalue)
endfunction
endproperty
int property axisserioustoplayful
int function get()
endfunction
function set(int newvalue)
endfunction
endproperty
function slamtoopen()
endfunction
function slamtoguarded()
endfunction
function slamtoplayful()
endfunction
function slamtoserious()
endfunction
float property playerassessmentintelligence
float function get()
endfunction
function set(float newvalue)
endfunction
endproperty
float property playerassessmentindependence
float function get()
endfunction
function set(float newvalue)
endfunction
endproperty
bool property followdistancefar auto conditional
bool property followdistancemedium auto conditional
bool property followdistanceclose auto conditional
function debugoutput()
endfunction
function dumphistory()
endfunction
int function clampint(int value, int min, int max)
endfunction
float function clampfloat(float value, float min, float max)
endfunction
function modaxis(int axisindex, int amount)
endfunction
function modassessment(int assessmentindex, float amount)
endfunction
function increaseserious(int amount = 1)
endfunction
function increaseplayful(int amount = 1)
endfunction
function increaseguarded(int amount = 1)
endfunction
function increaseopen(int amount = 1)
endfunction
function decreaseserious(int amount = 1)
endfunction
function decreaseplayful(int amount = 1)
endfunction
function decreaseguarded(int amount = 1)
endfunction
function decreaseopen(int amount = 1)
endfunction
function increaseintelligenceminor()
endfunction
function increaseintelligencemoderate()
endfunction
function increaseintelligencemajor()
endfunction
function decreaseintelligenceminor()
endfunction
function decreaseintelligencemoderate()
endfunction
function decreaseintelligencemajor()
endfunction
function increaseindependenceminor()
endfunction
function increaseindependencemoderate()
endfunction
function increaseindependencemajor()
endfunction
function decreaseindependenceminor()
endfunction
function decreaseindependencemoderate()
endfunction
function decreaseindependencemajor()
endfunction
idle property rf_moodchangeguarded auto
idle property rf_moodchangeopen auto
idle property rf_moodchangeserious auto
idle property rf_moodchangeplayful auto
function axiscrossedover()
endfunction
actor property serana auto
referencealias property rnpc auto
referencealias property rnpc_essential auto
referencealias property rnpc_keywords auto
dlc1npcmonitoringplayerscript property monitoringquest auto
function setup(int forcenpc=0)
endfunction
bool property questlinecompleted auto conditional
quest property dialoguefollower auto
referencealias property centralfolloweralias auto
bool property simplefollow auto conditional
bool property playersettled auto conditional
bool property lockedin auto conditional
globalvariable property followercount auto
bool property canfollow auto conditional
bool property isfollowing auto conditional
bool property iswillingtowait auto conditional
bool property iswaiting auto conditional
bool property isdismissed auto conditional
bool property canbedismissed auto conditional
bool property turnoffcomewithme = false auto conditional
referencealias property homemarker auto
objectreference property prechoicemarker auto
objectreference property vamphomemarker auto
objectreference property hunterhomemarker auto
faction property wifollowercommentfaction auto
function lockin()
endfunction
function unlock()
endfunction
function engagefollowbehavior(bool allowdismiss=false)
endfunction
function disengagefollowbehavior()
endfunction
function sethomemarker(int choiceset, objectreference newhomemarker=none)
endfunction
function wait()
endfunction
function stopwaiting()
endfunction
function finishwaiting()
endfunction
function dismiss()
endfunction
int property secondsbetweenperiodicupdates auto
event onupdate()
endevent
function questlinefinish()
endfunction
formlist property sundamageexceptionlist auto
armor property vamparmor auto
armor property hoodie auto
function checkoutfit()
endfunction
bool property likesplayerpostquest = false auto conditional
bool property playerinsultedfamily = false auto conditional
bool property toldplayershedidntwantcure = false auto conditional
bool property willingtotradeitemswithplayer = false auto conditional
bool property cutoffcurediscussion = false auto conditional
bool property playertalkedaboutparents = false auto conditional
bool property playerparentsalive = false auto conditional
bool property playerlikedparents = false auto conditional
bool property playerorphan = false auto conditional
bool property talkedaboutkillingharkon = false auto conditional
bool property playernaive = false auto conditional
bool property talkedaboutkillingharkonforreal = false auto conditional
int  property mentionedloneliness = 0 auto conditional
bool property believesplayerismarried = false auto conditional
bool property happyhomelife = false auto conditional
bool property unhappyhomelife = false auto conditional
bool property spouseismale = false auto conditional
bool property dtr = false auto conditional
bool property hadmarriagetalk = false auto conditional
bool property talkedpostquest = false auto conditional
;This file was cleaned with PapyrusSourceHeadliner 1