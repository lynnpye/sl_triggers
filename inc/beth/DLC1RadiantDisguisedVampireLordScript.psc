scriptname dlc1radiantdisguisedvampirelordscript extends actor  
dlc1vampireturnscript property dlc1vampireturn  auto  
topic property dlc1radiantdisguisedvampirelordspawnertaunttopic auto
event onupdate()
endevent
event onload()
endevent
event oncellload()
endevent
event oncellattach()
endevent
event onattachedtocell()
endevent
event onunload()
endevent
event oncelldetach()
endevent
event ondetachedfromcell()
endevent
event ondeath(actor akkiller)
endevent
event oncombatstatechanged(actor aktarget, int aecombatstate)
endevent
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
function register(bool doregister = true)
endfunction
function change()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1