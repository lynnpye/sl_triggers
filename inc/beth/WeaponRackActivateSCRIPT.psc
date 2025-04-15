scriptname weaponrackactivatescript extends objectreference hidden 
int property racktype = 1 auto
bool property patch14coaracks = false auto
message property patch14weaponracknobowmessage auto
message property weaponrackactivatemessage auto
message property weaponracknoshieldmessage auto
message property weaponracknoweaponmessage auto
message property weaponracknodaggermessage auto
message property weaponracknobowmessage auto
message property weaponrackonlydaggermessage auto
int property buttonpressed auto hidden
bool property alreadyinit auto hidden
bool property messagealreadyshown auto hidden
globalvariable property wrackglobal auto
keyword property wrackgreatsword auto
keyword property wrackwarhammer auto
keyword property wrackbattleaxe auto
keyword property wrackbow auto
keyword property wracksword auto
keyword property wrackmace auto
keyword property wrackwaraxe auto
keyword property wrackstaff auto
keyword property wrackshield auto
keyword property wracktrigger auto
keyword property weapontypebattleaxe auto
keyword property weapontypebow auto
keyword property weapontypedagger auto
keyword property weapontypegreatsword auto
keyword property weapontypemace auto
keyword property weapontypestaff auto
keyword property weapontypesword auto
keyword property weapontypewaraxe auto
keyword property weapontypewarhammer auto
keyword property armorshield auto
objectreference property greatswordmarker auto hidden
objectreference property warhammermarker auto hidden
objectreference property battleaxemarker auto hidden
objectreference property bowmarker auto hidden
objectreference property swordmarker auto hidden
objectreference property macemarker auto hidden
objectreference property waraxemarker auto hidden
objectreference property staffmarker auto hidden
objectreference property shieldmarker auto hidden
objectreference property triggermarker auto hidden
keyword property wrackstartingweapon auto hidden
objectreference property startingweapon auto hidden
int property itemtype auto hidden
weapon property playersequippedweapon auto hidden
armor property playersequippedshield auto hidden
objectreference property playersdroppedweapon auto hidden
int property playersequippedweapontype auto hidden
event oncellattach()
endevent
auto state emptyrack
event onactivate(objectreference triggerref) 
endevent
endstate
function handleweaponplacement(bool forstartingweapon = false)
endfunction
function handlestartingweapon()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1