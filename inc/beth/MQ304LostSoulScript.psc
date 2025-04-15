scriptname mq304lostsoulscript extends objectreference  
faction property alduinfaction  auto  
quest property mq304 auto
int property stagetoset  auto  
event onload()
endevent
event onhit(objectreference akaggressor, form akweapon, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
event ondeath(actor akkiller)
endevent
function testforalduinhit(objectreference akaggressor)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1