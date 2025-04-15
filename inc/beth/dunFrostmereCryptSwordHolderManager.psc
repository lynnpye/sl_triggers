scriptname dunfrostmerecryptswordholdermanager extends objectreference
formlist property palebladelist auto
weapon property paleblade01 auto
weapon property paleblade02 auto
weapon property paleblade03 auto
weapon property paleblade04 auto
weapon property paleblade05 auto
message property noswordmessage auto
objectreference property invisibleactivator auto
objectreference property swordactivator auto
quest property dunfrostmerecryptqst auto
int property frostmerestagetosetonbanish auto
quest property dunfrostmerebanishtoggleqst auto
int property togglestagetosetonbanish auto
int property togglestagetosetonunbanish auto
effectshader property swordvfxshader auto
objectreference property palelady auto
objectreference property paleladyrespawnpoint auto
objectreference property wisp1respawnpoint auto
objectreference property wisp2respawnpoint auto
objectreference property wisp3respawnpoint auto
objectreference property wisp01 auto
objectreference property wisp02 auto
objectreference property wisp03 auto
objectreference property paleladyfurniture auto
sound property rumblesound auto
auto state ready
event onactivate(objectreference triggerref)
endevent
endstate
state busy
event onactivate(objectreference triggerref)
endevent
endstate
function activatebox()
endfunction
function activatesword(objectreference triggerref)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1