scriptname batteringtrap extends movingtrap
float property initialdelay = 0.25 auto
bool property reseteventrecieved = false auto hidden
function firetrap()
endfunction
function resetlimiter()
endfunction
event onload()
endevent
event onanimationevent(objectreference aksource, string aseventname)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1