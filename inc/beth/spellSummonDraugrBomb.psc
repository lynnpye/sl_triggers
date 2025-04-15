scriptname spellsummondraugrbomb extends actor  
explosion property fireballexplosion auto
effectshader property atronachunsummondeathfxs auto
event onload()
endevent
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
event ondying(actor mykiller)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1