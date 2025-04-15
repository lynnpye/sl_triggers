scriptname da02script extends quest  conditional
int property stage auto conditional
int property reasongiven auto conditional hidden ;used in dialogue when boethiah asks the player why he slayed someone at the shrine
objectreference property da02boethiahshrinemapmarker auto
weapon property da02dagger auto
book property da02book auto
quest property da02killobj auto
quest property da02post auto
scene property da02fightscene2 auto
scene property da02boethiahscene1 auto
scene property da02boethiahscene2 auto
scene property da02boethiaharmorwornscene auto
scene property da02boethiahelisifscene auto
scene property da02pillartrapscene auto
faction property da02cultistsareenemies auto
faction property da02culistsplayerenemy auto
referencealias property fighter1 auto
referencealias property fighter2 auto
referencealias property boethiahsconduit auto
referencealias property champion auto
referencealias property cultist1 auto
referencealias property cultist2 auto
referencealias property cultist3 auto
referencealias property cultist4 auto
referencealias property cultist5 auto
int property friendpresent auto hidden ;0 not set, 1 = friend is here, -1 = friend has left -- see da02friendchecktriggerscript
int property countcultists = 5 auto hidden  ;see incrementcountcultists() and decrementcountcultists() functions
int property countcontenders = 3 auto hidden
armor property da02cuirass auto
int property foundmail auto hidden conditional
int property championdead auto hidden conditional
int property warnedchampion auto hidden conditional  ;set in stage 21 - obsolete
faction property winobodycleanupfaction auto
referencealias property deadfriend auto
objectreference property shrineofboethiahref auto
objectreference property da02pillarref auto
objectreference property fxshrineofboethiaorbref auto
int property pillartrappedvictim auto conditional ;used as condition on packages
visualeffect property da02summonvalortargetfx auto
imagespacemodifier property da02resurrectblur auto
imagespacemodifier property da02resurrectbluranimated auto
int property guardforcegreet auto hidden conditional  ;0 = unset, 1 = forcegreeted. set in dialogue.
location property solitudebluepalacelocation auto
referencealias property guarda auto
referencealias property guardb auto
referencealias property guardc auto
referencealias property guardd auto
locationreftype property da02palaceattacktrigger auto
locationreftype property da02palacefollowtrigger auto
locationreftype property da02palacewarntrigger auto
int property inofflimitsarea auto hidden conditional  ; >0 == true, set by processpalacetrigger which is called by the palacexxxtrigger aliases script
int property inwarnarea auto hidden conditional   ; >0 == true, set by processpalacetrigger which is called by the palacexxxtrigger aliases script
int property infollowarea auto hidden conditional   ; >0 == true, set by processpalacetrigger which is called by the palacexxxtrigger aliases script
scene property da02guardalostdetectionscene auto  ;the scene that plays when the player shakes his guard escort
scene property da02soundalarmscene auto ;scene that starts the guards attacking the player
faction property da02guardsplayerenemy auto
quest property da02guardwarn auto  ;makes the closest gaurd say the private area is offlimits, see testguarddetection()
referencealias property friendescort auto
int property nearescort auto hidden conditional  ;used by guard packages
scene property da02friendescortscene auto  ;scene where friend gets elisif to open the door for you
key property solitudebluepalaceservantskey auto
faction property da02elisifafraidofplayer auto
event onupdate()
endevent
function pillartrap(objectreference akactionref)
endfunction
function pillarkill(actor victim)
endfunction
function pillarstop() ; called in stage 20
endfunction
function killpreviousconduit()
endfunction
function resurrectcounduit(referencealias aliastomakeconduit = none)
endfunction
function releaseconduit()
endfunction
function decrementcountcultists(referencealias deadcultistalias)
endfunction
function checkdeadandsetstage(referencealias deadcultistalias)  ;also called from da02fighterscript
endfunction
function makecultistsaggressive()
endfunction
function processpalacetrigger(objectreference triggerref, bool isentering)
endfunction
function testguarddetection()
endfunction
function promotetofriendescort(actor friendactor)
endfunction
function soundalarm(objectreference objectatwhichtocreatedetectionevent)
endfunction
function giveplayerservantskey(actor actorgivingkey)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1