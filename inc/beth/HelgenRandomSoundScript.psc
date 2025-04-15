scriptname helgenrandomsoundscript extends objectreference  
sound property mysound01 auto
sound property mysound02 auto
objectreference property mysoundorigin01 auto
objectreference property mysoundorigin02 auto
objectreference property mysoundorigin03 auto
float property fcamerashake01 auto
float property fcamerashake02 auto
float property fduration01 auto
float property fduration02 auto
float property flintensity01 auto
float property flintensity02 auto
float property frintensity01 auto
float property frintensity02 auto
int property maxtimer = 30 auto
int property mintimer = 20 auto
auto state playsound
event ontriggerenter (objectreference triggerref)
endevent
event ontriggerleave (objectreference triggerref)
endevent
endstate
event onupdate()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1