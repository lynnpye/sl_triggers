scriptname fxbirdfleescript extends objectreference  
sound property birdflocksound auto
sound property birdflockfleesound auto
bool property playertriggered = false auto
event oncellattach()
endevent
state waiting
event ontriggerenter(objectreference akactionref)
endevent
endstate
state donothing
endstate
;This file was cleaned with PapyrusSourceHeadliner 1