scriptname c00vilkasscript extends referencealias  
objectreference property trainingmarker auto
quest property trainingquest auto
referencealias property trainer auto ; on training quest
faction property trainingfaction auto
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
event onenterbleedout()
endevent
event onmagiceffectapply(objectreference akcaster, magiceffect akeffect)
endevent
function checkfortrainingstart()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1