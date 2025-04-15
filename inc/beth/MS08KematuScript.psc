scriptname ms08kematuscript extends referencealias  
quest property ms08  auto  
event ondeath(actor killer)
endevent
event onhit(objectreference actionref, form weapon, projectile actionproj, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
event onunload()
endevent
faction property kematufaction  auto  
faction property playerfaction  auto  
;This file was cleaned with PapyrusSourceHeadliner 1