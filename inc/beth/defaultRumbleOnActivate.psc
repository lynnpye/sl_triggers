scriptname defaultrumbleonactivate extends objectreference
float property cameraintensity = 0.25 auto
float property shakeleft = 0.25 auto
float property shakeright = 0.25 auto
float property duration = 0.25 auto
bool property repeatable = true auto
auto state active
event onactivate(objectreference actronaut)
endevent
endstate
state busy
event onactivate(objectreference actronaut)
endevent
endstate
state inactive
endstate
;This file was cleaned with PapyrusSourceHeadliner 1