scriptname cwcatapultoffscreenfirecontrolscript extends objectreference  
auto state offscreenfiremodeoff
event onupdate()
endevent
endstate 
state offscreenfiremodebusyfiring
event onupdate()
endevent
endstate
state offscreenfiremodewaitingtofire
event onupdate()
endevent
endstate
function stopoffscreenfiring()
endfunction
function startoffscreenfiring(float launchtime)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1