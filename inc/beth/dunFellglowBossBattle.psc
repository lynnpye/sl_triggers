scriptname dunfellglowbossbattle extends actor
quest property mg03 auto
objectreference property atronach1 auto
objectreference property atronach2 auto
referencealias property orthornref auto
formlist property atronachlist auto
activator property summonfx auto
objectreference property summonpad1 auto ;left rear
objectreference property summonpad2 auto ;right rear
objectreference property summonpad3 auto ;center
key property callerskey auto
objectreference property frontdoor auto
objectreference property bar auto
objectreference property entrydoor auto
objectreference property banishactivator auto
event oncombatstatechanged(actor aktarget, int aecombatstate)
endevent
event onhit(objectreference aggressor, form weap, projectile proj, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
event teleport()
endevent
event ondeath(actor akkiller)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1