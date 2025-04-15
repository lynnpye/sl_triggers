scriptname dunpoiwarlockcaptivescript extends objectreference  
int property mystage  auto  
int property mystagereleased auto
int property mystageattacked auto
quest property myquest  auto  
event onload()                       
endevent
event onunload()
endevent
function updateloop()
endfunction
event onactivate(objectreference akactionref)
endevent
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1