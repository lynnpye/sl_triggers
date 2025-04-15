scriptname c01questscript extends companionsstoryquest conditional
referencealias property observer auto
bool property playerwalkedawayfromfromoffer auto conditional
bool property observertransform auto conditional
bool property dogsoutofthebag auto conditional
bool property observercloseby auto conditional
objectreference property observercompensationpoint auto conditional
scene property observergoesnuts auto
message property tempmessage auto
referencealias property debugfollower auto ; on remote quest
bool property observerreadyforreveal auto conditional
quest property c02kicker auto
bool property skjorgavelowdown auto conditional
bool property observerdismissed auto conditional
bool property ambushleverpulled auto conditional
bool property playerinambushspace auto conditional
idle property idlewerewolftransformation auto
race property werewolfrace auto
referencealias property observerlycanstorage auto
scene property ambushscene auto
scene property postambush auto
outfit property aelaoutfit auto
outfit property farkasoutfit auto
actor property aela auto
actor property farkas auto
referencealias property ambushfighter1 auto
referencealias property ambushfighter2 auto
referencealias property ambushfighter3 auto
referencealias property ambushfighter4 auto
referencealias property ambushfighter5 auto
faction property silverhandfaction auto
faction property silverhandfactionpacified auto
faction property dunprisonerfaction auto
weapon property aelabasemeleeweapon auto
weapon property aelabaserangedweapon auto
weapon property farkasbasemeleeweapon auto
weapon property farkasbaserangedweapon auto
keyword property weaptypebow auto
spell property werewolfchangefx auto
armor property wolfskinfxarmor auto
bool property dorealtransform = false auto
bool property fakefight = true auto
function init()
endfunction
function playerenteredambushzone(bool entered)
endfunction
function ambushprep()
endfunction
function fightstart()
endfunction
function observerdropweapon()
endfunction
function observerdotransform()
endfunction
function observeractuallytransform()
endfunction
function observerturnback()
endfunction
event onanimationevent(objectreference aksource, string aseventname)
endevent
function ambusherkilled()
endfunction
function teardown()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1