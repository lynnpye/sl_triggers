scriptname db05moverefonlostlos extends objectreference  
referencealias property myrefalias auto
objectreference property mylooktarget auto
objectreference property mymovetotarget auto
quest property myquest auto
event onlostlos(actor akviewer, objectreference aktarget)
endevent
auto state donothing
endstate
state waiting
event onbeginstate()
endevent
endstate
quest property pdb05  auto  
;This file was cleaned with PapyrusSourceHeadliner 1