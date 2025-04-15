scriptname ccbgs_arportcullisscript extends objectreference
keyword property linkcustom01 auto
bool property bdownbydefault = false auto
bool property bdoonce = false auto
bool property bcanactorsopen = false auto
message property messagetoshow auto
sound property soundopen auto
sound property soundclose auto
event onload()
endevent
event onreset()
endevent
function setdefaultstate()
endfunction
auto state up
event onactivate(objectreference akactionref)
endevent
endstate
state down
event onactivate(objectreference akactionref)
endevent
endstate
state busy
endstate
state finished
endstate
function enablelinkedref()
endfunction
function disablelinkedref()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1