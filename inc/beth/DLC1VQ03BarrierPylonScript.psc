scriptname dlc1vq03barrierpylonscript extends objectreference
miscobject property dlc1vq03magicwidget auto
quest property dlc1vq03hunter auto
int property hunterstage auto
int property hunterobjectivestage = 61 auto
quest property dlc1vq03vampire auto
int property vampirestage auto
int property vampireobjectivestage = 61 auto
message property dlc1vq03barriermessage auto
float property stagedelay = 2.0 auto
objectreference property dlc1vq03barrierstone01 auto
objectreference property dlc1vq03barrierstone02 auto
objectreference property dlc1vq03barrierstone03 auto
objectreference property dlc1vq03barrierstone04 auto
objectreference property dlc1vq03barrier auto
objectreference property dlc1vq03barrierlight auto
objectreference property dlc1vq03lightactivateparent auto
float property rumbleamount1 = 0.3 auto
float property rumbleduration = 6.0 auto
float property camerashakeamount1 = 0.2 auto
sound property ambevernightcryptrumblesd auto
sound property qstwaystonemagicbarrierlpm auto
int property barriersoundinstance auto hidden
event onactivate(objectreference activateref)
endevent
event onload()
endevent
function lowerthebarrier()
endfunction
event onupdate()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1