scriptname da04hubscript extends objectreference  
quest property da04 auto
objectreference property rotatelever auto
objectreference property openlever auto
objectreference property lens auto
objectreference property armillary auto
objectreference property elderscroll auto
referencealias property lexiconstand auto
event onload()
endevent
bool function readytoopen()
endfunction
state ready
event onactivate(objectreference triggerref)
endevent
endstate
state opened
endstate
state busy
endstate
function rotatehub()
endfunction
function openhub()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1