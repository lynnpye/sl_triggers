scriptname ccbgssse001_setstageonitemadded extends referencealias  
quest property myquest auto
int property stagetoset auto
int property requiredstage auto
formlist property questitems auto
event oninit()
endevent
event onitemadded(form akbaseitem, int aiitemcount, objectreference akitemreference, objectreference aksourcecontainer)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1