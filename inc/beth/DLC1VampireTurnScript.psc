scriptname dlc1vampireturnscript extends quest  
referencealias property newvampire1 auto
referencealias property newvampire2 auto
referencealias property newvampire3 auto
referencealias property newvampire4 auto
referencealias property newvampire5 auto
race property argonianrace auto
race property bretonrace auto
race property darkelfrace auto
race property elderrace auto
race property highelfrace auto
race property imperialrace auto
race property khajiitrace auto
race property nordrace auto
race property orcrace auto
race property redguardrace auto
race property woodelfrace auto
race property argonianracevampire auto
race property bretonracevampire auto
race property darkelfracevampire auto
race property elderracevampire auto
race property highelfracevampire auto
race property imperialracevampire auto
race property khajiitracevampire auto
race property nordracevampire auto
race property orcracevampire auto
race property redguardracevampire auto
race property woodelfracevampire auto
faction property dlc1playerturnedvampire auto 
faction property dlc1rv07thankfaction auto
quest property dlc1rv06 auto
quest property dlc1rv07 auto
referencealias property dlc1rv06spouse auto
referencealias property dlc1rv07candidate auto
faction property dlc1rv07coffinownerfaction auto
playervampirequestscript property playervampirequest auto
perk property dlc1vampireturnperk auto
spell property dlc1vampirecalm auto
keyword property vampire auto
spell property dlc1vampirechange auto
spell property dlc1vampirechangefx auto
idle property idlevampirestandingfeedfront_loose auto
idle property pa_vampirelordchangeplayer auto
quest property dlc1vq02 auto
race property dlc1vampirebeastrace auto
armor property dlc1clothesvampirelordroyalarmor auto
armor property dlc1vampirelordcape auto
actor property dlc1harknonactorref auto
objectreference property dlc1vq02playerwakeupmarker auto
objectreference property dlc1vq02harkonwakeupmarker auto
objectreference property dlc1vq02playerwakeupmarkerreject auto
imagespacemodifier property fadetoblackimod auto
imagespacemodifier property sleepytimefadein auto
faction property dlc1potentialvampirefaction auto
quest property dlc1vq03vampire auto
referencealias property dlc1vq03vampiredexion auto
companionshousekeepingscript property c00 auto
referencealias property disguisedvampirelordname auto
imagespacemodifier property dlc1harkonbitefadetoblackimod auto
outfit property dlc1harkonoutfit auto
outfit property dlc1harkondummyoutfit auto
textureset property eyesmalehumanvampire01 auto
globalvariable property dlc1vampirefeedstarttime auto
keyword property dlc1vampirefeedbystanderstart auto
idle property dlc1pairend auto
function playerbitesme(actor actortoturn)
endfunction
function startquestdlc1vampirefeedbystander(actor actortoturn)
endfunction
function turnmeintovampire(actor actortoturn)
endfunction
function completechange(referencealias aliastoturn)
endfunction
function playerchangedlocationcompletechange()
endfunction
referencealias function getnextalias()
endfunction
function makealiaseseyesred()
endfunction
function makemyeyesred(referencealias aliaswhoseactortogiveredeyes)
endfunction
race function getvampirerace(actor actortoturn)
endfunction
function harkonbitesplayer(bool isplayerrecieveingharkonsgift = true)
endfunction
function receiveharkonsgift(actor giftgiver, bool isseranagiving = false, bool playstandardbiteanim = true)
endfunction
function receiveseranasgift(actor giftgiver)
endfunction
function npctransformintovampirelord(actor actortoturn, bool royaloutfit = false, bool harkonforcegreet = false)
endfunction
function harkonchangedrace()
endfunction
function harkonchangebackfromvampirelord()
endfunction
function namevampirelord(actor actortorename)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1