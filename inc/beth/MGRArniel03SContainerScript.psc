scriptname mgrarniel03scontainerscript extends objectreference  conditional
referencealias property soulgemstage1  auto  
referencealias property soulgemstage2  auto  
quest property mgrarniel03  auto  
referencealias property soulgemstage3  auto  
referencealias property soulgemstage4  auto  
int property used auto conditional
event oninit()
endevent
event onitemadded(form baseitem, int itemcount, objectreference itemreference, objectreference sourcecontainer)
endevent
event onmagiceffectapply(objectreference caster, magiceffect effect)
endevent
event onitemremoved(form baseitem, int itemcount, objectreference itemreference, objectreference targetcontainer)
endevent
magiceffect property flameeffect  auto  
miscobject property soulgembase2 auto
miscobject property soulgembase3 auto
miscobject property soulgembase4 auto
formlist property mgrarniel03soulgemlist  auto  
;This file was cleaned with PapyrusSourceHeadliner 1