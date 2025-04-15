scriptname da04armillaryscript extends objectreference  
objectreference property forwardlever auto
objectreference property reverselever auto
objectreference property lens auto
referencealias property lexiconstand auto
int property currentpos = -1 auto
event onload()
endevent
state ready
event onactivate(objectreference triggerref)
endevent
endstate
state busy
endstate
function rotateforward()
endfunction
function rotatereverse()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1