scriptname dlc2bookdungeoncontrollerscript extends quest  conditional
function playerinbleedout()
endfunction
function readapocryphabook(dlc2apocryphabookscript papocryphabook, bool brequirequeststagetomove = true, bool brequirerewardsshowntomove = false, bool brewardsshown = false, bool bshowrewardsonactivation = false)
endfunction
bool function readbook(dlc2blackbookscript pdatabook, dlc2blackbookscript prealbook = none)
endfunction
function takebook(dlc2blackbookscript pdatabook)
endfunction
function moveplayerhome(bool bhealplayer = false)
endfunction
function moveplayertodungeon(objectreference newdungeonmarker, location newdungeonlocation)
endfunction
bool function isreadingallowed(bool bdisplaymessages = true)
endfunction
bool function iscontrolsenabled()
endfunction
function setreenablecontrols(dlc2blackbookscript pbook, bool breenablecontrolsflag)
endfunction
function book01dungeonhmintro()
endfunction
function checkforhmintro()
endfunction
function incrementbookfinished()
endfunction
int property iblackbookfinishedforachievement = 5 auto
objectreference property tamrielmarker  auto  
objectreference property dungeonmarker  auto  
referencealias property playeralias  auto  
location property dungeonlocation  auto  
location property dlc2solstheimlocation  auto  
location property dlc2apocryphalocation  auto  
worldspace property dlc2apocryphaworld auto
keyword property dlc2apocryphabooklink auto
keyword property dlc2linkblackbooksound auto
message property dlc2bookfailurecombatmsg  auto  
message property dlc2bookfailuregenericmsg auto
message property dlc2bookfailuresolstheimmsg auto
spell property dlc2abapowaterdamage  auto  
scene property dlc2bookdungeonhmintroscene  auto  
location property dlc2book01dungeonlocation  auto  
bool property bhmintrosceneplayed = false auto conditional
objectreference property hermaeusmorata auto
objectreference property hermaeusmorafx auto
referencealias[] property blackbookaliases  auto  
referencealias[] property blackbookfinalaliases  auto  
book[] property blackbooks  auto  
armor property dlc2apocryphabookwarparmor auto
idle property idledlc2tentaclewarpbook auto
imagespacemodifier property dlc2apocryphabookenter auto
imagespacemodifier property fadetoblackimod  auto  
imagespacemodifier property fadetoblackholdimod  auto  
imagespacemodifier property fadetoblackbackimod  auto  
imagespacemodifier property dlc2apocryphabookexit  auto  
imagespacemodifier property dlc2apocryphabookexitmq02  auto  
imagespacemodifier property dlc2apocrypharewardbookenter  auto  
imagespacemodifier property dlc2apocrypharewardbookexit  auto  
location[] property bookdungeonlocations auto
dlc2hermaeusmorafacefxscript[] property hermaeusmoraintrofx auto
referencealias property follower  auto  
referencealias property bookfolloweralias  auto  
scene property dlc2bookreadscene  auto  
sound property ambblackbookshakemarker  auto  
sound property objapocryphabooktentaclestamriel  auto  
bool property bplayerbleedingout auto conditional
;This file was cleaned with PapyrusSourceHeadliner 1