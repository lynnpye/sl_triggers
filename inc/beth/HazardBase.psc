scriptname hazardbase extends objectreference
int property damage auto hidden
int property soundlevel = 10 auto 
int property trappushback auto
sound property traphitsound auto
weapon property hitfx auto
ammo property hitfxammo auto
int property traplevel = 1 auto
float property staggeramount = 0.0 auto
bool property checkangle = false auto
auto state canhit
event ontraphit(objectreference aktarget, float afxvel, float afyvel, float afzvel, float afxpos, float afypos, float afzpos, int aematerial, bool abinitialhit, int aemotiontype)
endevent
event ontraphitstart(objectreference aktarget, float afxvel, float afyvel, float afzvel, float afxpos, float afypos, float afzpos, int aematerial, bool abinitialhit, int aemotiontype)
endevent
endstate
state cannothit
endstate
event onload()
endevent
event onupdate()
endevent
function dolocalhit(objectreference aktarget, float afxvel, float afyvel, float afzvel, float afxpos, float afypos, float afzpos, int aematerial, bool abinitialhit, int aemotiontype)
endfunction
bool function isangleacceptable(float afxvel, float afyvel, float afzvel)
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