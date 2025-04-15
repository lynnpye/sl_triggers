scriptname critterspawn extends objectreference
formlist property crittertypes auto
float property fleashlength = 500.0 auto
float property fleashheight = 50.0 auto
float property fleashdepth = 50.0 auto
float property fmaxplayerdistance = 2000.0 auto
int property imaxcrittercount = 10 auto
float property ffastspawninterval = 0.1 auto
float property fslowspawninterval = 5.0 auto
globalvariable property gamehour auto
float property fstartspawntime = 6.0 auto
float property fendspawntime = 11.0 auto
float property fleashoverride auto
bool property bspawninprecipitation auto
int property icurrentcrittercount = 0 auto hidden
event onload()
endevent
event onunload()
endevent
event oncelldetach()
endevent
function spawninitialcritterbatch()
endfunction
event oncritterdied()
endevent
bool function spawncritter()
endfunction
function spawncritteratref(objectreference arspawnref)
endfunction
float function getplayerdistance()
endfunction
bool function shouldspawn()
endfunction
bool function isactivetime()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1