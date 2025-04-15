scriptname dlc1radiantscript extends quest conditional
referencealias property currentquestgiver auto
faction property dlc1radiantvampirebanditnecroallys auto
faction property banditfaction auto
faction property necromancerfaction auto
keyword property dlc1radianthunterstart auto
keyword property dlc1radiantvampirestart auto
keyword property dlc1radianthuntertechstart auto
globalvariable property dlc1introcompletedhunter auto
globalvariable property dlc1introcompletedvampire auto
location property dlc1hunterhqlocation auto
location property dlc1vampirecastlelocation auto
perk property dlc1vampireturnperk auto
int property queststate auto hidden ;0 = unset, 1 = quest is starting, 2 = quest is running
formlist property dlc1radianthighprofilefactions auto
dlc1vampireturnscript property dlc1vampireturn auto
objectreference property dlc1vendorchestsorinejurardref auto
objectreference property dlc1dawnguardarmoredtrollspawnmarker auto
actorbase property dlc1lvltrollarmoredplayerfollower auto
referencealias property trollfollower auto 
bool property playerhastroll auto conditional hidden
dialoguefollowerscript property dialoguefollower auto
message property dlc1trollfollowerdismissedmsg auto
globalvariable property dlc1trollcost auto
miscobject property gold001 auto
objectreference property dlc1bloodchaliceactivatoremptyref auto
objectreference property dlc1bloodchaliceactivatorfullref auto
globalvariable property gamedayspassed auto
globalvariable property dlc1vampirechalicelevel auto
globalvariable property dlc1vampirechalicestopday auto ;when does the player's extra power stop, expressed in terms of gamedayspassed
spell property dlc1vampirechalicepower auto
spell property dlc1dunredwaterdenpower auto
spell property dlc1dunredwaterdenwithdrawl auto
globalvariable property dlc1dunredwaterdenpowerstopday auto
globalvariable property dlc1dunredwaterdenwithdrawalstopday auto
faction property crimefactioneastmarch auto
faction property crimefactionfalkreath auto
faction property crimefactionhaafingar auto
faction property crimefactionhjaalmarch auto
faction property crimefactionpale auto
faction property crimefactionreach auto
faction property crimefactionrift auto
faction property crimefactionwhiterun auto
faction property crimefactionwinterhold auto
location property eastmarchholdlocation auto
location property falkreathholdlocation auto
location property haafingarholdlocation auto
location property hjaalmarchholdlocation auto
location property paleholdlocation auto
location property reachholdlocation auto
location property riftholdlocation auto
location property whiterunholdlocation auto
location property winterholdholdlocation auto
keyword property loctypehold auto
actorbase property lvlvampire auto
potion property dlc1bloodpotion auto
leveleditem property dlc1radiantreward auto
faction property dlc1hunterfaction auto
faction property dlc1vampirefaction auto
globalvariable property dlc1wenextspecialattackday auto
quest property dlc1vq01 auto
quest property dlc1vq02 auto
quest property dlc1vq03hunter auto
quest property dlc1vq03vampire auto
quest property dlc1vq04 auto
quest property dlc1vq05 auto
quest property dlc1vq06 auto
quest property dlc1vq07 auto
quest property dlc1vq08 auto
actorbase[] property disguisedhunteractorbases auto
actorbase[] property disguisedvampireactorbases auto
keyword property vampire auto
event onupdategametime()
endevent
function introquestcompleted(bool ishunterquest = false, bool isvampirequest = false)
endfunction
function createquesthunter()
endfunction
function createquestvampire()
endfunction
function createquesthuntertech()
endfunction
function createquestbasedonlocation(location loc)
endfunction
function createquest(int questtype)
endfunction
function stopquestandstartnewone(quest callingquest, int questtype)
endfunction
function stopquestandstartnewonehunter(quest callingquest)
endfunction
function stopquestandstartnewonevampire(quest callingquest)
endfunction
function stopquestandstartnewonehuntertech(quest callingquest)
endfunction
bool function isactorinfactioninformlist(actor actortocheck, formlist formlisttocheck)
endfunction
bool function ishighprofiletarget(objectreference akvictim)
endfunction
function questgiverobjective(objectreference referencetomakequestgiver)
endfunction
function questaccepted(quest questthatstarted) ;called by dlc1rxxx quests
endfunction
function turnoffquestgiverobjective() 
endfunction
function givequestreward(int chanceforbloodpotion = 0)
endfunction
function enabledwarventech(dlc1rh05dwarventechscript dwarventechitem)
endfunction
function maketrollfollower(objectreference trolltomakefollower = none, bool chargeplayer = true)
endfunction
function trolldies();called by dlc1radianttrollfollowerscript on trollfollower alias
endfunction
function trollabandoned(actor troll)
endfunction
function trollwait()
endfunction
function trollfollow()
endfunction
function trolldismissed()
endfunction
function chaliceremoved()
endfunction
function chalicefilled()
endfunction
function chalicepowerup()
endfunction
function chalicedrink()
endfunction
function removeredwaterdeneffects(float today)
endfunction
faction function getcrimefactionforholdlocation(location holdlocation)
endfunction
bool function isactorcurrentlyinlocation(actor actortocheck, location locationtocheck)
endfunction
location function getcurrentholdlocationforactor(actor actortocheck)
endfunction
faction function getcrimefactionforactorscurrentlocation(actor actortocheck)
endfunction
bool function addactortocrimefactionforcurrentlocation(actor actortoaddcrimefactionto)
endfunction
bool function addaliastocrimefactionforcurrentlocation(referencealias aliastoaddcrimefactionto)
endfunction
function setdlc1wenextspecialattackday(bool forcenextwildernessencounter = false)
endfunction
function gimpalias(referencealias aliastogimp)
endfunction
function createdisguisedhunter(referencealias aliastoforceinto, referencealias aliastocreateat, bool isinitiallydisabled = true)
endfunction
function createdisguisedvampire(referencealias aliastoforceinto, referencealias aliastocreateat, bool isinitiallydisabled = true)
endfunction
function createdisguisedactorandforceintoalias(referencealias aliastoforceinto, referencealias aliastocreateat, int type, bool isinitiallydisabled = true)
endfunction
actorbase function placeatmefromarray(actorbase[] arraytocreatefrom)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1