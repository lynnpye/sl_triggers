scriptname trapdwepiston extends movingtrap
float property initialdelay = 0.25 auto
string property fireanim = "up" auto
string property fireevent = "transup" auto
string property resetanim = "down" auto
string property resetevent = "transdown" auto
string property startswunganim = "startup" auto
bool property startswung = false auto hidden
event oncellattach()
endevent
function firetrap()
endfunction
function resetlimiter()
endfunction
event onreset()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1