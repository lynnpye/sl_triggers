scriptname defaultprisonerdoorscript extends objectreference  
faction property dunprisonerfaction auto
objectreference property prisoner01 auto
objectreference property prisoner02 auto
objectreference property prisoner03 auto
objectreference property prisoner04 auto
objectreference property prisoner05 auto
objectreference property prisoner06 auto
objectreference property prisonerlink auto hidden
bool property alreadyloaded auto hidden
event onload()
endevent
auto state waitingtobeopened
event onopen (objectreference triggerref)
endevent
endstate
state alreadyopened
endstate
;This file was cleaned with PapyrusSourceHeadliner 1