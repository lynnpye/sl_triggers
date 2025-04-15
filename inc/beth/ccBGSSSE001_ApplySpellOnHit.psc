scriptname ccbgssse001_applyspellonhit extends referencealias  
actor property uniqueactor auto
actor property playerref auto
spell property spelltocast auto
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, \
bool abbashattack, bool abhitblocked)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1