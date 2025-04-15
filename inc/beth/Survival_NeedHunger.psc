scriptname survival_needhunger extends survival_needbase
message property survival_helphungerhigh auto
globalvariable property survival_helpshown_hunger auto
referencealias property playeralias auto
formlist property survival_hungerresistracesminor auto
globalvariable property survival_racialbonusminor auto
globalvariable property survival_afflictionhungerchance auto
spell property survival_afflictionweakened auto
spell property survival_diseasegutworm auto
spell property survival_diseasegutworm2 auto
spell property survival_diseasegutworm3 auto
message property survival_afflictionweakenedmsg auto
globalvariable property survival_hungerrestoreverysmallamount auto
globalvariable property survival_hungerrestoresmallamount auto
globalvariable property survival_hungerrestoremediumamount auto
globalvariable property survival_hungerrestorelargeamount auto
spell property survival_diseasefoodpoisoning auto
float[] property eatingqueue auto
bool property eating = false auto hidden
function startneed()
endfunction
function setneedstagevalues()
endfunction
function stopneed()
endfunction
function needupdategametime()
endfunction
function increasehunger(float amount)
endfunction
function decreasehungerbuffered(float amount)
endfunction
function addtoeatingbuffer(float amount)
endfunction
function processeatingbuffer()
endfunction
function decreasehungerimpl(float amount)
endfunction
int function getnextindex(int idx, float[] array)
endfunction
function decreasehungerverysmall()
endfunction
function decreasehungersmall()
endfunction
function decreasehungermedium()
endfunction
function decreasehungerlarge()
endfunction
function applyhungerstage(float newhungervalue, float oldhungervalue)
endfunction
float function incrementneedbytick(float ratereductionmultiplier = 0.0)
endfunction
float function getgutwormeffectmult()
endfunction
function removeallneedspells()
endfunction
function updateattributepenalty(float afneedvalue, string asattributeav = "", string aspenaltyav = "")
endfunction
function clearattributepenalty(string aspenaltyav = "")
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1