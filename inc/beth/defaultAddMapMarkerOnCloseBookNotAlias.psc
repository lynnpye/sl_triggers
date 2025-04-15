scriptname defaultaddmapmarkeronclosebooknotalias extends objectreference  
objectreference property mapmarker1 auto
objectreference property mapmarker2 auto
objectreference property mapmarker3 auto
objectreference property mapmarker4 auto
objectreference property mapmarker5 auto
bool property allowfasttravel = false auto
auto state ready
event onactivate(objectreference akactionref)
endevent
event onequipped(actor akactor)
endevent
endstate
state done
endstate
function stagehandling()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1