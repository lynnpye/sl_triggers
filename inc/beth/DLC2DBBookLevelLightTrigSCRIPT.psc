scriptname dlc2dbbooklevellighttrigscript extends objectreference hidden 
bool property bisplaytesting = false auto
bool property bshowdebugtraces = false auto
sound property sdamagefromdarksound auto
imagespacemodifier property imoddamgefromdarkimagespacemodifier auto
event oncellattach()
endevent
event onactivate(objectreference akactionref)
endevent
function dothedamage()
endfunction
event oncelldetach()
endevent
function checkplayerhealthpercentage()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1