scriptname wiremoveitem03bystanderscript extends referencealias  
event oncombatstatechanged(actor attacker, int aecombatstate)
endevent
event onenterbleedout()
endevent
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
event onunload()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1