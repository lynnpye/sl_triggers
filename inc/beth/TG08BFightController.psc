scriptname tg08bfightcontroller extends objectreference
objectreference property tg08risingwatercontrollerref auto
tg08risingwaterscript property watercontroller auto hidden
quest property tg08b auto
actor property mercerfreyref auto
bool property fightactive = false auto hidden
float property quaketimer auto hidden
float property quaketimermin = 5.0 auto
float property quaketimermax = 20.0 auto
float property updatetimer = 0.5 auto hidden
objectreference property tg08bmercerwithdrawmarker01 auto
objectreference property tg08bmercerwithdrawmarker02 auto
objectreference property tg08bmercerwithdrawmarker03 auto
objectreference property tg08bmercerwithdrawmarker04 auto
objectreference property tg08bmercerwithdrawmarker05 auto
objectreference property tg08bmercerwithdrawmarker06 auto
float property mindistancefrommarker = 700.0 auto hidden
float property mercerwithdrawtimer auto hidden
float property mercerwithdrawtimermin = 5.0 auto
float property mercerwithdrawtimermax = 15.0 auto
float property mercerclearwithdrawtimerlength = 25.0 auto hidden
float property mercerclearwithdrawtimer auto hidden
spell property tgnightingalestrifemercer auto
scene property tg08bmercerinvis auto
bool property mercerwithdrawready = false auto hidden
bool property mercerdrainspell = false auto hidden
auto state waiting
event onactivate(objectreference akactivator)
endevent
endstate
state active
event onbeginstate()
endevent
endstate
state complete
endstate
function mercerwithdraw()
endfunction
function startmercerwithdrawtimer()
endfunction
function mercerclearwithdraw()
endfunction
function mercerdrainspelldone()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1