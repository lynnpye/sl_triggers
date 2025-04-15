scriptname dundustmanscairnendcontroller extends objectreference
int property draugrkilled = 0 auto
int property totaldraugr = 16 auto
objectreference property opendoor auto
objectreference property lockeddoor auto
objectreference property lastdraugr auto
objectreference property bossdraugr auto
quest property c01 auto
c01questscript property c01script auto
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
objectreference property draugr11 auto
objectreference property draugr12 auto
objectreference property draugr13 auto
objectreference property draugr14 auto
objectreference property draugr15 auto
objectreference property draugr16 auto
objectreference property draugr17 auto
bool property isloaded auto hidden
auto state waiting
event onactivate(objectreference triggerref)
endevent
endstate
state endsequenceactive
event onbeginstate()
endevent
endstate
function incrementdeathcounter()
endfunction
state endsequencecomplete
endstate
event oncellattach()
endevent
event oncelldetach()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1