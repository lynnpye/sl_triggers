scriptname ccbgs_arswitchscript extends objectreference  
bool property bplayeronly = false auto
bool property bisindownstate = false auto
sound property activatesound auto
event onload()
endevent
event onreset()
endevent
function setdefaultstate()
endfunction
auto state positionup
event onactivate(objectreference akactionref)
endevent
endstate
state positiondown
event onactivate(objectreference akactionref)
endevent
endstate
state busy
endstate
;This file was cleaned with PapyrusSourceHeadliner 1