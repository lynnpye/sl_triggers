scriptname _dflowsleepquestscript extends quest
globalvariable property newproperty  auto ; garbage, left over from some aborted edit? not used anyway.
_dftools property tool auto
_dflowmcm property mcm auto
keyword property loctypeinn auto
qf__gift_09000d62 property q  auto  
_dfgoldconqscript property goldcon auto
globalvariable property _dflowenable auto
message property _dflowdebtcreditmsg auto
bool property erest auto
float property nd auto ; nd is basically the next time you can sleep and recover will; there's a cooldown so you can't chain-sleep your will back up.
float property nr auto ; start time
globalvariable property lives  auto
globalvariable property livesmax  auto
globalvariable property _dffollowerhasmaxlives auto
event onsleepstart(float starttime, float endtime)
endevent
event onsleepstop(bool abinterrupted)
endevent
function sleepstarthandler(float starttime, float endtime, bool ispaused)
endfunction
function sleepstophandler(bool abinterrupted, bool ispaused)
endfunction
bool function canrecover()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1