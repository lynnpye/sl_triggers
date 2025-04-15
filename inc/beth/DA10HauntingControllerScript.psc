scriptname da10hauntingcontrollerscript extends quest conditional
int property lvlthreshold1 = 3 auto
int property lvldamage1  = 30 auto
int property lvlthreshold2 = 6 auto
int property lvldamage2 = 40 auto
int property lvlthreshold3 = 9 auto
int property lvldamage3 = 50 auto
int property lvlthreshold4 = 12 auto
int property lvldamage4 = 60 auto
int property lvlthreshold5 = 16 auto
int property lvldamage5 = 70 auto
int property lvldamage6 = 80 auto
referencealias property item1 auto
referencealias property item2 auto
referencealias property item3 auto
referencealias property item4 auto
referencealias property item5 auto
referencealias property item6 auto
referencealias property item7 auto
referencealias property item8 auto
referencealias property item9 auto
referencealias property item10 auto
referencealias property item11 auto
referencealias property item12 auto
referencealias property item13 auto
referencealias property item14 auto
referencealias property item15 auto
referencealias property basementitem01 auto
referencealias property basementitem02 auto
referencealias property basementitem03 auto
referencealias property basementitem04 auto
referencealias property basementitem05 auto
referencealias property bedroomitem auto
referencealias property alias_witchhunter  auto  
location property logrolfshouseloc auto
sound property hauntedsound auto
int property hauntedsoundid auto
float property shaketimer = 2.0 auto
float property ghosttimermax = 1.0 auto
float property ghosttimermin = 0.5 auto
float property currentsoundtimer = 0.0 auto hidden
float property ghosttimer01 = 0.0 auto hidden
float property ghosttimer02 = 0.0 auto hidden
float property ghosttimer03 = 0.0 auto hidden
int property hauntingstage = 0 auto hidden
int property randompick auto hidden
int property randomsoundpick auto hidden
referencealias property doortoslam auto
referencealias property normallights auto
referencealias property phaseonelights auto
referencealias property phasetwolights auto
referencealias property chairenablemarker auto
bool property triggersounddone = false auto hidden
bool property doortoslamdone = false auto hidden
bool property normallightson = true auto hidden
bool property phaseonelightson = false auto hidden
bool property phasetwolightson = false auto hidden
bool property singlerumbledone = false auto hidden
bool property secondismddone = false auto hidden
bool property ghostsstopped = false auto hidden
float property lightsbackontime = 3.0 auto hidden
quest property da10 auto
imagespacemodifier property da10hauntingismdin  auto 
imagespacemodifier property da10hauntingismdloop  auto 
imagespacemodifier property da10hauntingismdout  auto 
sound property qstda10rumble auto
sound property qstda10spookydistant auto
objectreference property da10spookysoundmarker01 auto
objectreference property da10spookysoundmarker02 auto
objectreference property da10spookysoundmarker03 auto
objectreference property da10spookysoundmarker04 auto
objectreference property da10spookysoundmarker05 auto
objectreference property da10spookysoundmarker06 auto
objectreference property da10spookysoundmarker07 auto
objectreference property da10spookysoundmarker08 auto
objectreference property da10spookysoundmarker09 auto
objectreference property da10spookysoundmarker10 auto
int property randomizerforstage3 auto hidden
bool property hauntactive = false auto hidden
float property looptimer = 0.3 auto
auto state waiting
endstate
state running
event onbeginstate()
endevent
endstate
function ghostactivatepicker()
endfunction
function ghostsoundpicker()
endfunction
function ghostactivatebasementpicker()
endfunction
function ghostactivate(referencealias myalias)
endfunction
function dropallghosts()
endfunction
function startrunninghaunt()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1