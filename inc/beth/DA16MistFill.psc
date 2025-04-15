scriptname da16mistfill extends objectreference
quest property myquest auto
int property stage auto
objectreference property mistfeed01 auto
objectreference property mistfeed02 auto
objectreference property mist01 auto
objectreference property mist01a auto
objectreference property mist02 auto
objectreference property mist03 auto
objectreference property mist04 auto
objectreference property mist05 auto
bool property dostuffwithmist = true auto 
actor property myactor01 auto
actor property myactor02 auto
actor property myactor03 auto
actor property myactor04 auto
bool property coughingactive = true auto hidden
topic property dialoguegenericpoisoncoughbranchtopic auto
idle property idleuncontrollablecough auto
faction property da16orcdreamfaction auto
faction property da16vaerminadreamfaction auto
objectreference property mysoundobject auto
auto state waiting
event onactivate(objectreference activateref)
endevent
endstate
state complete
event onbeginstate()
endevent
endstate
function docoughing()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1