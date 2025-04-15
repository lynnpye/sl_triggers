scriptname dlc1nvampirecorruptedshadescript extends actor
float property fdelay = 0.75 auto
float property fdelayend = 1.65 auto
float property shaderduration = 0.00 auto
activator property pdefaultashpileghost auto
bool property bsetalphazero = true auto
formlist property pdisintegrationmainimmunitylist auto
effectshader property pghostdeathfxshader auto
event onload()
endevent
event ondying(actor akkiller)
endevent
function createashpile()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1