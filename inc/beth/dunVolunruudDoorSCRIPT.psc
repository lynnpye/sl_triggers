scriptname dunvolunruuddoorscript extends objectreference
quest property myquest auto
weapon property relic01base auto
weapon property relic02base auto
objectreference property relic01static auto
objectreference property relic02static auto
objectreference property door01 auto
objectreference property door02 auto
message property defaultlacktheitemmsg auto
event onload()
endevent
event onload3d()
endevent
state ready
event onload3d()
endevent
event onactivate(objectreference actronaut)
endevent
endstate
state busy
endstate 
;This file was cleaned with PapyrusSourceHeadliner 1