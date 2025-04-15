scriptname cwmission04script extends cwmissionscript  conditional
faction  property cwmission04prisonerfreedfaction auto
outfit property cwmission04outfitimperial auto
outfit property cwmission04outfitsons auto
referencealias property friend auto
referencealias property friendly1 auto
referencealias property friendly2 auto
referencealias property friendly3 auto
referencealias property prisoner1 auto
referencealias property prisoner2 auto
referencealias property prisoner3 auto
referencealias property prisoner4 auto
faction property cwjobfortjailorfaction auto
referencealias property prisonerdoor1 auto
referencealias property attackmarker auto
locationalias property attackpoint auto
int property followstate auto hidden conditional
topic property cwmission04prisonerthankstopic auto
function addprisonkey(actor actortoaddkeyto)
endfunction
function forcealiasintofortjobalias(referencealias aliastocheck, referencealias gatekeeperalias, referencealias jailoralias, referencealias exteriorpatrolleralias)
endfunction
function checkallprisonerskill()
endfunction
function checkallprisonersfreed()
endfunction
function movefriendliestoattackmarker()
endfunction
function checkforvictory()
endfunction
function prisonergearup(actor prisoner)
endfunction
function combatstarted(actor soldier, actor aktarget, int aecombatstate)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1