scriptname dlc2dunkolbjornpressuretilescript extends objectreference
effectshader property enchfrostfxshader auto
sound property triggersound auto
event oninit()
endevent
auto state waiting
event ontriggerenter(objectreference akactivator)
endevent
endstate
state intrigger
event ontriggerleave(objectreference akactivator)
endevent 
endstate
event onupdate()
endevent
function turnplateon()
endfunction
function turnplateoff()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1