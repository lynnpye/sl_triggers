scriptname weprisoneraliasscript extends referencealias  
topic property weshareddialogueprisonersetfree auto
idle property offsetboundstandingstart auto
idle property offsetstop  auto
message property weprisonermessagebox auto
faction property weprisonerfreedfaction auto
faction property weprisonerfreedcombatcaptorfaction auto
faction property weprisonerfreedcombatprisonerfaction auto
referencealias property captor1 auto
referencealias property captor2 auto
referencealias property captor3 auto
referencealias property captor4 auto
referencealias property captor5 auto
event onload()
endevent
event onactivate(objectreference akactionref)
endevent
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
function freeprisoner(actor actorref, bool playerisliberator= true, bool openinventory = false)
endfunction
function clearfactions()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1