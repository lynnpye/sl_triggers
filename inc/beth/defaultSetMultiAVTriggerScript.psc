scriptname defaultsetmultiavtriggerscript extends objectreference
objectreference property actor1 auto
objectreference property actor2 auto
objectreference property actor3 auto
objectreference property actor4 auto
objectreference property actor5 auto
string property actorvaluename auto
int property actorvaluevalue auto
bool property onlyonce = true auto
bool property evalpackageafterwards = true auto
bool property onlyplayer = true auto
auto state waiting
event ontriggerenter(objectreference obj)
endevent
endstate
state alldone
event ontriggerenter(objectreference obj)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1