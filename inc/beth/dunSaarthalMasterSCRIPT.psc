scriptname dunsaarthalmasterscript extends actor  
spell property flameability auto
spell property frostability auto
spell property stormability auto
spell property damagereduc auto
objectreference property barriercage auto
objectreference property barriercollision auto
effectshader property barriereffect auto
location property saarthallocation auto
event oncellattach()
endevent
event oncelldetach()
endevent
event onupdate()
endevent
event ondying(actor akkiller)
endevent
function formselect()
endfunction
objectreference property barrierdisablesound  auto  
;This file was cleaned with PapyrusSourceHeadliner 1