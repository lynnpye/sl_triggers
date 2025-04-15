scriptname dlc1activatelinksonhitorcombat extends objectreference  
keyword property linkcustom01 auto
bool property doonce = true auto
event onhit(objectreference akaggressor, form akweapon, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
event oncombatstatechanged(actor aktarget, int aecombatstate)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1