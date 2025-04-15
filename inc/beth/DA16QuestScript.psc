scriptname da16questscript extends quest  conditional
int property pda16rude  auto  conditional
int property pda16firstscenebreak  auto  conditional
int property pda16verentoggle  auto  conditional
int property pda16thorektoggle  auto  conditional
int property pda16erandurtoggle  auto  conditional
int property pda16erandurgreet01done  auto  conditional
int property pda16erandurgreetfirstdone  auto  conditional
int property pda16erandurgreetfirstafterdone  auto  conditional
int property pda16erandurgreetpostritualdone  auto  conditional
int property pda16scenestarter auto conditional
int property pda16orderscounter auto conditional
int property pda16moved auto conditional
int property pdadial auto conditional
int property pdadial02 auto conditional
int property pda16ihavetorpor auto conditional
int property pda16ihavetome auto conditional
int property pda16librarydone auto conditional
int property pda16labdone auto conditional
scene property pda16initscene auto conditional
scene property pda16confrontscene auto conditional
referencealias property pda16verenalias  auto  conditional
referencealias property pda16thorekalias  auto  conditional
referencealias property pda16eranduralias  auto  conditional
quest property pda16quest  auto  conditional
objectreference property pda16dreamsetup  auto  conditional
objectreference property pda16playerstartdream auto conditional
objectreference property pda16playerenddream auto conditional
scene property pda16ritualscene  auto  conditional
actorbase property pda16erandur  auto  conditional
objectreference property pda16erandurmarker  auto  conditional
objectreference property da16dreamactorenablemarker  auto  
objectreference property da16presentactorenablemarker  auto  
objectreference property da16prequestactorenablemarker  auto  
objectreference property da16presentpostdreamactorenablemarker  auto  
imagespacemodifier property dreamismd  auto  
objectreference property da16dreamactorenablemarker02  auto
globalvariable property pda16libraryvar auto
globalvariable property pda16labvar auto
globalvariable property pda16bossvar auto
function librarytally()
endfunction
function labtally()
endfunction
function bosstally()
endfunction
event onupdate()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1