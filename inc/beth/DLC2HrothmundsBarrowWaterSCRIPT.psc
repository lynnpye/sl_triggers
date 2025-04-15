scriptname dlc2hrothmundsbarrowwaterscript extends objectreference hidden 
sound property qstustengravrumble2dlpm auto
objectreference property waterupper auto
objectreference property waterlower auto
objectreference property waterdynamic auto
objectreference property lightmarker01 auto
objectreference property lightmarker02 auto
objectreference property lightmarker03 auto
objectreference property lightmarker04 auto
objectreference property waterfallring01 auto
objectreference property waterfallring02 auto
objectreference property waterfallring03 auto
objectreference property waterfallring04 auto
objectreference property waterfallringstart01 auto
objectreference property waterfallringstart02 auto
objectreference property waterfallringstart03 auto
objectreference property waterfallringstart04 auto
objectreference property waterfallringend01 auto
objectreference property waterfallringend02 auto
objectreference property waterfallringend03 auto
objectreference property waterfallringend04 auto
objectreference property waterfallmarker01 auto
bool property bmovewaterdown = true auto
bool property bcurrentlymoving = false auto hidden
bool property bcurrentlyup = true auto hidden
bool property bstopmovingwaterup = false auto
event onactivate(objectreference akactionref)
endevent
function movewater()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1