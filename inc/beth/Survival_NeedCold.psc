scriptname survival_needcold extends survival_needbase
message property survival_helpcoldhigh auto
globalvariable property survival_helpshown_cold auto
formlist property survival_ashweather auto
formlist property survival_blizzardweather auto
formlist property survival_coldweakracesmajor auto
formlist property survival_interiorareas auto
globalvariable property gamehour auto
globalvariable property survival_afflictioncoldchance auto
globalvariable property survival_lastwarmingupmsgtime auto
globalvariable property survival_racialbonusmajor auto
globalvariable property timescale auto
survival_heatcheck property heatcheck auto
referencealias property playeralias auto
referencealias property playerinfoalias auto
quest property survival_playerinfoquest auto
spell property survival_afflictionfrostbitten auto
message property survival_coldwarmingupmessage auto
message property survival_coldconditionstage5 auto
message property survival_coldconditionstage4 auto
message property survival_coldconditionstage3 auto
message property survival_coldconditionstage2 auto
message property survival_coldconditionstage1 auto
message property survival_coldconditionstage0 auto
message property survival_afflictionfrostbittenmsg auto
globalvariable property survival_coldlevelmult auto
globalvariable property survival_coldresistmaxvalue auto
globalvariable property survival_coldtargetgamehourstonumb auto
globalvariable property survival_coldlevelinfreezingwater auto
int property coldlevelwarmarea     = 0  auto hidden
int property coldlevelcoolarea     = 3  auto hidden
int property coldlevelfreezingarea    = 6  auto hidden
int property coldlevelwarmareanightmod   = 1  auto hidden
int property coldlevelcoolareanightmod  = 2  auto hidden
int property coldlevelfreezingareanightmod  = 4  auto hidden
int property coldlevelrainmod     = 3  auto hidden
int property coldlevelsnowmod     = 6  auto hidden
int property coldlevelblizzardmod    = 10 auto hidden
int property coldstage1coldlevelmin   = 1  auto hidden
int property coldstage2coldlevelmin   = 4  auto hidden
int property coldstage3coldlevelmin   = 7  auto hidden
int property coldstage4coldlevelmin   = 10  auto hidden
int property coldstage5coldlevelmin   = 13  auto hidden
bool property isbeastrace = false auto hidden
int property currentcoldlevel = 0 auto hidden
int property lastcoldlevel = 20 auto hidden
globalvariable property survival_temperaturelevel auto
float property cachedtimescale auto hidden
float property cachedcoldlevelmult auto hidden
float property cachedcoldtargetgamehourstonumb auto hidden
float property cachedneedupdategametimeinterval auto hidden
float property cachedcoldresistmaxvalue auto hidden
function startneed()
endfunction
function setneedstagevalues()
endfunction
function stopneed()
endfunction
function precachevalues()
endfunction
function needupdategametime()
endfunction
function increasecold(float amount, float custommaxvalue = -1.0)
endfunction
function decreasecold(float amount, float customminvalue = -1.0, bool suppresswarmupmessage = false)
endfunction
float function getamounttoincrementby(int ticks, float ratereductionmultiplier)
endfunction
function applycoldstage(float newcoldvalue, float oldcoldvalue)
endfunction
float function incrementneedbytick(float ceilingvalue, float ratereductionmultiplier = 0.0)
endfunction
int function gettemperaturelevelforui()
endfunction
float function getneedratepertick()
endfunction
int function getcoldstagemaximum(int aicoldlevel)
endfunction
function checkifmaxcold(float afcoldvalue)
endfunction
function setuitemperaturelevel(int ailevel)
endfunction
function updatetemperatureui(int aicoldlevel, float afoldcoldvalue, float afnewcoldvalue)
endfunction
function forcetemperatureuinearheat()
endfunction
function forcetemperatureuineutral()
endfunction
function forcetemperatureuilastknown()
endfunction
function forcetemperaturelevelui(int level)
endfunction
int function updatecoldlevel()
endfunction
function displaycoldleveltransitionmessage(int aicoldlevel)
endfunction
function removeallneedspells()
endfunction
float function getmaxstagevalue(int maxstageid)
endfunction
function updateattributepenalty(float afneedvalue, string asattributeav = "", string aspenaltyav = "")
endfunction
function clearattributepenalty(string aspenaltyav = "")
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1