scriptname commentaryobjectscript extends objectreference
string property dispmsg auto     ; store the editor-set string to display when this object is activated
quest property commentaryquest auto  ; this will always be the commentary quest, set up 
event onload()
endevent
event onunload()
endevent
state polling
event onupdate()  
endevent
endstate
state active
event onactivate(objectreference actronaut)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1