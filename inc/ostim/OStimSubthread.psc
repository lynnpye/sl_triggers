scriptname ostimsubthread extends referencealias
int property id auto
event oninit()
endevent
event onend(string eventname, string strargs, float endingthreadid, form sender)
endevent
event onorgasm(string eventname, string sceneid, float orgasmthreadid, form orgasmedactor)
endevent
function startai()
endfunction
bool function isinuse()
endfunction
int function getscenepassword()
endfunction
objectreference function getfurniture()
endfunction
bool function animationrunning()
endfunction
actor function getactor(int index)
endfunction
actor[] function getactors()
endfunction
float function gethighestexcitement()
endfunction
function adjustanimationspeed(float amount)
endfunction
function increaseanimationspeed()
endfunction
function decreaseanimationspeed()
endfunction
function setcurrentanimationspeed(int inspeed)
endfunction
bool function startscene(actor dom, actor sub = none, actor third = none, float time = 120.0, objectreference bed = none, bool isaggressive = false, actor aggressingactor = none, bool linktomain = false)
endfunction
float function getactorexcitement(actor act) ; at 100, actor orgasms
endfunction
function setactorexcitement(actor act, float value)
endfunction
function addactorexcitement(actor act, float value)
endfunction
bool function didanyactordie()
endfunction
bool function isanyactorincombat()
endfunction
function runosexcommand(string cmd)
endfunction
function autoincreasespeed()
endfunction
function orgasm(actor act)
endfunction
function endanimation()
endfunction
function warptoanimation(string animation) 
endfunction
bool function startsubthreadscene(actor dom, actor sub = none, actor zthirdactor = none, string startinganimation = "", objectreference furnitureobj = none, bool withai = true, bool isaggressive = false, actor aggressingactor = none)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1