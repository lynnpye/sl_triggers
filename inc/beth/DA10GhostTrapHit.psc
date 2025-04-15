scriptname da10ghosttraphit extends referencealias
int property damage auto hidden
int property soundlevel = 10 auto 
int property trappushback auto
sound property traphitsound auto
weapon property hitfx auto
ammo property hitfxammo auto
auto state canhit 
event ontraphit(objectreference aktarget, float afxvel, float afyvel, float afzvel, float afxpos, float afypos, float afzpos, int aematerial, bool abinitialhit, int aemotiontype)
endevent
endstate
state cannothit
event ontraphit(objectreference aktarget, float afxvel, float afyvel, float afzvel, float afxpos, float afypos, float afzpos, int aematerial, bool abinitialhit, int aemotiontype)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1