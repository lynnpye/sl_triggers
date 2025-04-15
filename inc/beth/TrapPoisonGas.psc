scriptname trappoisongas extends objectreference
spell property voicelv01 auto  ; level 1 shout
spell property voicelv02 auto  ; and 2
spell property voicelv03 auto  ; and 3, the most powerful
float property timetoclear auto hidden       ; this variable is set according to what power of shout hit the fog
float property cleartimeweak = 5.0 auto   
float property cleartimemed = 10.0 auto
float property cleartimestrong = 15.0 auto
bool property allowenableflag = true auto
bool property bisfogon = false auto hidden
explosion property poisongasexplosion auto hidden
bool property weaponresolved = false auto hidden
int property traplevel = 1 auto
keyword property gaskeyword auto
magiceffect property gasmagiceffect01 auto
float property fduration = 15.0 auto
bool property isinitiallyactive = true auto
bool property init = false auto hidden
bool property temporarilycleared auto hidden
bool property loop = false auto hidden
event oncellload()
endevent
state on
event onbeginstate()
endevent
event ontrigger(objectreference triggerref)
endevent
event onactivate(objectreference activateref)
endevent
event onhit(objectreference aggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
endstate
auto state off
event onbeginstate()
endevent
event onactivate(objectreference activateref)
endevent
endstate
state tempcleared
event onbeginstate()
endevent
event onactivate(objectreference activateref)
endevent
endstate
function resolveshoutlogic(spell akspell)
endfunction
function resolvegasactivation(objectreference activateref)
endfunction
event onupdate()
endevent
int property lvlthreshold1 auto
int property lvlthreshold2 auto
int property lvlthreshold3 auto
int property lvlthreshold4 auto
int property lvlthreshold5 auto
explosion property trappoisongasexplosion01 auto
explosion property trappoisongasexplosion02 auto
explosion property trappoisongasexplosion03 auto
explosion property trappoisongasexplosion04 auto
explosion property trappoisongasexplosion05 auto
explosion property trappoisongasexplosion06 auto
function resolveleveledexplosion ()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1