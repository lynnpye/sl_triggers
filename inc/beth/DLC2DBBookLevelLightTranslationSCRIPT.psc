scriptname dlc2dbbooklevellighttranslationscript extends objectreference hidden 
float property fmovementspeed = 50.0 auto
bool property bshowdebugtraces = false auto
int property imovementtype = 0 auto
event oncellattach()
endevent
event onactivate(objectreference akactionref)
endevent
event onload()
endevent
event oncelldetach()
endevent
function dolightmovement()
endfunction
event ontranslationcomplete()
endevent
event ontranslationalmostcomplete()
endevent
function handletransitionend()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1