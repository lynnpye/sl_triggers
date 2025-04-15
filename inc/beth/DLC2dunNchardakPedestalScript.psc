scriptname dlc2dunnchardakpedestalscript extends dlc2dunnchardaksubmersible
miscobject property dlc2dunnchardakcube auto ;the cube base object.
bool property shouldextrude = false auto  ;should this pedestal give the cube back immediately upon use? (red vs. blue)
bool property startsfilled = false auto   ;should a cube be initially placed in this pedestal?
bool property suppressactivation = false auto ;should we suppress activation from the player, and only allow it from non-actor references? used by the bridge puzzle pedestals in the aqueduct.
bool property ifextrudeuseonlyonce = true auto ;internal: if this is an extrude pedestal, should we only allow the player to use it if it isn't in the 'used' state?
float property additionalreturndelay = 0.0 auto ;additional wait time before we allow this pedestal to be activated again.
message property failuremessagenocube auto  ;message to display if the player is out of control cubes.
message property failuremessagealreadyopen auto ;message to display for extrude pedestals if they can only be used once and have already been used.
sound property ambrumbleshakegreybeards auto ;rumble & shake audio (lv1)
sound property ambrumbleshake auto    ;rumble & shake audio (lv2)
int property rumbleshakeintensity = 0 auto  ;intensity for rumble and shake when cubes are inserted or removed. 0=none, 1=light(unused?), 2=normal(water)
bool property isboilerpedestal = false auto   ;is this one of the four pedestals that controls the boilers?
bool property isboilerwaterpedestal = false auto  ;is this one of the three pedestals that controls the water level in the great chamber area?
objectreference property act_waterplanetomodify01 auto  ;move this water plane.
bool property act_waterplane01shouldincrement = false auto ;should we move it up or down?
objectreference property act_objecttoactivate01 auto   ;activate these objects.
objectreference property act_objecttoactivate02 auto
objectreference property act_objecttoactivate03 auto
objectreference property act_objecttoenable auto
objectreference property act_objecttodisable auto
objectreference property act_objecttoactivateonremoveonly01 auto
objectreference property act_sealeddoor auto     ;door seal to break.
objectreference property act_boiler auto      ;boiler to start.
objectreference property act_piston auto      ;linked chain of pistons to stop or start.
objectreference property act_dust auto
quest property act_questtoset auto        ;on insertion, set this quest stage.
int property act_stagetoset auto
bool property nexteventisbackward = false auto hidden  ;internal: for extude pedestals (only), which animation do we play next?
event oninit()
endevent
event onload()
endevent
auto state empty
event onactivate(objectreference akactivator)
endevent
endstate
state filled
event onactivate(objectreference akactivator)
endevent
endstate
state busy
event onactivate(objectreference akactivator)
endevent
endstate
function insertcubeplayer()
endfunction
function removecubeplayer()
endfunction
function insertcubeneloth()
endfunction
bool function removecubeneloth()
endfunction
function resetextrudepedestal()
endfunction
function playfx()
endfunction
function doactioninstant()
endfunction
function doaction(int whichactions)
endfunction
function undoactioninstant()
endfunction
function undoaction(int whichactions)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1