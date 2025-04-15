scriptname byohhousefishhatcheryscript extends objectreference  
actor property fishcontainer auto hidden;
float property fspawndays = 1.0 auto ; days between spawning
int property ispawncount = 0 auto
event oncellattach()
endevent
event onactivate(objectreference triggerref)
endevent 
function spawnfish()
endfunction
formlist property byohhousefishcontainerlist auto
objectreference[] property fishreferences auto
globalvariable property gamedayspassed auto
;This file was cleaned with PapyrusSourceHeadliner 1