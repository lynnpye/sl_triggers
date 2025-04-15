scriptname ccbgs_arspiketrapscript extends hazardbase
float property fhazardinterval = 5.0 auto
auto state canhit
event ontraphit(objectreference aktarget, float afxvel, float afyvel, float afzvel, float afxpos, float afypos, float afzpos, int aematerial, bool abinitialhit, int aemotiontype)
endevent
endstate
event onupdate()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1