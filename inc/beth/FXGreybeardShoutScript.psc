scriptname fxgreybeardshoutscript extends objectreference  
auto state waiting
event onload()
endevent
endstate
state playing
event onanimationevent(objectreference aksource, string aseventname)
endevent
event oncelldetach()
endevent
endstate
function goaway()
endfunction
state goingaway
event onanimationevent(objectreference aksource, string aseventname)
endevent
endstate
state done
event onunload()
endevent
endstate
objectreference property wordtrigger  auto  
objectreference property soundenablemarker  auto  
imagespacemodifier property learnwordfadeloop02  auto  
;This file was cleaned with PapyrusSourceHeadliner 1