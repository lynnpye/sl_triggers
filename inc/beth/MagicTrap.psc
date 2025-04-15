scriptname magictrap extends trapbase
spell property magicweapon auto hidden
float property initialdelay = 0.5 auto hidden
float property firingrate = 2.0 auto hidden
float property currentfiringtimer auto hidden
float property firingspinup = 0.5 auto hidden
int property castingaim = 0 auto
objectreference property targetref auto hidden
bool property forwardfiring = false auto
int property aaspelltocast = 0 auto
objectreference property mysoulgem auto hidden
formlist property flsoulgemtest auto
int property myspelllevel = 1  auto hidden
objectreference property trapself auto hidden
objectreference property clearref auto hidden
bool property isfiring auto hidden
bool property isloaded auto hidden
keyword property traplink auto hidden
function firetrap()
endfunction
state pause
event onbeginstate()
endevent
event onactivate( objectreference activateref )
endevent
endstate
auto state disarmed
event onbeginstate()
endevent
event onactivate( objectreference activateref )
endevent
endstate
state reset
event onbeginstate()
endevent
event onactivate( objectreference activateref )
endevent
endstate
state arming
event ontriggerleave(objectreference triggerref)
endevent
endstate
event oncellattach()
endevent
event oncelldetach()
endevent
event onreset()
endevent
function resetlimiter()
endfunction
function clearmysoulgem()
endfunction
bool property gemtested = false auto hidden
function testrefissoulgem(objectreference testsoulgem)
endfunction
function firebycastingtype()
endfunction
float property horizontalsweephalf = 90.0 auto
float property verticalsweephalf = 90.0 auto
bool function refisvalidforwardtarget(objectreference testref)
endfunction
bool property attachsetupcomplete = false auto hidden
function cellattachsetup(objectreference functiontriggerref)
endfunction
int property testlvlencvalue auto
int property lvlthreshold1 auto
spell property lvlweapon1 auto hidden
int property lvlthreshold2 auto
spell property lvlweapon2 auto hidden
int property lvlthreshold3 auto
spell property lvlweapon3 auto hidden
int property lvlthreshold4 auto
spell property lvlweapon4 auto hidden
int property lvlthreshold5 auto
spell property lvlweapon5 auto hidden
spell property lvlweapon6 auto hidden
function resolveleveledweapon (int spelllevel)
endfunction
function resolvecastingdelay()
endfunction
function resolvespelltype()
endfunction
spell property slvlfirebolt1 auto
spell property slvlfirebolt2 auto
spell property slvlfirebolt3 auto
spell property slvlfirebolt4 auto
spell property slvlfirebolt5 auto
spell property slvlfirebolt6 auto
spell property slvlfireball1 auto
spell property slvlfireball2 auto
spell property slvlfireball3 auto
spell property slvlfireball4 auto
spell property slvlfireball5 auto
spell property slvlfireball6 auto
spell property slvlflames1 auto
spell property slvlflames2 auto
spell property slvlflames3 auto
spell property slvlflames4 auto
spell property slvlflames5 auto
spell property slvlflames6 auto
spell property slvllightningbolt1 auto
spell property slvllightningbolt2 auto
spell property slvllightningbolt3 auto
spell property slvllightningbolt4 auto
spell property slvllightningbolt5 auto
spell property slvllightningbolt6 auto
spell property slvlchainlightning1 auto
spell property slvlchainlightning2 auto
spell property slvlchainlightning3 auto
spell property slvlchainlightning4 auto
spell property slvlchainlightning5 auto
spell property slvlchainlightning6 auto
spell property slvlsparks1 auto
spell property slvlsparks2 auto
spell property slvlsparks3 auto
spell property slvlsparks4 auto
spell property slvlsparks5 auto
spell property slvlsparks6 auto
spell property slvlicespike1 auto
spell property slvlicespike2 auto
spell property slvlicespike3 auto
spell property slvlicespike4 auto
spell property slvlicespike5 auto
spell property slvlicespike6 auto
spell property slvlfrostbite1 auto
spell property slvlfrostbite2 auto
spell property slvlfrostbite3 auto
spell property slvlfrostbite4 auto
spell property slvlfrostbite5 auto
spell property slvlfrostbite6 auto
spell property slvlicestorm1 auto
spell property slvlicestorm2 auto
spell property slvlicestorm3 auto
spell property slvlicestorm4 auto
spell property slvlicestorm5 auto
spell property slvlicestorm6 auto
;This file was cleaned with PapyrusSourceHeadliner 1