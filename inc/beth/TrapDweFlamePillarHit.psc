scriptname trapdweflamepillarhit extends traphitbase
keyword property flamekeyword auto
explosion property placedexplosion auto hidden
bool property weaponresolved = false auto hidden
int property traplevel = 1 auto
state canhitlocal 
event onbeginstate()
endevent
event ontraphitstart(objectreference triggerref, float afxvel, float afyvel, float afzvel, float afxpos, float afypos, float afzpos, int aematerial, bool abinitialhit, int aemotiontype)
endevent
endstate
event oncellattach()
endevent
int property lvlthreshold1 auto
int property lvlthreshold2 auto
int property lvlthreshold3 auto
int property lvlthreshold4 auto
int property lvlthreshold5 auto
explosion property trapdweflamepillarexplosion01 auto
explosion property trapdweflamepillarexplosion02 auto
explosion property trapdweflamepillarexplosion03 auto
explosion property trapdweflamepillarexplosion04 auto
explosion property trapdweflamepillarexplosion05 auto
explosion property trapdweflamepillarexplosion06 auto
function resolveleveledexplosion ()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1