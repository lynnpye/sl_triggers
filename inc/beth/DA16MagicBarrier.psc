scriptname da16magicbarrier extends objectreference
string property sactorvariable = "variable01"  auto hidden
float property factorvariable = 1.0 auto hidden
float property faggression = 2.0 auto hidden
keyword property linkkeyword auto
keyword property linkcustom02 auto
keyword property linkcustom03 auto
bool property ambushontrigger = false auto
visualeffect property trailfx auto
visualeffect property trailfx02 auto
objectreference property objself auto hidden
scene property myscene auto
miscobject property soulgemcommonfilled auto
quest property da16 auto
int property stage = 160 auto
objectreference property mysoundobject auto
objectreference property da16barriercollisionmovetomarker auto
bool property isloaded auto hidden
auto state waiting
event oncellattach()
endevent
event onactivate(objectreference akactivator)
endevent
endstate
state active
event onbeginstate()
endevent
event onactivate(objectreference triggerref)
endevent
event oncelldetach()
endevent
endstate
state done
endstate
event oncellattach()
endevent
event oncelldetach()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1