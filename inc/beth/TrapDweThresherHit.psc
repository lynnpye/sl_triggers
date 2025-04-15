scriptname trapdwethresherhit extends traphitbase
state cannothit
event ontraphit(objectreference aktarget, float afxvel, float afyvel, float afzvel, float afxpos, float afypos, float afzpos, int aematerial, bool abinitialhit, int aemotiontype)
endevent
event onanimationevent(objectreference eventobject, string eventstring)
endevent
endstate
auto state canhit 
event ontraphit(objectreference aktarget, float afxvel, float afyvel, float afzvel, float afxpos, float afypos, float afzpos, int aematerial, bool abinitialhit, int aemotiontype)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1