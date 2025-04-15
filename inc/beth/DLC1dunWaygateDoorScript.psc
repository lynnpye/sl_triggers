scriptname dlc1dunwaygatedoorscript extends objectreference
keyword property linkcustom01 auto ;my waygate
keyword property linkcustom02 auto ;the waygate my door connection is part of
keyword property linkcustom03 auto ;the door i'm connected to
keyword property linkcustom04 auto ;the door i'm connected to
event onload()
endevent
event oncellattach()
endevent
function openportal()
endfunction
auto state waiting
event onactivate(objectreference akactionref)
endevent
endstate
state donothing
event onactivate(objectreference akactionref)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1