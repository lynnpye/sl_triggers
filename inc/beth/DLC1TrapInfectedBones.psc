scriptname dlc1trapinfectedbones extends traptriggerbase
weapon property triggereffect auto
ammo property triggereffectammo auto
explosion property havoknudge auto
bool property candisease auto
bool property canvamp auto
float property diseasechance = 40.0 auto
float property vampchance = 10.0 auto
spell property trapdiseaseataxia auto
spell property trapdiseasebonebreakfever auto
spell property trapdiseasebrainrot auto
spell property trapdiseaserattles auto
spell property trapdiseaserockjoint auto
spell property trapdiseasewitbane auto
spell property trapdiseasesanguinarevampiris auto
float property afxvel = 0.0 auto hidden
float property afyvel = 0.0 auto hidden
float property afzvel = 0.0 auto hidden
float property afxpos auto hidden
float property afypos auto hidden
float property afzpos auto hidden
float property trappushback = 0.0 auto
float property damage auto hidden
int property aematerial = 0 auto hidden
float property staggeramount = 0.0 auto
int property traplevel = 1 auto
state active
event onbeginstate()
endevent
event ontriggerenter( objectreference triggerref )
endevent
event ontriggerleave( objectreference triggerref )      
endevent
endstate
state donothing   ;dummy state, don't do anything if animating
event ontriggerenter( objectreference triggerref ) 
endevent
event ontriggerleave( objectreference triggerref ) 
endevent
event oncellattach()
endevent
endstate
event oncellattach()
endevent
event oncelldetach()
endevent
event onreset()
endevent
function processinfection (actor mytarget)
endfunction
int property lvlthreshold1 auto
int property lvldamage1 auto
int property lvlthreshold2 auto
int property lvldamage2 auto
int property lvlthreshold3 auto
int property lvldamage3 auto
int property lvlthreshold4 auto
int property lvldamage4 auto
int property lvlthreshold5 auto
int property lvldamage5 auto
int property lvldamage6 auto
function resolveleveleddamage()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1