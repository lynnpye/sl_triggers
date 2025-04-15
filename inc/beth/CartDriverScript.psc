scriptname cartdriverscript extends objectreference  
objectreference property mycart auto
objectreference property myhorse auto
idle property idlecartplayeridle auto
idle property idlecartplayerexit auto
idle property idlecartdriveridle auto
idle property idlecartdriverexit auto
int property startinglocation = 1 auto
int property currentlocation = 1 auto
carriagesystemscript property dialoguecarriagesystem  auto  
topic property chattertopic  auto  
event oninit()
endevent
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
event oncombatstatechanged(actor aktarget, int aecombatstate)
endevent
event onanimationevent(objectreference aksource, string aseventname)
endevent
event ondeath(actor akkiller)
endevent
auto state normal
event oncellload()
endevent
event onunload()
endevent
endstate
state busy
event oncellload()
endevent
endstate
function attachtocart(bool bdoattach)
endfunction
function rideincart(int idestination = -1, bool payforride = false)
endfunction
function stopriding(bool bpause = true, bool bfasttravel = false)
endfunction
function resetlocation()
endfunction
event onupdate()
endevent
event onlocationchange(location akoldloc, location aknewloc)
endevent
globalvariable property testcarton  auto  
;This file was cleaned with PapyrusSourceHeadliner 1