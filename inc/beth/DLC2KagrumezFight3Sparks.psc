scriptname dlc2kagrumezfight3sparks extends objectreference  
spell property sparks auto
objectreference property caster01 auto
objectreference property target01 auto
objectreference property caster02 auto
objectreference property target02 auto
bool property toggler = false auto hidden
function castspells()
endfunction
auto state waiting
event onactivate(objectreference actronaut)
endevent
endstate
state buffer
endstate
;This file was cleaned with PapyrusSourceHeadliner 1