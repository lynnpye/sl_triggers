scriptname defaultplaceatmeonactivate extends objectreference
bool property doonce = true auto
bool property placeall = true auto
explosion property placedexplosion auto 
objectreference property placedobjectref auto
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
function placefirstthing()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1