scriptname dlc1dunstatuehitscript extends objectreference hidden 
keyword property linkcustom01 auto
keyword property linkcustom02 auto
keyword property linkcustom03 auto
keyword property linkcustom04 auto
keyword property linkcustom05 auto
keyword property weaptypestaff auto
int property istatuetype auto
int property ihittype auto hidden
int property icurrentrotation = -1 auto hidden
bool property bwascorrecthit auto hidden
quest property myquest auto
int property stagetosetonfirstfail auto
int property stagetosetonfirstcorrecthit auto
int property stagetosetoncomplete auto
bool property balreadyhitincorrectly auto
bool property balreadyhitcorrectly auto
event oncellattach()
endevent
event onanimationevent(objectreference aksource, string aseventname)
endevent
state donothing
endstate
auto state waitingforhit
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
endstate
state rotatingpillar
event onbeginstate()
endevent
endstate
state beencorrectlyhit
event onbeginstate()
endevent
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1