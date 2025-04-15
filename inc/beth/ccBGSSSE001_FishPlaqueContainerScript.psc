scriptname ccbgssse001_fishplaquecontainerscript extends actor
event onitemadded(form akbaseitem, int aiitemcount, objectreference akitemreference, objectreference aksourcecontainer)
endevent
function setplaque(ccbgssse001_fishplaquescript akplaque)
endfunction
function returnitemtoplayer(form akbaseitem, int aiamounttoreturn, bool abshowmultipleitemerror = true)
endfunction
state working
event onitemadded(form akbaseitem, int aiitemcount, objectreference akitemreference, objectreference aksourcecontainer)
endevent
endstate
message property ccbgssse001_fishplaqueonlyoneitemmsg auto
message property ccbgssse001_fishplaquesuccessmsg auto
;This file was cleaned with PapyrusSourceHeadliner 1