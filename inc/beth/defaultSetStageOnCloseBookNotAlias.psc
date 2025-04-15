scriptname defaultsetstageonclosebooknotalias extends objectreference  
int property prereqstage = -1 auto
int property stagetoset auto
quest property myquest auto
auto state ready
event onactivate(objectreference akactionref)
endevent
event onequipped(actor akactor)
endevent
event onread()
endevent
endstate
state done
endstate
function stagehandling()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1