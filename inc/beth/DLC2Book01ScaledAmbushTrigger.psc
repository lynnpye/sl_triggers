scriptname dlc2book01scaledambushtrigger extends objectreference
bool property doonce = true auto
bool property disablewhendone = false auto
bool property playeronly = true auto
bool property playerandalliesonly = false auto
int property minlevel auto
faction property playerfaction auto
faction property currentfollowerfaction auto
package property follow auto
package property followerpackagetemplate auto
objectreference property controllerref auto
dlc2book01dungeongendeathtrackerparent property controllerscript auto hidden
int property newtotaldeaths = 5 auto hidden
objectreference property ambushactor01 auto
objectreference property ambushactor02 auto
objectreference property ambushactor03 auto
objectreference property ambushactor04 auto
objectreference property ambushactor05 auto
int property actorthreshold2 = 30 auto
int property actorthreshold3 = 40 auto
int property actorthreshold4 = 50 auto
int property actorthreshold5 = 60 auto
auto state waiting
event ontriggerenter(objectreference triggerref)
endevent
endstate
bool function isplayerally(objectreference triggerobj)
endfunction
state alldone
endstate
function updatetotaldeaths()
endfunction
function scaleencounter()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1