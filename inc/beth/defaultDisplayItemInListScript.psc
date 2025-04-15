scriptname defaultdisplayiteminlistscript extends objectreference
actor property playerref auto
formlist property itemstodisplay auto
message property itemnotininventorymessage auto
keyword property linkedmarkerkeyword auto
state busy
event onactivate(objectreference akactionref)
endevent
endstate
event onactivate(objectreference akactionref)
endevent
function displayitem(form akitem)
endfunction
function positionitemanddisablephysics(objectreference akitemondisplayref)
endfunction
bool function isoneofitemsondisplay()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1