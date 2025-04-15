scriptname cwfinalescript extends quest conditional
cwscript property cws  auto  
cwfortsiegescript property cwfortsieges auto
referencealias property leader auto
referencealias property second auto
referencealias property enemyleader auto
referencealias property enemysecond auto
referencealias property door1 auto
referencealias property door2 auto
referencealias property door3 auto
referencealias property door4 auto
referencealias property door5 auto
referencealias property crowdmarker1 auto
referencealias property crowdmarker2 auto
referencealias property crowdmarker3 auto
referencealias property crowdmarker4 auto
referencealias property crowdmarker5 auto
referencealias property crowdmarker6 auto
referencealias property crowdmarker7 auto
referencealias property crowdmarker8 auto
referencealias property crowdmarker9 auto
referencealias property crowdmarker10 auto
referencealias property crowdmarker11 auto
referencealias property crowdmarker12 auto
referencealias property crowdmarker13 auto
referencealias property crowdmarker14 auto
referencealias property crowdmarker15 auto
referencealias property crowdmember1 auto
referencealias property crowdmember2 auto
referencealias property crowdmember3 auto
referencealias property crowdmember4 auto
referencealias property crowdmember5 auto
referencealias property crowdmember6 auto
referencealias property crowdmember7 auto
referencealias property crowdmember8 auto
referencealias property crowdmember9 auto
referencealias property crowdmember10 auto
referencealias property crowdmember11 auto
referencealias property crowdmember12 auto
referencealias property crowdmember13 auto
referencealias property crowdmember14 auto
referencealias property crowdmember15 auto
locationalias property aliaslocation auto
location property solitudelocation auto
location property windhelmlocation auto
scene property cwfinalesolitudescenea auto
scene property cwfinalesolitudesceneb auto
scene property cwfinalesolitudescenec auto
scene property cwfinalesolitudescened auto
scene property cwfinalewindhelmscenea auto
scene property cwfinalewindhelmsceneb auto
scene property cwfinalewindhelmscenec auto
scene property cwfinalewindhelmscened auto
actorbase property cwfinalesoldierimperial auto
actorbase property cwfinalesoldiersons auto
faction property cwimperialfactionnpc auto
faction property cwsonsfactionnpc auto
faction property crimefactionhaafingar auto
faction property crimefactioneastmarch auto
float property pausebeforescene = 0.1 auto
int property executeprompt auto conditional hidden ;set stage 210, set in scene phase result script, used to conditionalize dialogue on leader asking player to slay enemyleader
leveleditem property cwfinalefactionleaderswordlist auto
faction property cwfinaletemporaryallies  auto  
function playerenteredcastle()
endfunction
function enemyseconddied()
endfunction
function unlockdoors()
endfunction
function lockme(referencealias doortolock, int locklevel = 255)
endfunction
function unlockme(referencealias doortounlock, int unlocklevel = 255)
endfunction
function makemestopcombat(referencealias actoraliastochillout)
endfunction
function startscenea()
endfunction
function startsceneb()
endfunction
function makecrowd()
endfunction
function removecrowd()
endfunction
function makecrowdmember(referencealias markeralias, referencealias memberalias)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1