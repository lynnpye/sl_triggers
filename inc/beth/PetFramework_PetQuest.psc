scriptname petframework_petquest extends quest  conditional
petframework_parentquestscript property petframework_parentquest auto
message property petframework_petdismissmessage auto
message property petframework_petmaxreachedmessage auto
faction property petframework_petfollowingfaction auto
faction property playerfaction auto
faction property petframework_petfaction auto
referencealias property pethomemarker auto
referencealias property petrefalias auto
referencealias property petdynamichomemarker auto
bool property movingtogglepackageon = false auto conditional hidden ;hearthfire adoption/move trick - turn on a temporary package
function makepetavailabletoplayer()
endfunction
function makepetunavailabletoplayer()
endfunction
function followplayer(bool snapintointeraction = false)
endfunction
function waitforplayer(bool dowait = true)
endfunction
function sethometocurrentlocation()
endfunction
function setnewhome(referencealias newlocation, bool dismiss = true, bool dowarp = false)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1