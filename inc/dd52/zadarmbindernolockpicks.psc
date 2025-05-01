scriptname zadarmbindernolockpicks extends activemagiceffect
zadlibs property libs auto
miscobject property lockpick auto
actor property target auto
objectreference property thesafe auto
event oneffectstart(actor aktarget, actor akcaster)
endevent
event oneffectfinish(actor aktarget, actor akcaster)
endevent
state normalmode
event onitemadded(form akbaseitem, int aiitemcount, objectreference akitemreference, objectreference aksourcecontainer)
endevent
event onbeginstate()
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1