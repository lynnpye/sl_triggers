scriptname ccbgssse025_bosshitscript extends referencealias  
quest property bossquest auto
ccbgssse025_bosscontrollerscript property bossscript auto
event oncombatstatechanged(actor aktarget, int aecombatstate)
endevent
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
state done
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1