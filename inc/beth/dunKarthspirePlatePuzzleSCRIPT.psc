scriptname dunkarthspireplatepuzzlescript extends traptriggerbase  
bool property bsafe=false auto
spell property spelldmg auto
perk property karthlightfoot auto
objectreference property castsource auto
event onload()
endevent
auto state active
event ontriggerenter( objectreference triggerref ) 
endevent
event ontriggerleave( objectreference triggerref )
endevent
endstate
state donothing   ;dummy state, don't do anything if animating
event ontriggerenter( objectreference triggerref ) 
endevent
event ontrigger( objectreference triggerref ) 
endevent
event ontriggerleave( objectreference triggerref )
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1