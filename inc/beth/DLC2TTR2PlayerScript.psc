scriptname dlc2ttr2playerscript extends referencealias  
quest property dlc2ttr2  auto  
globalvariable property heartstoneacquired  auto  
miscobject property dlc2heartstone  auto  
event oninit()
endevent
event onitemadded(form akbaseitem, int aiitemcount, objectreference akitemreference, objectreference aksourcecontainer)
endevent
event onitemremoved(form akbaseitem, int aiitemcount, objectreference akitemreference, objectreference aksourcecontainer)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1