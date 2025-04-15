scriptname dunhillgrundstombendcontroller extends objectreference
int property draugrkilled = 0 auto
int property totaldraugr = 10 auto
objectreference property valsveran auto
objectreference property bossdraugr auto
spell property invisibility auto
faction property warlockfaction auto
faction property draugrfaction auto
float property faggression = 2.0 auto
objectreference property draugr01 auto
objectreference property draugr02 auto
objectreference property draugr03 auto
objectreference property draugr04 auto
objectreference property draugr05 auto
objectreference property draugr06 auto
objectreference property draugr07 auto
objectreference property draugr08 auto
objectreference property draugr09 auto
objectreference property draugr10 auto
auto state waiting
event onactivate(objectreference triggerref)
endevent
endstate
state endsequenceactive
event onbeginstate()
endevent
endstate
state endsequencecomplete
endstate
function incrementdeathcounter()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1