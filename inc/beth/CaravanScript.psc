scriptname caravanscript extends quest  conditional
globalvariable property caravaniscampeda auto
globalvariable property caravanlocationa auto
referencealias property leadera auto
globalvariable property caravaniscampedb auto
globalvariable property caravanlocationb auto
referencealias property leaderb auto
globalvariable property caravaniscampedc auto
globalvariable property caravanlocationc auto
referencealias property leaderc auto
objectreference property campenablemarkera1 auto
objectreference property campenablemarkera2 auto
objectreference property campenablemarkerb1 auto
objectreference property campenablemarkerb2 auto
objectreference property campenablemarkerc1 auto
objectreference property campenablemarkerc2 auto
function updatecaravan(int whichcaravan, form callingform, actor leaderref, bool weareenablingcamp = false, bool wearedisablingcamp = false)
endfunction
function setglobals(globalvariable campedglobal, globalvariable locationglobal)
endfunction
function setnewlocationglobal(globalvariable locationglobal)
endfunction
function togglecamp(int whichcaravan, bool weareenablingcamp)
endfunction
objectreference function getcampenablemarker(int whichcaravan)
endfunction
globalvariable function getlocationglobal(int whichcaravan)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1