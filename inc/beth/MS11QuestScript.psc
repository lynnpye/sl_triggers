scriptname ms11questscript extends quest conditional
bool property questionedwitness1 auto conditional
bool property questionedwitness2 auto conditional
bool property questionedwitness3 auto conditional
bool property playerhasauthority auto conditional
bool property playerhasfoundhorridroom auto conditional
bool property calixtodead auto conditional
bool property sentviolatohjerim auto conditional
bool property gotredherringfromcalixto auto conditional
bool property playerinstonequarter auto conditional
bool property playerinmurderzone auto conditional ; best variable name ever?
bool property playerreadjournal2 auto conditional
bool property getinhjerimtovapointer auto conditional
bool property getinhjerimulfricpointer auto conditional
bool property getinhjerimhousepointer auto conditional
bool property investigateviolapointer auto conditional
bool property investigatecalixtopointer auto conditional
bool property guardgaveplayerstory auto conditional
bool property violaconversationshunt = false auto conditional
bool property playertalkedtoviolaaboutbutcher auto conditional
bool property siegeofwindhelmtakingplace auto conditional
referencealias property calixto auto
referencealias property arivanya auto
referencealias property potentialthirdvictim auto
referencealias property finalvictim auto
referencealias property initialvictimbody auto
actorbase property alternatebody auto
referencealias property crimescene auto
faction property harmlesscorpse auto
package property victimwanderpackage auto
scene property calixtokillkillkillscene auto
armor property innocuousamulet auto
armor property necromancersamulet auto
quest property shadowquest auto
objectreference property hjerimdoor auto
referencealias property helgird auto
objectreference property originalbody auto
objectreference property hallofdeadbrowsemarker auto
bool property bodyisinhallofdead auto conditional
bool property talkedtohelgird auto conditional
bool property wuunfertharrested auto conditional
perk property investigator auto
function setup()
endfunction
function checkfordeletedbody()
endfunction
function disableifnotcompleted(int objective)
endfunction
function resolveobjective(int complete, int display)
endfunction
function movebody()
endfunction
function cleanuphallofdead()
endfunction
function setupstakeout()
endfunction
function teardown()
endfunction
function civilwarbattle(bool battleactive)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1