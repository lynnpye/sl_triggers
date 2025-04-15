scriptname spiderwebanimationsscript extends objectreference
bool property stopcondition auto hidden
objectreference property myweb auto
objectreference property webactor auto
idle property idlewebthrashshort auto
idle property idlewebthrashshort2 auto
effectshader property webbedfxs auto
function playwebanimations(int irand)
endfunction
auto state begin
event ontriggerenter (objectreference triggerref)
endevent
event ontriggerleave (objectreference triggerref)
endevent
endstate
event onupdate()
endevent
state done
endstate
event onload()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1