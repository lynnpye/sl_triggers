scriptname adv_sleeputils extends quest  
actor property playerref auto
imagespacemodifier property sleepytimefadein auto
idle property woozygetup auto
objectreference property marker auto
globalvariable property gamehour auto
float property desiredsleeptime auto hidden
function maintenance()
endfunction
adv_sleeputils function get() global
endfunction
event onsleepstart(float afsleepstarttime, float afdesiredsleependtime)
endevent
event onsleepstop(bool abinterrupted)
endevent
function wakeup()
endfunction
function woozyeffect(bool abwoozy = true, bool abwakeup = true)
endfunction
bool function registerinterrupt(string askey, float afdelta)
endfunction
bool function removeinterrupt(string askey)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1