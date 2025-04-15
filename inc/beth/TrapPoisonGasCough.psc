scriptname trappoisongascough extends activemagiceffect
float property fcoughtime = 5.0 auto
float property fcoughrand = 2.0 auto
float property afsmallmotorstrength = 0.2 auto
float property afbigmotorstrength = 0.2 auto
float property afduration = 1.0 auto
sound property tempsound auto
topic property dialoguegenericpoisoncoughbranchtopic auto
auto state waiting
event oneffectstart(actor aktarget, actor akcaster)
endevent
endstate
state active
event onbeginstate()
endevent
event oneffectfinish(actor aktarget, actor akcaster)
endevent
endstate
function coughloop()
endfunction
function docough()
endfunction
float function randtimerfloat()
endfunction
event oneffectstart(actor aktarget, actor akcaster)
endevent
event oneffectfinish(actor aktarget, actor akcaster)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1