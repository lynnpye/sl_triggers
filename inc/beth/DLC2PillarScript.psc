scriptname dlc2pillarscript extends quest  
faction property dlc2pillarbuilderfaction auto
keyword property dlc2linkpillartoggle auto  ;used for link ref from actors to toggle
globalvariable property dlc2pillarchantnum auto
dlc2pillarplayerscript property player auto
faction property dunprisonerfaction auto
package property dlc2sleepbuild auto
function makemeabuilder(actor actortomakeabuilder, int hoursdelaytomakeabuilder = 4)
endfunction
function addmetobuilderfaction(actor actortoaddtofaction); called by dlc2pillarbuilderscript
endfunction
function checkmypillartoggle(actor actortocheck)
endfunction
function cueupnextspeakerandline()
endfunction
function incrementline()
endfunction
function setbuilderfactionfriendliness(actor actortoset, bool issleepbuildtemplate = false)
endfunction
event onsleepstart(float afsleepstarttime, float afdesiredsleependtime)
endevent
dlc2standingstonescript[] property standingstones  auto  
int property chancetoworkonpillar = 100 auto
int property chancenormal = 33 auto
location property dlc2solstheimlocation auto
quest property dlc2mq03b auto
keyword property loctypedwelling  auto  
worldspace property dlc2solstheimworld auto
pdbentrancequestscript property dbentrancequest auto
;This file was cleaned with PapyrusSourceHeadliner 1