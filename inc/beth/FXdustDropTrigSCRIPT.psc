scriptname fxdustdroptrigscript extends objectreference 
explosion property fallingdustexplosion01 auto
sound property mysfx auto   ; specify sfx to play
auto state latent        ; by default, just sit still and wait for a trigger event
event ontriggerenter(objectreference trigref)
endevent
endstate
state active  
event onbeginstate()
endevent
endstate
state waiting
event onbeginstate()
endevent   
endstate
;This file was cleaned with PapyrusSourceHeadliner 1