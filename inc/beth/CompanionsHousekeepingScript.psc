scriptname companionshousekeepingscript extends quest conditional
faction property companionsfaction auto
miscobject property goldreward auto
int property goldrewardminoramount auto
int property goldrewardmoderateamount auto
int property goldrewardmajoramount auto
bool property playerwalkedawayduringkvscene auto conditional
bool property playerwalkedawayduringsascene auto conditional
bool property playerignoredvilkasoutside auto conditional
bool property playermetkodlak auto conditional
bool property playermetvilkas auto conditional
bool property playermeteorlund auto conditional
bool property playermetaela auto conditional
bool property playermetskjor auto conditional
bool property playermetfarkas auto conditional
bool property farkaslastscenestarted auto conditional
bool property aelashouldforcegreet auto conditional
bool property eorlundshouldforcegreet auto conditional
bool property farkasscenego auto conditional
quest property trainingquest auto
referencealias property vilkassword auto
referencealias property vilkasquestsword auto
bool property vilkashashisswordback auto conditional
bool property playermetcompanionsatgiant auto conditional
bool property playerhelpedcompanionsatgiant auto conditional
bool property gotweaponreward auto conditional
bool property eorlundtoldaboutskyforge auto conditional
referencealias property currentfollower auto
dialoguefollowerscript property followerscript auto
globalvariable property playerfollowercount auto
darkbrotherhood property dbscript auto
actor property cicerofollower auto
actor property dbinitiatefollower1 auto
actor property dbinitiatefollower2 auto
referencealias property skjor auto
referencealias property aela auto
referencealias property farkas auto
referencealias property vilkas auto
referencealias property kodlak auto
referencealias property athis auto
referencealias property njada auto
referencealias property ria auto
referencealias property torvar auto
referencealias property eorlund auto
faction property trainerfaction auto
referencealias property trialobserver auto
weapon property vilkasweapon auto
leveleditem property companionsarmor auto
leveleditem property skyforgesteelweapons auto
objectreference property eorlundvendorchest auto
globalvariable property gearchance auto
bool property playerthievingandnotpaying auto conditional
int property playerthievingthreshold auto conditional
referencealias property genericdialoguesuppressor1 auto
referencealias property genericdialoguesuppressor2 auto
referencealias property genericdialoguesuppressor3 auto
referencealias property genericdialoguesuppressor4 auto
bool property playerhasbeastblood = false auto conditional
globalvariable property playeriswerewolf auto
bool property playeriswerewolfvirgin = false auto conditional 
bool property tempunderforgeaccess = false auto conditional
quest property werewolfchangetrackingquest auto
spell property werewolfimmunity auto
spell property beastform auto
spell property hircinesringpower auto
race property playeroriginalrace auto
race property argonianrace auto
race property argonianracevampire auto
race property bretonrace auto
race property bretonracevampire auto
race property darkelfrace auto
race property darkelfracevampire auto
race property highelfrace auto
race property highelfracevampire auto
race property imperialrace auto
race property imperialracevampire auto
race property khajiitrace auto
race property khajiitracevampire auto
race property nordrace auto
race property nordracevampire auto
race property orcrace auto
race property orcracevampire auto
race property redguardrace auto
race property redguardracevampire auto
race property woodelfrace auto
race property woodelfracevampire auto
shout property currenthowl auto
wordofpower property currenthowlword1 auto
wordofpower property currenthowlword2 auto
wordofpower property currenthowlword3 auto
int property radiantquestsdone auto conditional
int property radiantquestsdoneincurrentsegment auto conditional
referencealias property radiantquestgiver auto
faction property currentfollowerfaction auto
int property c04minlevel auto ; because there are hagravens involved
companionsradiantquest property aelacurrentquest auto
companionsradiantquest property vilkascurrentquest auto
companionsradiantquest property farkascurrentquest auto
companionsradiantquest property skjorcurrentquest auto
companionsradiantquest property aelanextquest auto
companionsradiantquest property vilkasnextquest auto
companionsradiantquest property farkasnextquest auto
companionsradiantquest property skjornextquest auto
keyword property aelaradiantkeyword auto
keyword property skjorradiantkeyword auto
keyword property vilkasradiantkeyword auto
keyword property farkasradiantkeyword auto
keyword property reconradiantkeyword auto
bool property radiantaelablock auto conditional
bool property radiantskjorblock auto conditional
bool property radiantfarkasblock auto conditional
bool property radiantvilkasblock auto conditional
quest property radiantmiscobjquest auto
bool property storyquestisrunning auto conditional
bool property radiantquestaccepted auto conditional
bool property radiantquestfinished auto conditional
bool property iscurrentsilverhandtarget auto conditional
int  property lastradiantquestdoneindex auto conditional
bool property aelainreconmode auto conditional
bool property donereconquestforaela auto conditional
objectreference property questgiverstandmarker auto conditional
int property radiantquestsuntilc01 auto
int property radiantquestsuntilc03 auto
int property radiantquestsuntilc04 auto
companionsstoryquest property c01 auto
companionsstoryquest property c02 auto
companionsstoryquest property c03 auto
companionsstoryquest property c04 auto
companionsstoryquest property c05 auto
companionsstoryquest property c06 auto
int property totemsfound auto conditional
bool property aelaisconfused auto conditional
bool property vilkashasbeastblood auto conditional
bool property farkashasbeastblood auto conditional
companionsradiantquest property cr01 auto ; a beast loose in someone's house
companionsradiantquest property cr02 auto ; beasts in a den near town harassing people
companionsradiantquest property cr03 auto ; collect pelts
companionsradiantquest property cr04 auto ; intimidation missions
companionsradiantquest property cr05 auto ; clear a dungeon
companionsradiantquest property cr06 auto ; family heirloom
companionsradiantquest property cr07 auto ; capture criminals
companionsradiantquest property cr08 auto ; rescue people
companionsradiantquest property cr09 auto ; assasinate lieutenants
companionsradiantquest property cr10 auto ; steal plans
companionsradiantquest property cr11 auto ; retrieve pieces of blade
companionsradiantquest property cr12 auto ; wipe out camps
companionsradiantquest property cr13 auto ; curing vilkas/farkas
companionsradiantquest property cr14 auto ; let a newbie in
companionsstoryquest property currentstoryquest auto
int property favoritequestgiver auto conditional
bool property aelaisobserver auto conditional
bool property farkasisobserver auto conditional
int property aelaquests auto
int property farkasquests auto
int property vilkasquests auto
int property skjorquests auto
locationalias property dustmanscairn auto
locationalias property gallowsrock auto
locationalias property ysgramorstomb auto
companionsradiantquest function getradiantquestfromindex(int questindex)
endfunction
int function getindexfromradiantquest(quest rquest)
endfunction
function oninit()
endfunction
function setupcompanions()
endfunction
function playerjoin()
endfunction
function openskyforge()
endfunction
function givevilkasbackhissword()
endfunction
function cycleradiantquests()
endfunction
function pickradiantquest(actor questgiver)
endfunction
function registerradiantquest(companionsradiantquest newradiant)
endfunction
function acceptradiantquest(actor questgiver, bool comesalong)
endfunction
function shutdownradiantquests(actor exception = none)
endfunction
function shutdownradiantquestsfor(actor busy)
endfunction
function reopenallradiantquests()
endfunction
function kickoffreconquests()
endfunction
int function completeradiantquest(companionsradiantquest rq)
endfunction
actor function getfavoritequestgiver()
endfunction
function startstoryquest(companionsstoryquest storytostart)
endfunction
function completestoryquest(companionsstoryquest storytoend)
endfunction
function addharbingerperks()
endfunction
function cureplayer()
endfunction
function shutup(actor tobeshut)
endfunction
function unshutup(actor tobeunshut)
endfunction
function swapfollowers()
endfunction
function cleanupfollowerstate()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1