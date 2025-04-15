scriptname dlc1dunharkonreanimatedminions extends actor
spell property dlc1dunharkonbattlereanimate auto
bool property disintegrateonspecialdeath auto
bool property isspecialdeath auto hidden
activator property defaultashpile1 auto
effectshader property turnundisintegrate01fxs auto
auto state waiting
event onactivate(objectreference obj)
endevent
endstate
state done
event onactivate(objectreference obj)
endevent
endstate
event ondying(actor akkiller)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1