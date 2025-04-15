scriptname fxsnowblowingfogattachscript extends objectreference  
visualeffect property fogeffectart auto ;art to attach to camera
imagespacemodifier property testcrossfadeism auto
auto state waiting
event ontriggerenter(objectreference akactionref)
endevent
endstate
state fogged
event onbeginstate()
endevent
endstate
state reset
event ontriggerleave(objectreference akactionref)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1