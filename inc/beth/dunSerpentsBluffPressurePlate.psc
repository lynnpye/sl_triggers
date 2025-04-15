scriptname dunserpentsbluffpressureplate extends traptriggerbase
objectreference property portcullis auto
event onload()
endevent
event onunload()
endevent
function updateloop()
endfunction
auto state up
event ontriggerenter(objectreference triggerref)
endevent
event ontriggerleave(objectreference triggerref)
endevent
endstate
state down
event ontriggerenter(objectreference triggerref)
endevent
event ontriggerleave(objectreference triggerref)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1