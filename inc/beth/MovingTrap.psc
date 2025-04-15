scriptname movingtrap extends trapbase
bool property isloaded = true auto hidden
bool property isfiring = false auto hidden
int property lvlthreshold1 auto
int property lvldamage1 auto
int property lvlthreshold2 auto
int property lvldamage2 auto
int property lvlthreshold3 auto
int property lvldamage3 auto
int property lvlthreshold4 auto
int property lvldamage4 auto
int property lvlthreshold5 auto
int property lvldamage5 auto
int property lvldamage6 auto
function resolveleveleddamage()
endfunction
event oncellattach()
endevent
event oncelldetach()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1