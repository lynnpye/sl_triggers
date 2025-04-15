scriptname dlc2dunkolbjornpillarpuzzlelever extends objectreference
keyword property linkcustom01 auto
keyword property linkcustom02 auto
int property pillarcount auto
objectreference property refactregardless auto
objectreference property refactonsuccess01 auto
objectreference property refactonsuccess01b auto
objectreference property refdisableonsuccess01b auto
objectreference property refactonsuccess02 auto
objectreference property refdisableonsuccess02 auto
objectreference property refactonfailure01 auto
objectreference property refactonfailure02 auto
objectreference property refactonfailure03 auto
objectreference property refactonfailure04 auto
function doorordarts()
endfunction
auto state waiting
event onactivate (objectreference triggerref)
endevent
endstate
state busy
event onactivate (objectreference triggerref)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1