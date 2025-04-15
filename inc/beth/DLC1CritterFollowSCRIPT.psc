scriptname dlc1critterfollowscript extends critter  
formlist property planttypes auto
float property ftimeatplantmin = 5.0 auto
float property ftimeatplantmax = 10.0 auto
float property factordetectiondistance = 300.0 auto
float property ftranslationspeedmean = 150.0 auto
float property ftranslationspeedvariance = 50.0 auto
float property ffleetranslationspeed = 300.0 auto
float property fbellshapepathheight = 150.0 auto
float property fflockplayerxydist = 100.0 auto
float property fflockplayerzdistmin = 50.0 auto
float property fflockplayerzdistmax = 200.0 auto
float property fflocktranslationspeed = 300.0 auto
float property fminscale = 0.5 auto
float property fmaxscale = 1.2 auto
float property fmintravel = 64.0 auto
float property fmaxtravel = 512.0 auto 
string property landingmarkerprefix = "landingsmall0" auto
float property fmaxrotationspeed = 90.0 auto
miscobject property bark auto
event onstart()
endevent
state atplant
event onupdate()
endevent
event oncrittergoalreached()
endevent
endstate
state followingplayer
event oncrittergoalreached()
endevent
endstate
state killforthenight
event oncrittergoalreached()
endevent
endstate
event onupdate()
endevent
bool function shouldflockaroundplayer()
endfunction
function flocktoplayer()
endfunction
objectreference function picknextplant()
endfunction
function gotonewplant(float afspeed)
endfunction
function warptonewplant()
endfunction
event oncelldetach()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1