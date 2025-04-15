scriptname dlc1refaliasmovetriggerscript extends objectreference
referencealias property myrefalias auto
objectreference property mymarker auto
quest property myquest auto
int property mystage auto
objectreference property othertrigger01 auto
objectreference property othertrigger02 auto
objectreference property othertrigger03 auto
function movealias()
endfunction
auto state waiting
event ontriggerenter(objectreference akactionref)
endevent
endstate
state done
endstate
;This file was cleaned with PapyrusSourceHeadliner 1