scriptname testphilslotmachineleverscript extends objectreference  
objectreference property beara auto
objectreference property goata auto
objectreference property horkera auto
objectreference property wolfa auto
objectreference property bearb auto
objectreference property goatb auto
objectreference property horkerb auto
objectreference property wolfb auto
objectreference property bearc auto
objectreference property goatc auto
objectreference property horkerc auto
objectreference property wolfc auto
objectreference property moneyslot auto
message property addgold auto
miscobject property pgold001 auto
objectreference property moneyshooter auto
int property deposit auto hidden
event onactivate(objectreference triggerref)
endevent
function spin(int slotasecs, int slotbsecs, int slotcsecs)
endfunction
int function theodds()
endfunction
function showhead(int slot, int head)
endfunction
function clearheadslot(int slot)
endfunction
function payout()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1