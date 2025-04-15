scriptname survival_needbase extends quest
actor property playerref auto
survival_conditionsscript property conditions auto
spell[] property needspells auto
message[] property needmessageswhenincreasing auto
message[] property needmessageswhendecreasing auto
globalvariable property needupdategametimeinterval auto
globalvariable property needvalue auto
globalvariable property penaltypercentglobal auto
globalvariable property needrate auto
globalvariable property needmaxvalue auto
globalvariable property survival_needsleepreducedmetabolismmult auto
globalvariable property survival_exhaustionoverencumberedmult auto
spell property attributepenaltyspell auto
magiceffect property attributepenaltyeffect auto
referencealias property playerdialoguetarget auto
bool property hasbonus = false auto hidden
float property needstage1value auto hidden
float property needstage2value auto hidden
float property needstage3value auto hidden
float property needstage4value auto hidden
float property needstage5value auto hidden
globalvariable property survival_playerlastknowndaysjailed auto
globalvariable property survival_waslastnearbytravelref auto
sound[] property needsoundfxs auto
sound[] property needsoundfxsfemale auto
float[] property needrumblesmallmotorstrengths auto
float[] property needrumblebigmotorstrengths auto
float[] property needrumbledurations auto
bool[] property needplaysoundfxsonimprove auto
bool[] property needplayrumblesonimprove auto
float property needminvalue = 0.0 autoreadonly hidden
float property lastvalue = 100.0 auto hidden
bool property locked = false auto hidden
bool property detectedsleepevent = false auto hidden
bool property detectedfasttravelevent = false auto hidden
bool property wasincreasing = true auto hidden
float property lasttimeingamehours auto hidden
int property oldstage = -1 auto hidden
bool property firstupdate = true auto hidden
function startneed()
endfunction
function stopneed()
endfunction
function setinoblivion(bool inoblivion = true)
endfunction
event onupdategametime()
endevent
function waitforunlock()
endfunction
event onupdate()
endevent
event onsleepstart(float afsleepstarttime, float afdesiredsleependtime)
endevent
float function incrementneed(float currentneedvalue, float amounttoincrementby, float maxvalue = -1.0)
endfunction
float function decrementneed(float currentneedvalue, float amounttodecrementby, float customminvalue = -1.0, float custommaxvalue = -1.0)
endfunction
float function getamounttoincrementby(int ticks, float ratereductionmultiplier)
endfunction
float function getneedratepertick()
endfunction
float function gettotalav(string asattributeav, string aspenaltyav)
endfunction
function clearattributepenalty(string aspenaltyav = "")
endfunction
function handleattributediseaseapply(spell akdisease, activemagiceffect akeffecttodispel, actor aktarget)
endfunction
function updateattributepenalty(float afneedvalue, string asattributeav = "", string aspenaltyav = "")
endfunction
function applyattributepenalty(float aftotalav, float afneedvalue, string asattributeav, string aspenaltyav)
endfunction
function queuepenaltyspellreapply()
endfunction
float function getmaxstagevalue(int maxstageid)
endfunction
int function getticks(float currenttimeingamehours, float lasttimeingamehours)
endfunction
function applyneedstageplayereffects(bool increasing, spell stagespell, message stagemessage, message stagemessageondecrease = none)
endfunction
function applyneedsfx(bool increasing, sound sfx, sound sfxfemale = none, bool applyondecrease = false)
endfunction
function applyneedrumble(bool increasing, float rumblesmall = -1.0, float rumblebig = -1.0, float rumbleduration = -1.0, bool applyondecrease = false)
endfunction
bool function istalkingtonpc() 
endfunction
function needupdategametime()
endfunction
function removeallneedspells()
endfunction
function setneedstagevalues()
endfunction
function basescriptextensionerror(string functionname)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1