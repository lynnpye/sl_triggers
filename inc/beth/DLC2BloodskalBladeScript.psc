scriptname dlc2bloodskalbladescript extends referencealias
actor property selfref auto hidden
spell property dlc2bloodskalbladespellhoriz auto
spell property dlc2bloodskalbladespellvert auto
weapon property selfweapon auto hidden hidden
ammo property dlc2bloodskalammo auto
referencealias property bloodskalblade auto
objectreference property objself auto hidden
event onequipped(actor akactor)
endevent
event oncontainerchanged(objectreference aknewcontainer, objectreference akoldcontainer)
endevent
event onunequipped(actor akactor)
endevent
event onanimationevent(objectreference aksource, string eventname)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1