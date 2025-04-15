scriptname byohbuildingobjectscript extends form  
event oncontainerchanged(objectreference aknewcontainer, objectreference akoldcontainer)
endevent
byohhousebuildingscript property byohhousebuilding  auto  
int property id  auto  
miscobject property myself auto
int property finishroomid = 0 auto
int property startroomid = 0 auto
miscobject property removeitem auto
miscobject property removeitem2 auto
formlist property removeitemlist auto
bool property bdisableadditionlayouts auto
;This file was cleaned with PapyrusSourceHeadliner 1