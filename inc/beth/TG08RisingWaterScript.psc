scriptname tg08risingwaterscript extends objectreference
objectreference property waterplaneref auto
objectreference property waterplaneheight00ref auto
objectreference property waterplaneheight01ref auto
float property waterplaneheight01 auto
objectreference property waterplaneheight02ref auto
objectreference property crumblebalconyref auto
objectreference property irkngthandexitenableref auto
float property afx auto
float property afy auto
float property afz auto
float property afxangle auto
float property afyangle auto
float property afzangle auto
float property aftangentmagnitude = 1.0 auto
float property afspeed1 = 0.5 auto
float property afspeed2 = 15.0 auto
float property afmaxrotationspeed = 0.0 auto
float property rumbleamount1 = 1.0 auto
float property rumbleduration1 = 7.0 auto
float property camerashakeamount1 = 0.8 auto
objectreference property effectlinker1 auto
float property rumbleamount2 = 1.0 auto
float property rumbleduration2 = 11.0 auto
float property camerashakeamount2 = 1.0 auto
objectreference property effectlinker2 auto
objectreference property statuetorch auto
objectreference property sidewalltorch auto
objectreference property sunlight auto
objectreference property exitrocks auto
objectreference property tg08rockfallcollisionparent auto
objectreference property tg08navcutparent auto
objectreference property pipecontrollerbig01 auto
objectreference property pipecontrollerbig02 auto
objectreference property pipecontrollerbig03 auto
objectreference property pipecontrollerbig04 auto
objectreference property pipecontrollersmall01 auto
objectreference property pipecontrollersmall02 auto
objectreference property pipecontrollersmall03 auto
objectreference property pipecontrollersmall04 auto
objectreference property currenttranslatetarget auto
float property currenttranslatespeed auto
objectreference property tg08bactorbarrier auto
sound property earthquakesound auto
float property waterplaneheight auto
bool property phase1 auto hidden
actor property karliahref auto
actor property brynjolfref auto
auto state inactive
event onactivate(objectreference akactivator)
endevent
endstate
state risingphase1
event onbeginstate()
endevent
event onactivate(objectreference akactivator)
endevent
endstate
state risingphase2
event onbeginstate()
endevent
event onactivate(objectreference akactivator)
endevent
endstate
bool property statuetorchdisabled = false auto hidden
float property statuetorchheight auto hidden
objectreference property tg08bsmoker auto
bool property waterheightfinished = false auto hidden
float property waterfinishedheight auto hidden
bool property sidewalltorchdisabled = false auto hidden
float property sidewalltorchheight auto hidden
objectreference property tg08bsmokel auto
bool property watersplashstarteds01 auto hidden
objectreference property tg08watersplashs01 auto
float property watersplashheights01 auto hidden
bool property watersplashstarteds02 auto hidden
objectreference property tg08watersplashs02 auto
float property watersplashheights02 auto hidden
bool property watersplashstarteds03 auto hidden
objectreference property tg08watersplashs03 auto
float property watersplashheights03 auto hidden
bool property watersplashstarteds04 auto hidden
objectreference property tg08watersplashs04 auto
float property watersplashheights04 auto hidden
bool property watersplashstartedb01 auto hidden
objectreference property tg08watersplashb01 auto
float property watersplashheightb01 auto hidden
bool property watersplashstartedb02 auto hidden
objectreference property tg08watersplashb02 auto
float property watersplashheightb02 auto hidden
bool property watersplashstartedb03 auto hidden
objectreference property tg08watersplashb03 auto
float property watersplashheightb03 auto hidden
bool property watersplashstartedb04 auto hidden
objectreference property tg08watersplashb04 auto
float property watersplashheightb04 auto hidden
bool property pipecontrollersmall01done = false auto hidden
float property pipecontrollersmall01height auto hidden
bool property pipecontrollersmall02done = false auto hidden
float property pipecontrollersmall02height auto hidden
bool property pipecontrollersmall03done = false auto hidden
float property pipecontrollersmall03height auto hidden
bool property pipecontrollersmall04done = false auto hidden
float property pipecontrollersmall04height auto hidden
bool property pipecontrollerbig01done = false auto hidden
float property pipecontrollerbig01height auto hidden
bool property pipecontrollerbig02done = false auto hidden
float property pipecontrollerbig02height auto hidden
bool property pipecontrollerbig03done = false auto hidden
float property pipecontrollerbig03height auto hidden
bool property pipecontrollerbig04done = false auto hidden
float property pipecontrollerbig04height auto hidden
objectreference property tg08bescapeheightref auto
bool property exitrocksfinished = false auto hidden
float property exitrocksheight auto hidden
quest property tg08b auto
bool property waterisdone = false auto hidden
float property watersynctimer = 0.0 auto hidden
bool property watersynccheck = false auto hidden
function waterrise2()
endfunction
function setupwaterheights()
endfunction
function startwaterrisephase2()
endfunction
function changepipestate(objectreference mypipe, string mystatestring)
endfunction
function causeearthquake1()
endfunction
function causeearthquake2()
endfunction
function triggerwaterrisematch(objectreference mypipe)
endfunction
function matchwaterriseall()
endfunction
function triggeraftershock(float rumbleduration)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1