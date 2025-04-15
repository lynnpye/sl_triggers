scriptname dlc2dunnchardakdoorseal extends dlc2dunnchardaksubmersible conditional
objectreference property linkeddoor auto      ;the door this seal seals (if any).
objectreference property permittedactivator auto    ;for special cases (the centurion door), one specific activator we allow to open the door.
objectreference property linkedpedestal auto     ;for special cases (doors that reseal), the extrude pedestal that opens the door, so we can reset it when we reclose.
bool property isloaddoor = true auto       ;when the seal is released, allow the player to activate load doors. auto-open standard doors.
bool property noreallythisshouldbesubmersible = false auto ;overrides the default 'true' submersibility, since we don't need or want most sealed doors to be submersible.
bool property activationshouldtoggle = false auto    ;for activation by permitted activators only, should we toggle the gate open and closed?
message property sealeddoormessage auto       ;message to display on interaction.
bool property issealed = true auto conditional ;are we still sealed?
event oncellattach()
endevent
function releaseseal()
endfunction
function restoreseal()
endfunction
event onupdate()
endevent
event onanimationevent(objectreference source, string eventname)
endevent
event onactivate(objectreference akactivator)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1