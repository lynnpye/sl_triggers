scriptname physicstraphit extends traphitbase
float property damagevelocitythreshold = 6.0 auto
auto state canhit 
event ontraphitstart(objectreference aktarget, float afxvel, float afyvel, float afzvel, float afxpos, float afypos, float afzpos, int aematerial, bool abinitialhit, int aemotiontype)
endevent
endstate
state cannothit
event ontraphit(objectreference aktarget, float afxvel, float afyvel, float afzvel, float afxpos, float afypos, float afzpos, int aematerial, bool abinitialhit, int aemotiontype)
endevent
endstate
bool function acceptablevelocitydelta(float targetvelocity, float afxvel, float afyvel, float afzvel)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1