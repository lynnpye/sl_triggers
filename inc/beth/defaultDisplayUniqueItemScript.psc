scriptname defaultdisplayuniqueitemscript extends objectreference
actor property playerref auto
armor property optarmortodisplay auto
weapon property optweapontodisplay auto
miscobject property optmiscobjecttodisplay auto
book property optbooktodisplay auto
message property itemnotininventorymessage auto
keyword property linkedmarkerkeyword auto
event onactivate(objectreference akactionref)
endevent
function displayitem(form akitem)
endfunction
function positionitemanddisablephysics(objectreference akitemondisplayref)
endfunction
form function getdisplayitem()
endfunction
bool function isitemondisplay(form akitem)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1