scriptname carriagesystemscript extends quest  conditional
function travel(int idestination = -1, actor pdriver)
endfunction
function clearwaitingstate()
endfunction
function playerissitting()
endfunction
event onupdate()
endevent
function skiptodestinationsimple()
endfunction
keyword property linkcarriageseat auto
globalvariable property carriagecost auto
globalvariable property carriagecostsmall auto
bool property bwaitforplayertosit = true auto conditional
miscobject property gold  auto  
topic property dialoguecarriagechattertopic auto
actor property currentdriver auto  ; save current driver for update loop
objectreference property solitude  auto  
objectreference property rorikstead  auto  
objectreference property granitehill  auto  
objectreference property dragonbridge  auto  
objectreference property winterhold  auto  
objectreference property whiterun  auto  
objectreference property windhelm  auto  
objectreference property dawnstar  auto  
objectreference property falkreath  auto  
objectreference property morthal  auto  
objectreference property markarth  auto  
objectreference property riften  auto  
objectreference property karthwasten  auto  
objectreference property stonehills  auto  
objectreference property oldhroldan  auto  
objectreference property riverwood  auto  
objectreference property ivarstead  auto  
objectreference property heljarchen  auto  
objectreference property darkwatercrossing  auto  
objectreference property shorsstone  auto  
objectreference property kynesgrove  auto  
int property currentdestination auto conditional
idle property idlecartplayeridle auto
idle property idlecartplayerexit auto
idle property idlecartdriveridle auto
idle property idlecartdriverexit auto
idle property idlecartpassenger1idle auto
idle property idlecartpassenger1exit auto
idle property idlecartpassenger2idle auto
idle property idlecartpassenger2exit auto
idle property idlecartpassenger3idle auto
idle property idlecartpassenger3exit auto
referencealias property follower  auto  
referencealias property cartrider1  auto  
referencealias property cartrider2  auto  
referencealias property cartrider3  auto  
globalvariable property weenabled auto
idle property offsetstop  auto  
function rideincart(actor mydriver, actor myhorse, objectreference mycart, int idestination = -1, int istartinglocation = 1, bool payforride = false)
endfunction
function stopriding(actor mydriver, actor myhorse, objectreference mycart, bool bpause = true, bool bfasttravel = false)
endfunction
function skiptodestination()
endfunction
function addpassenger(actor mypassenger, objectreference mycart, int iseat = 1)
endfunction
function removepassengers()
endfunction
bool function removepassenger(referencealias myalias, int iseat)
endfunction
function notifyoncartexit(referencealias myalias)
endfunction
idle function getcartidle(int iseat, bool bexit = false)
endfunction
function disableallotherdrivers(objectreference mydriver)
endfunction
function resetalldrivers()
endfunction
function resetdriver(referencealias driveralias)
endfunction
referencealias property cartriderplayer  auto  
topic property arrivaltopic  auto  
referencealias property whiterundriver auto
referencealias property solitudedriver auto
referencealias property markarthdriver auto
referencealias property riftendriver auto
referencealias property windhelmdriver auto
globalvariable property carriageallowcwdisable  auto  
globalvariable property sittinganglelimit  auto  
idle property exitcartbegin  auto  
idle property exitcartend  auto  
idle property idlecartexitinstant  auto  
globalvariable property testcartquickexit  auto  
referencealias property playerrider  auto  
imagespacemodifier property fadetoblackimod  auto  
imagespacemodifier property fadetoblackholdimod  auto  
imagespacemodifier property fadetoblackbackimod  auto  
faction property byohcarriagedriverfaction  auto  
;This file was cleaned with PapyrusSourceHeadliner 1