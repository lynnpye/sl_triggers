scriptname dunbloodletscenescript extends actor 
quest property dunbloodletqst auto
objectreference property wolflever auto
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
event oncombatstatechanged(actor aktarget, int aecombatstate)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1