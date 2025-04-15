scriptname dlc1gargoylebossscript extends actor  
effectshader property dlc1gargoylestonechipsfxs auto
auto state waiting
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
endstate
state getstoned
event onbeginstate()
endevent 
endstate
state stoned
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
endstate
state getcracked
event onbeginstate()
endevent 
endstate
state damageable
event onbeginstate()
endevent
endstate
state readytogetstoned
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1