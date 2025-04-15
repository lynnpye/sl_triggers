scriptname dlc2tamedragonscript extends quest  conditional
function tamedragon(actor newdragon)
endfunction
function landdragon()
endfunction
function validateworldspace()
endfunction
function endwait()
endfunction
function releasedragon()
endfunction
event onupdategametime()
endevent
function trytoreleasedragon(actor dragonactor)
endfunction
function finishrelease()
endfunction
function dragondead()
endfunction
function restraindragon(bool brestrain)
endfunction
event onupdate()
endevent
referencealias property dragonalias  auto  
referencealias property dragonreleasedalias  auto  
scene property dlc2tamedragonscene1  auto  
scene property dlc2tamedragonscene2 auto  
scene property dlc2mq06tamedragonscene  auto
faction property dlc2mq06dragonfaction auto
quest property dlc2mq06 auto
float property ftamehours = 1.0  auto  conditional
scene property dlc2tamedragonreleasescene  auto  
objectreference property dlc2tamedragonorbitmarker auto
formlist property dlc2tamedragonallowedworldspaces auto
spell property dlc2tamedragonnoflyability  auto  
spell property dlc2abcalmdragon  auto  
faction property dlc2tamedragonfaction auto
message property dlc2tamedragonresistmsg auto
int property idragonsriddenachievementcount = 5 auto
message property dlc2learndragonridingmsg auto
faction property dlc2tameddragontrackingfaction auto
;This file was cleaned with PapyrusSourceHeadliner 1