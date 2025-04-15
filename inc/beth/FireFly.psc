scriptname firefly extends critter
formlist property planttypes auto
float property ftimeatplantmin = 5.0 auto
float property ftimeatplantmax = 10.0 auto
float property factordetectiondistance = 300.0 auto
float property ftranslationspeedmean = 50.0 auto
float property ftranslationspeedvariance = 25.0 auto
float property ffleetranslationspeed = 100.0 auto
float property fflockplayerxydist = 100.0 auto
float property fflockplayerzdistmin = 50.0 auto
float property fflockplayerzdistmax = 200.0 auto
float property fflocktranslationspeed = 300.0 auto
float property fminscale = 0.3 auto
float property fmaxscale = 0.4 auto
float property fmintravel = 64.0 auto
float property fmaxtravel = 512.0 auto 
float property fmaxrotationspeed = 90.0 auto
event onstart()
endevent
state atplant
event onupdate()
endevent
event oncrittergoalreached()
endevent
endstate
state hovering
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
function hovercloseby()
endfunction
objectreference function picknextplant()
endfunction
function gotonewplant(float afspeed)
endfunction
function warptonewplant()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1