scriptname dunmarkarthwizardreinforcemanager extends objectreference
quest property markarthwizardsquest auto
referencealias property callerforhelp auto
referencealias property reinforcementslot1 auto
referencealias property reinforcementslot2 auto
faction property secureareafaction auto
objectreference property reinforcementsenabledmarker auto
actorbase property reinforcementtype1 auto
actorbase property reinforcementtype2 auto
int property reinforcementlevelmod auto
encounterzone property reinforcementenczone auto
objectreference property callerforhelpmarker auto
objectreference property spawnpoint1 auto
objectreference property spawnpoint2 auto
objectreference property doorforkey auto
auto state initial
event onactivate(objectreference akactivator)
endevent
endstate
state alldone
event onactivate(objectreference obj)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1