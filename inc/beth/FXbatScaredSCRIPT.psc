scriptname fxbatscaredscript extends objectreference  
sound property mysfx auto         ; specify sound fx to play
weapon property weaplg auto  ; specify large weapon type
ammo property myammo auto   ; specify ammo type
auto state waiting
event ontriggerenter(objectreference akactionref)
endevent
endstate
state busy
endstate
;This file was cleaned with PapyrusSourceHeadliner 1