scriptname dlc2wordwalltriggerscript extends objectreference
bool property wordlearned auto hidden
objectreference property looktarget auto hidden
wordofpower property myword auto hidden
objectreference property wordsound auto hidden
objectreference property wordwall auto hidden
globalvariable property shoutglobal auto
imagespacemodifier property imodloop02 auto
imagespacemodifier property imodloop03 auto
objectreference property wordwall01 auto
objectreference property wordwall02 auto
objectreference property wordwall03 auto
imagespacemodifier property wordimodwordlearned auto
wordofpower property myword01 auto
wordofpower property myword02 auto
wordofpower property myword03 auto
objectreference property looktargetword01 auto
objectreference property looktargetword02 auto
objectreference property looktargetword03 auto
quest property myquest auto
int property mystage auto
objectreference property word01sound auto
objectreference property word02sound auto
objectreference property word03sound auto
objectreference property soundwallwhisper auto
objectreference property myenabler auto
int property innerradius = 300 auto
int property middleradius = 700 auto
int property outerradius = 1200 auto
objectreference property mylocrefmarker auto
wordwalllistenerquestscript property wicastmagic04 auto
wordwalllistenerquestscript property freeformhighhrothgara auto
bool function islooking()
endfunction
function startfx()
endfunction
function stopfx()
endfunction
function startwordwall()
endfunction
function stopwordwall()
endfunction
state updating
event onupdate()
endevent
endstate
state done
function startwordwall()
endfunction
endstate
event onupdate()
endevent
function pokewordwalllistenerquests()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1