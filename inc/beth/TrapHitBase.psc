scriptname traphitbase extends objectreference
int property damage auto hidden
int property soundlevel = 10 auto 
int property trappushback auto
sound property traphitsound auto
weapon property hitfx auto
ammo property hitfxammo auto
bool property trapcausesstagger = false auto
bool property rumble = false auto
float property rumbleamount = 0.7 auto
float property rumbleduration = 0.5 auto
bool property camerashake = false auto
float property camerashakeamount = 0.7 auto
float property staggeramount = 0.0 auto
bool property soundcanplay = true auto hidden
float property sounddelay = 1.0 auto
bool property throttlesound = true auto
spell property ghostability auto
bool property hitonlyonce = false auto
explosion property pushbackexplosion auto
bool property candisease auto
float property diseasechance = 2.5 auto
spell property trapdiseaseataxia auto
spell property trapdiseasebonebreakfever auto
spell property trapdiseasebrainrot auto
spell property trapdiseaserattles auto
spell property trapdiseaserockjoint auto
spell property trapdiseasewitbane auto
faction property nohitfaction auto
state canhit 
event ontraphitstart(objectreference aktarget, float afxvel, float afyvel, float afzvel, float afxpos, float afypos, float afzpos, int aematerial, bool abinitialhit, int aemotiontype)
endevent
endstate
auto state cannothit
event ontraphit(objectreference aktarget, float afxvel, float afyvel, float afzvel, float afxpos, float afypos, float afzpos, int aematerial, bool abinitialhit, int aemotiontype)
endevent
endstate
event onupdate()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1