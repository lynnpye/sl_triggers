scriptname critterbird extends critter
formlist property perchtypelist auto
float property fminscale = 0.5 auto
float property fmaxscale = 1.5 auto
float property fminhop = 8.0 auto
float property fmaxhop = 32.0 auto
float property leashlength = 256.0 auto
float property fspeed = 150.0 auto
string property sstate auto hidden
int property ienergy = 50 auto hidden
objectreference property goalperch auto hidden
event onstart()   ; critter event called when spawned
endevent
state idling
event onupdate()  
endevent
endstate
state flying
event ontranslationcomplete()
endevent
endstate
function groundhop() 
endfunction
function takeflight()
endfunction
function flyto(objectreference goal)
endfunction
function playidle()
endfunction
bool function landatperch(objectreference goal)
endfunction
objectreference function findperch()
endfunction
bool function flytoperch(objectreference goal)
endfunction
function flyawayhome()
endfunction
event oncelldetach()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1