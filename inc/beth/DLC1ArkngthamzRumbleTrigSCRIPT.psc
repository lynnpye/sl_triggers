scriptname dlc1arkngthamzrumbletrigscript extends objectreference hidden 
sound property ambrumbleshake auto
explosion property fallingdustexplosion01 auto
float property waitforrumblemax = 60.0 auto
float property waitforrumblemin = 45.0 auto
bool property checkdistance = false auto
float property distancefromtrigger = 6000.0 auto
globalvariable property dlc1arkgnthamzrumbleglobal auto
event oncellattach()
endevent
event onactivate(objectreference akactionref)
endevent
function forcerumbleandresettimer()
endfunction
function handlerumble()
endfunction
function placedustexplosions()
endfunction
event oncelldetach()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1