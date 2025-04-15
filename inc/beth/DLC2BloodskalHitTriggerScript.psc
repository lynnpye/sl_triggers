scriptname dlc2bloodskalhittriggerscript extends objectreference  
objectreference property dlc2bloodskaldoorcontrollerref auto
dlc2bloodskaldoorcontrollerscript property mycontroller auto hidden
bool property triggeronvertprojectile = false auto
form property dlc2bloodskalareaprojectilehoriz auto
form property dlc2bloodskalareaprojectilevert auto
auto state waiting
event ontriggerenter(objectreference triggerref)
endevent
endstate
state done
endstate
function sendhittocontroller()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1