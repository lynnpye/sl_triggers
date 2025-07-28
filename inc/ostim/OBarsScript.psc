scriptname obarsscript extends quest
osexintegrationmain property ostim auto
osexbar property dombar auto
osexbar property subbar auto
osexbar property thirdbar auto
event oninit()
endevent
function inititializeallbars()
endfunction
function initbar(osexbar bar, int id)
endfunction
function setbarvisible(osexbar bar, bool visible)
endfunction
function colorbar(osexbar bar, bool female = true, int colorz = -1)
endfunction
bool function isbarvisible(osexbar bar)
endfunction
function setbarpercent(osexbar bar, float percent)
endfunction
function forcebarpercent(osexbar bar, float percent)
endfunction
float function getbarpercent(osexbar bar)
endfunction
function flashbar(osexbar bar)
endfunction
event ostimstart(string eventname, string strarg, float numarg, form sender)
endevent
event ostimorgasm(string eventname, string strarg, float numarg, form sender)
endevent
event ostimthirdjoin(string eventname, string strarg, float numarg, form sender)
endevent
event ostimthirdleave(string eventname, string strarg, float numarg, form sender)
endevent
bool function isbarenabled(actor act)
endfunction
function setbarfullnessproper()
endfunction
function addbarfullness(int bar, float amount)
endfunction
float function getbarcorrectnessdifference(int barid)
endfunction
function ongameload()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1