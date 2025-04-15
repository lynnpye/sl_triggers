scriptname dlc1ld_forgesteamvalvescript extends objectreference
quest property dlc1ld_bthalft auto
objectreference property dlc1ld_fxsteamleft auto
objectreference property dlc1ld_fxsteamright auto
objectreference property dlc1ld_fxsteamcenter auto
objectreference property dlc1ld_fxsteamforge auto
sound property objpipevalvewheelrotatemarker auto
bool property isrightvalve auto
message property dlc1ld_bthalftvalvefailmessage auto
event oncellattach()
endevent
function turnvalve()
endfunction
auto state ready
event onactivate(objectreference obj)
endevent
endstate
state animating
event onactivate(objectreference obj)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1