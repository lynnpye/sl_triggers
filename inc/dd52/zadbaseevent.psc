scriptname zadbaseevent extends referencealias
int property defaultprobability auto
string property help = "" auto
string property name auto
int property probability = -1 auto hidden
bool property process = false auto hidden
zadlibs property libs auto
bool function filter(actor akactor, int chancemod)
endfunction
bool function haskeywords(actor akactor)
endfunction
function execute(actor akactor)
endfunction
function eval(actor akactor)
endfunction
event onplayerloadgame()
endevent
function onregisterevents(string eventname, string strarg, float numarg, form sender)
endfunction
function registerdeviceeffect()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1