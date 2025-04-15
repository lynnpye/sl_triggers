scriptname da02pillartriggerscript extends objectreference  
da02script property da02 auto
objectreference property da02pillarref auto
objectreference property shrineofboethiahref auto
objectreference property boethiahbluepulselightref auto 
event oncellattach()
endevent
event oncelldetach()
endevent
event ontriggerenter(objectreference akactionref)
endevent
event ontriggerleave(objectreference akactionref)
endevent 
event onanimationevent(objectreference aksource, string aseventname)
endevent
function checkcountplayeffect(int val)
endfunction
function turnon()
endfunction
function turnoff()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1