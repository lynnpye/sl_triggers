scriptname c03questscript extends companionsstoryquest conditional
quest property c02postquest auto
quest property c03postquest auto
objectreference property silverhandenablemarker auto
bool property playergotreward auto conditional
bool property aelagreetposttransform auto conditional
bool property aelashouldforcegreet auto conditional
referencealias property aela auto
referencealias property skjor auto
referencealias property essentialskjor auto
referencealias property krev auto
weapon property swordreward auto
weapon property daggerreward auto
weapon property battleaxereward auto
weapon property greatswordreward auto
weapon property warhammerreward auto
weapon property waraxereward auto
weapon property macereward auto
bool property skjorofferingtransform auto conditional
bool property checkedinwithaela = false auto
bool property transformedrecently = true auto conditional
referencealias property debugfollower auto ; on remote quest
function init()
endfunction
function poorskjor()
endfunction
function teardown()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1