scriptname tg08earthquakedusteffects extends objectreference
bool property doonce = true auto
bool property placeall = true auto
explosion property placedexplosion auto 
objectreference property placedobjectref auto
sound property rockfallsound auto
bool property cannedhallwaydust = false auto
auto state waiting
event onactivate(objectreference triggerref)
endevent
endstate
state donothing
event onactivate(objectreference triggerref)
endevent
endstate
function placeallthings()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1