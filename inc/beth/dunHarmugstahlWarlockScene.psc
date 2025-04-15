scriptname dunharmugstahlwarlockscene extends actor
quest property myquest auto
objectreference property player auto
key property harmkey auto
event onload()
endevent
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
event ondeath(actor akkiller)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1