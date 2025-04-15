scriptname lumbermillsawscript extends objectreference  
objectreference property log auto
objectreference property sash auto
message property sabatogemessage auto
message property repairmessage auto
auto state normal
event onactivate ( objectreference triggerref )
endevent
endstate
state busy
endstate
state destroyed
event onactivate ( objectreference triggerref )
endevent
endstate
function destroy()
endfunction
function repair()
endfunction
function saw()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1