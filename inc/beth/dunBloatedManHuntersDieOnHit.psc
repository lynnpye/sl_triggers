scriptname dunbloatedmanhuntersdieonhit extends referencealias
referencealias property sinding auto
faction property da05huntersofhircinefaction auto
faction property playerfaction auto
event oncombatstatechanged(actor target, int combatstate)
endevent
event onhit(objectreference aggressor, form weap, projectile proj, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1