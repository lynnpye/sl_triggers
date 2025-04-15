scriptname abforswornbriarheartscript extends activemagiceffect
ingredient property briarheart auto
armor property armorbriarheart auto
armor property armorbriarheartempty auto
actor property myself auto hidden
event oneffectstart(actor target, actor caster)
endevent
event onitemremoved(form objecttaken, int aiitemcount, objectreference reftaken, objectreference akdestcontainer)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1