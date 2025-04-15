scriptname defaultownzombie extends actor
objectreference property zombieref01 auto
objectreference property zombieref02 auto
objectreference property zombieref03 auto
objectreference property zombieref04 auto
objectreference property zombieref05 auto
objectreference property zombieref06 auto
effectshader property reanimatefxshader auto
faction property addzombiestothisfaction auto
bool property hasbeenloaded = false auto hidden
event oncellload()
endevent
event ondeath(actor akkiller)
endevent
function makezombie(objectreference actortozombify)
endfunction
function trytokill(objectreference actortokill)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1