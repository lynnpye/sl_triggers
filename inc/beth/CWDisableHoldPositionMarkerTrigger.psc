scriptname cwdisableholdpositionmarkertrigger extends objectreference  
cwscript property cws auto
objectreference property holdposmarker1 auto
objectreference property holdposmarker2 auto
objectreference property holdposmarker3 auto
objectreference property holdposmarker4 auto
objectreference property holdposmarker5 auto
event onload()
endevent
event ontriggerenter(objectreference akactionref)
endevent
function disableifset(objectreference objecttodisable, actor triggeringactor)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1