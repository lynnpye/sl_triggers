scriptname ccbgssse025_harvestableactivator extends objectreference
ingredient property itemtoharvest auto
leveleditem property leveledrarecuriositem auto
globalvariable property israrecuriosloaded auto
bool property userarecuriositem = false auto
actor property playerref auto
sound property harvestsound auto
message property harvestfailedmsg auto
perk property greenthumb auto
auto state ready
event onactivate(objectreference akactivator)
endevent
endstate
state harvested
event onactivate(objectreference akactivator)
endevent
endstate
event onreset()
endevent
event onupdate()
endevent
event onload()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1