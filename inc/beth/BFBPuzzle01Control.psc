scriptname bfbpuzzle01control extends objectreference
bool property puzzlesolved auto hidden
bool property dooropened auto hidden
int property numpillarssolved auto hidden
objectreference property puzzledooractivator auto
int property pillarcount auto
objectreference property refactonsuccess01 auto
objectreference property refactonfailure01 auto
objectreference property refactonfailure02 auto
objectreference property refactonfailure03 auto
objectreference property refactonfailure04 auto
action property animaction auto
function doorordarts()
endfunction
auto state pulledposition
event onactivate (objectreference triggerref)
endevent
endstate
state pushedposition
event onactivate (objectreference triggerref)
endevent
endstate
state busy
event onactivate (objectreference triggerref)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1