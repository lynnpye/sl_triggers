scriptname dlc2book01dungeongendeathtrackerscript extends actor
objectreference property controllerref auto
dlc2book01dungeongendeathtrackerparent property controllerscript auto hidden
bool property doonce = false auto hidden
auto state waiting
event ondeath(actor akkiller)
endevent
endstate
state done
endstate
function processdeath()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1