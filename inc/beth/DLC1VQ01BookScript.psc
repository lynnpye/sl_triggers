scriptname dlc1vq01bookscript extends referencealias  
int property mystage  auto  
quest property myquest  auto  
quest property myqst auto
int property prereqstage = -1 auto
int property stagetoset auto
event onread()
endevent
auto state waiting 
event oncontainerchanged(objectreference aknewcontainer, objectreference akoldcontainer)
endevent
endstate
state inactive
endstate 
;This file was cleaned with PapyrusSourceHeadliner 1