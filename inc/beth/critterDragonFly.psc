scriptname critterdragonfly extends critter
float property factordetectiondistance = 300.0 auto
float property ftranslationspeedmean = 175.0 auto
float property ftranslationspeedvariance = 75.0 auto
float property ffleetranslationspeed = 500.0 auto
float property fminscale = 0.5 auto
float property fmaxscale = 0.8 auto
float property fsplinecurvature = 200.0 auto
float property fmintimenotmoving = 1.0 auto
float property fmaxtimenotmoving = 5.0 auto
float property fminfleeheight = 2000.0 auto
float property fmaxfleeheight = 3000.0 auto
float property fmaxrotationspeed = 540.0 auto
event onstart()
endevent
event onupdate()
endevent
event oncrittergoalreached()
endevent
function pickrandompoint()
endfunction
function warptorandompoint()
endfunction
function gotonewpoint(float afspeed)
endfunction
function pickrandompointoutsideleash()
endfunction
function flyaway(float afspeed)
endfunction
event oncelldetach()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1