scriptname dlc2fishmanscript extends actor  
explosion property dlc2lurkerstompartexplosion auto
visualeffect property dlc2benthiclurkertenticlemouthe auto
visualeffect property dlc2benthictenticlehandlefte auto
visualeffect property dlc2benthictenticlehandrighte auto
visualeffect property dlc2benthiclurkerwhipduste auto
visualeffect property dlc2benthiclurkerwhipdustsnowe auto
visualeffect property dlc2benthictenticlestompe auto
bool property isinsnow = false auto
effectshader property dlc2lurkeremerge auto
event onload()
endevent
event onanimationevent(objectreference aksource, string aseventname)
endevent
event ongetup(objectreference akfurniture)
endevent
event ondying(actor mykiller)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1