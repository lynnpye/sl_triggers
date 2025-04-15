scriptname ms10questscript extends quest  conditional
book  property journal  auto  
int property rewardamount auto  
miscobject property rewarditem  auto  
bool property fightingstig  auto  
bool property knowsnameofpirates  auto  conditional
bool property stigintroduced auto  conditional
bool property playerknowsabouthaldyn auto  conditional
bool property adelaisafginoffice auto conditional
bool property stigpersuaded auto conditional
int property bribeamount  auto  
miscobject property bribeitem  auto  
referencealias property adelaisa auto
referencealias property shipinwindhelm auto
referencealias property shipdoorinwindhelm auto
referencealias property haldyn auto
referencealias property shipatisland auto
objectreference property remoteplayertarget auto
objectreference property remoteadelaisatarget auto
objectreference property localplayertarget auto
objectreference property localadelaisatarget auto
referencealias property follower auto       ; on dialoguefollower
referencealias property animalfollower auto ; on dialoguefollower
objectreference property followertarget auto
objectreference property localfollowertarget auto
objectreference property animalfollowertarget auto
objectreference property localanimalfollowertarget auto
function setsail()
endfunction
function headbackhome()
endfunction
function geterdonewithstig()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1