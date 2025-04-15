scriptname dunhaltedstreamcampghostdebris extends referencealias conditional
effectshader property ghostshader auto
sound property windupsound auto ;played when winding up or releasing trap
int property traplevel = 2 auto
int property damage auto hidden
auto state idle
event onactivate(objectreference akactivator)
endevent
endstate
function firetrap()
endfunction
state hover
event onbeginstate()
endevent
endstate
state attack
event onbeginstate()
endevent
endstate
int property testlvlencvalue auto
int property lvlthreshold1 = 3 auto
int property lvldamage1  = 30 auto
int property lvlthreshold2 = 6 auto
int property lvldamage2 = 40 auto
int property lvlthreshold3 = 9 auto
int property lvldamage3 = 50 auto
int property lvlthreshold4 = 12 auto
int property lvldamage4 = 60 auto
int property lvlthreshold5 = 16 auto
int property lvldamage5 = 70 auto
int property lvldamage6 = 80 auto
function resolveleveleddamage ()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1