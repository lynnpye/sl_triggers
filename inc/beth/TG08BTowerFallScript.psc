scriptname tg08btowerfallscript extends objectreference
objectreference property tg08towersoundref auto
objectreference property tg08towerfxref auto
float property rumbleamount = 1.0 auto
float property rumbleduration = 7.0 auto
float property camerashakeamount = 0.8 auto
sound property earthquakesound auto
auto state waiting
event onactivate(objectreference akactivator)
endevent
endstate
state quake
event onbeginstate()
endevent
endstate
state done
endstate
function triggerquake()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1