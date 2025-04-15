scriptname mq101playerscript extends referencealias
key property mq101keepdoorkey auto
imagespacemodifier property playeralduinimod auto
event oninit()
endevent
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
event onitemadded(form akbaseitem, int aiitemcount, objectreference akitemreference, objectreference aksourcecontainer)
endevent 
event onobjectequipped(form akbaseobject, objectreference akreference)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1