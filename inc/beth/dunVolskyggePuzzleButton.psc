scriptname dunvolskyggepuzzlebutton extends objectreference
objectreference property button01 auto
objectreference property button02 auto
objectreference property button03 auto
objectreference property myenablemarker auto
objectreference property mysoundmarker auto
int property buttonnumber auto
event onreset()
endevent
event oncellload()
endevent
auto state waiting
event onactivate (objectreference triggerref)
endevent
endstate
state busy
event onactivate (objectreference triggerref)
endevent
endstate
state done
event onactivate (objectreference triggerref)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1