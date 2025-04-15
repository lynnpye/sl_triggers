scriptname mannequinactivatorscript extends actor  
idle property pose01 auto
idle property pose02 auto
idle property pose03 auto
form property armorslot01 auto hidden
form property armorslot02 auto hidden
form property armorslot03 auto hidden
form property armorslot04 auto hidden
form property armorslot05 auto hidden
form property armorslot06 auto hidden
form property armorslot07 auto hidden
form property armorslot08 auto hidden
form property armorslot09 auto hidden
form property armorslot10 auto hidden
form property emptyslot auto hidden
message property mannequinactivatemessage auto
message property mannequinarmorweaponsmessage auto
int property currentpose =1 auto
bool property bresetonload = false auto
event oncellload()
endevent
event onload()
endevent
event onactivate(objectreference triggerref)
endevent 
event onitemadded(form akbaseitem, int aiitemcount, objectreference akitemreference, objectreference aksourcecontainer)
endevent
event onobjectunequipped(form akbaseobject, objectreference akreference)
endevent
function resetposition()
endfunction
function playcurrentpose()
endfunction
function equipcurrentarmor()
endfunction
function addtoarmorslot(form akbaseitem)
endfunction
function removefromarmorslot(form akbaseitem)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1