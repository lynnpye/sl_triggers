scriptname mqshouttrigger extends objectreference 
spell property voiceclearskies1 auto  ; level 1 shout
spell property voiceclearskies2 auto  ; and 2
spell property voiceclearskies3 auto  ; and 3, the most powerful
spell property mqclearskyfogspell auto
int property cleartimeweak = 5 auto   
int property cleartimemed = 10 auto
int property cleartimestrong = 15 auto
bool property allowenableflag = true auto
bool property bisfogon = true auto hidden
bool property bdebug = false auto hidden
globalvariable property mqclearskyfogglobal auto
auto state waitingfortrigger
event ontriggerenter (objectreference triggerref)
endevent
event ontriggerleave(objectreference triggerref)
endevent
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
endstate
state hasbeentriggered
endstate
function resolvetriggerlogic(objectreference triggerref = none, spell spellref = none)
endfunction
function firetriggerevent(spell akspell)
endfunction
function setfogstate(bool bturnonfog)
endfunction
bool function isfogon()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1