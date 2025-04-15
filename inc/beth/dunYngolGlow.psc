scriptname dunyngolglow extends objectreference
objectreference property mytarget auto
cell property myhomecell auto
quest property myquest auto
sound property qstyngollightmotessd auto
event onactivate(objectreference actronaut)
endevent
state active
event onactivate(objectreference actronaut)
endevent
event onupdate()
endevent
endstate  
state dead
event onbeginstate()
endevent
event onactivate(objectreference actronaut)
endevent
endstate
function jumpat(objectreference target)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1