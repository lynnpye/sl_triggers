scriptname da05questscript extends quest conditional
bool property mathiestoldstory auto conditional
bool property sindingtoldstory auto conditional
bool property sindingmentionedhircine auto conditional
bool property sindingtoldaboutwitches auto conditional
bool property playerclosetosinding auto conditional
bool property sindingclosetoplayer auto conditional
int property huntersalive auto conditional
location property falkreath auto
globalvariable property gamehour auto
scene property funeralscene auto
bool property playersawfuneral auto conditional
bool property playertalkedtohunter auto conditional
armor property cursedring auto
worldspace property bloatedmansgrotto auto
quest property companionscentralquest auto
spell property werewolfchange auto
race property werewolfbeastrace auto
referencealias property sinding auto
actor property originalsinding auto
referencealias property hunter5 auto
referencealias property hunter6 auto
referencealias property hunter7 auto
referencealias property hunter8 auto
referencealias property hunter9 auto
referencealias property hunter10 auto
referencealias property hunter11 auto
referencealias property hunter12 auto
function waitforcallback()
endfunction
function killhunter(actor killed)
endfunction
function checkforscenestart(location newlocation)
endfunction
event onanimationevent(objectreference aksource, string aseventname)
endevent
function registeradditionalhunter(objectreference newhunter)
endfunction
event onupdategametime()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1