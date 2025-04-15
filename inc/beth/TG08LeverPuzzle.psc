scriptname tg08leverpuzzle extends objectreference
objectreference property torchoff auto
objectreference property torchon auto
objectreference property gears auto
objectreference property gears2 auto
objectreference property pairedlever auto
objectreference property polelinker auto
objectreference property glow auto
bool property leveractivated = false auto hidden
bool property isloaded auto hidden
float property pulledtimerduration = 30.0 auto hidden
float property currentpulledtimer auto hidden
bool property parentlever = false auto
bool property puzzlesolved = false auto hidden
objectreference property tg08bpuzzlegateenableparent auto
bool property isinpullposition = true auto
event oncellload()
endevent
event onreset()
endevent
auto state pulledposition
event onactivate (objectreference triggerref)
endevent
endstate
state pushedposition
event onbeginstate()
endevent
endstate
state busy
event onactivate (objectreference triggerref)
endevent
endstate
state complete
event onbeginstate()
endevent
event onactivate (objectreference triggerref)
endevent
endstate
function setdefaultstate()
endfunction
function spinup()  ;turn on gear
endfunction
function spindown() ;turn off gear
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1