scriptname trapbreakawaybase extends objectreference
sound property breaksound auto
float property initialdelay = 0.5 auto
auto state unbroken
event ontriggerenter(objectreference triggerref)
endevent
endstate
state destroyed
endstate
event onload()
endevent
event onunload()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1