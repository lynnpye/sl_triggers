scriptname dlc2rieklingambushfx extends actor
effectshader property rieklingambushfxs auto
effectshader property rieklingambushfxs1 auto
effectshader property rieklingambushfxs2 auto
effectshader property rieklingambushfxs3 auto
sound property attacksound auto
string property sactorvariable = "variable01"  auto hidden
float property factorvariable = 1.0 auto hidden
float property factorvariableonreset = 0.0 auto hidden
float property faggression = 2.0 auto hidden
float property faggressiononreset = 0.0 auto hidden
keyword property linkkeyword auto
bool property ambushontrigger = true auto
event onreset()
endevent
auto state waiting
event onactivate(objectreference triggerref)
endevent
endstate
state alldone
event onbeginstate()
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1