scriptname duncgonhittriggerscript extends objectreference  
actor property mydragon auto
objectreference property myexplosionmarker auto
explosion property myexplosion auto
projectile property mydragonprojectile auto
auto state waiting
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1