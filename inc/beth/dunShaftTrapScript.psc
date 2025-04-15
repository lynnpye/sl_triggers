scriptname dunshafttrapscript extends objectreference
objectreference property myfx auto
objectreference property mysoundloop auto
objectreference property myfxlight auto
objectreference property myfxstartmarker01 auto
objectreference property myfxactivator auto
objectreference property mysounddoppler auto
objectreference property mysoundspin auto
bool property intrigger = false auto hidden
bool property inprogress = false auto hidden
event onload()
endevent
event onupdate()
endevent
auto state waiting
event ontriggerenter(objectreference triggerref)
endevent
event ontriggerleave(objectreference triggerref)
endevent
endstate
state done
event onactivate (objectreference triggerref)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1