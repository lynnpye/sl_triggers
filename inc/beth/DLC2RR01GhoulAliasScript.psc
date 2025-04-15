scriptname dlc2rr01ghoulaliasscript extends referencealias  conditional
dlc2rr01questscript property pdlc2rr01qs auto
globalvariable property pdlc2rr01invtoggled auto conditional
event ondying(actor akkiller)
endevent
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1