scriptname critterfish extends critter
float property factordetectiondistance = 300.0 auto
float property ftranslationspeedmean = 40.0 auto
float property ftranslationspeedvariance = 20.0 auto
float property ffleetranslationspeed = 70.0 auto
float property fminscale = 0.1 auto
float property fmaxscale = 0.2 auto
float property fmindepth = 10.0 auto
float property fsplinecurvature = 200.0 auto
float property fmintimenotmoving = 1.0 auto
float property fmaxtimenotmoving = 5.0 auto
float property fschoolingdistancex = 25.0 auto
float property fschoolingdistancey = 35.0 auto
int property ipercentchanceschooling = 50 auto
int property ipercentchancestopschooling = 5 auto
float property fmaxrotationspeed = 360.0 auto
bool property bmoving = false auto hidden
event onstart()
endevent
state randomswimming
event onupdate()
endevent
event oncrittergoalalmostreached()
endevent
endstate
state schooling
event onupdate()
endevent
event oncrittergoalalmostreached()
endevent
endstate
function pickrandompoint()
endfunction
bool function picktargetfishforschooling()
endfunction
function pickrandompointbehindtargetfish()
endfunction
function warptorandompoint()
endfunction
function gotonewpoint(float afspeed)
endfunction
function schoolwithotherfish(float afspeed)
endfunction
event oncelldetach()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1