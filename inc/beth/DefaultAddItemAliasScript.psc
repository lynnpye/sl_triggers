scriptname defaultadditemaliasscript extends referencealias  
int property stagetoset auto
int property minstagetocheck = 0 auto
int property maxstagetocheck = 0 auto
bool property checkplayerinventory = true auto
objectreference property checkthisinventory auto
referencealias property checkthisaliasinventory auto
bool property traceevent = false auto
event oninit()
endevent
event oncontainerchanged(objectreference aknewcontainer, objectreference akoldcontainer)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1