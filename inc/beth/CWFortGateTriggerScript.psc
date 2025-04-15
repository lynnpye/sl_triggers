scriptname cwfortgatetriggerscript extends objectreference  
globalvariable property debugon auto
quest property cwfortopengate auto
keyword property cwfortopengatestart  auto
faction property cwfortgatefaction auto
objectreference property mygatekeeper auto
faction property myfaction auto
objectreference property mygate auto
objectreference property mylever auto
objectreference property actionrefnpc auto hidden
objectreference property actionrefplayer auto hidden
event oninit()
endevent
state gateshouldremainopen
event onupdate()
endevent
endstate
event ontriggerenter(objectreference akactionref)
endevent
event ontriggerleave(objectreference akactionref)
endevent
function startquest(objectreference akactionref)
endfunction
function opengate()
endfunction
function closegate()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1