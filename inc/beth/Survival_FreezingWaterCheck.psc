scriptname survival_freezingwatercheck extends activemagiceffect
survival_conditionsscript property conditions auto
survival_needcold property cold auto
survival_playerlocationinfo property playerinfo auto
actor property playerref auto
globalvariable property survival_lastwaterfreezingmsgtime auto
magiceffect property firecloakffself auto
magiceffect property mgrjzargofirecloakffself auto
magiceffect property powerdarkelffirecloakffself auto
message property survival_waterfreezingmessage auto
spell property survival_freezingwaterdamage auto
worldspace property dlc1hunterhqworld auto
sound property fxfreezingwatersoundfx auto
sound property fxfreezingwatersoundfxfemale auto
imagespacemodifier property fxfreezingwaterism auto
float property fxfreezingwaterrumblesmallmotorstrength = -1.0 auto
float property fxfreezingwaterrumblebigmotorstrength = -1.0 auto
float property fxfreezingwaterrumbleduration = -1.0 auto
event oneffectstart(actor aktarget, actor akcaster)
endevent
event onupdate()
endevent
function checkwater()
endfunction
event oneffectfinish(actor aktarget, actor akcaster)
endevent
function applysfx(sound sfx, sound sfxfemale = none)
endfunction
function applyism(imagespacemodifier ism)
endfunction
function applyrumble(float rumblesmall = -1.0, float rumblebig = -1.0, float rumbleduration = -1.0)
endfunction
bool function playerhasflamecloak()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1