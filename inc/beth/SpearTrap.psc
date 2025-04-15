scriptname speartrap extends movingtrap
float property initialdelay = 0.05 auto
string property fireanim = "trigger01" auto
string property fireevent = "trapstart" auto
string property resetanim = "open" auto
string property resetevent = "opening" auto
string property startresetanim = "opened" auto
function firetrap()
endfunction
function resetlimiter()
endfunction
event onreset()
endevent
event oncellattach()
endevent
event oncelldetach()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1