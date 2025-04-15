scriptname dlc1_bf_fallingdebriscontrollerscript extends objectreference hidden 
keyword property linkcustom01 auto
keyword property linkcustom02 auto
keyword property linkcustom03 auto
keyword property linkcustom04 auto
keyword property linkcustom05 auto
keyword property linkcustom06 auto
keyword property linkcustom07 auto
keyword property linkcustom08 auto
keyword property linkcustom09 auto
keyword property linkcustom10 auto
float property timebeforeeachplayercheck = 6.0 auto
bool property alreadychangedweather = false auto
bool property doonce auto hidden
event onactivate(objectreference akactionref)
endevent
event oncellattach()
endevent
function foundplayer()
endfunction
function foundplayercompress(objectreference aklink)
endfunction
function beginfalling()
endfunction
function beginfallingcompress(objectreference aklink)
endfunction
function controllerforcecollapse()
endfunction
function controllerforcecollapsecompress(objectreference aklink)
endfunction
function trytodisablelightbeams()
endfunction
function trytodisablelightbeamscompress(objectreference aklink)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1