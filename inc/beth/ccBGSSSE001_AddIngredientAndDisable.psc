scriptname ccbgssse001_addingredientanddisable extends objectreference  
ingredient property ingredienttoadd auto
sound property harvestsound auto
auto state ready
event onactivate(objectreference akactionref)
endevent
endstate
state busy
event onactivate(objectreference akactionref)
endevent
endstate
state done
event onactivate(objectreference akactionref)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1