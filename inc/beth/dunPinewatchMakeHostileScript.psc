scriptname dunpinewatchmakehostilescript extends objectreference
bool property pbribed auto conditional
objectreference property myactor auto
faction property myfaction auto
string property sactorvariable = "variable01"  auto hidden
float property factorvariable = 1.0 auto hidden
float property faggression = 2.0 auto hidden
auto state waiting
event onactivate(objectreference triggerref)
endevent
endstate
state complete
endstate
;This file was cleaned with PapyrusSourceHeadliner 1