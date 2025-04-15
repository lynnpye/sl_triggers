scriptname helgenhallcollapsescript extends objectreference  
sound property mysound01 auto
objectreference property mysoundorigin01 auto
objectreference property mydustorigin01 auto
objectreference property mydustorigin02 auto
explosion property mydustfx auto
float property fcamerashake01 auto
float property fcamerashake02 auto
float property fduration01 auto
float property fduration02 auto
float property flintensity01 auto
float property flintensity02 auto
float property frintensity01 auto
float property frintensity02 auto
objectreference property staggerorigin auto
objectreference property impforthallcollapsefx01 auto
referencealias property hallwaystormcloak01 auto
referencealias property hallwaystormcloak02 auto
referencealias property hallwaystormcloak03 auto
auto state waiting
event ontriggerenter (objectreference triggerref)
endevent
endstate
state done
endstate
function triggercollapse()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1