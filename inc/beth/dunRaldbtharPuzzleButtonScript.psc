scriptname dunraldbtharpuzzlebuttonscript extends objectreference
int property pillarslit = 0 auto hidden
bool property blockactivate = true auto hidden
message property dunraldbtharbuttonmsg auto
event onload()
endevent
auto state closed
event onactivate(objectreference akactivator)
endevent
function incrementpillarslit()
endfunction
endstate
state open
event onactivate(objectreference akactivator)
endevent
endstate
state waiting
endstate
function incrementpillarslit()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1