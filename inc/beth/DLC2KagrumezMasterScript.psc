scriptname dlc2kagrumezmasterscript extends objectreference  
globalvariable property fightcountglobal auto
referencealias property kagrumezgem01 auto
referencealias property kagrumezgem02 auto
referencealias property kagrumezgem03 auto
referencealias property kagrumezgem04 auto
referencealias property kagrumezgem05 auto
quest property dlc2kagrumezqst auto
location property kagrumezlocation auto
objectreference property console auto
objectreference property fight1platforml auto
objectreference property fight1platformr auto
objectreference property fight2wallactivator auto
objectreference property fight2trapdisabler auto
objectreference property fight3water auto
objectreference property fight3platforms auto
objectreference property fight3sparkstrigger auto
sound property stonewallfast auto
sound property stonewallslowloop auto
sound property waterrisedrainloop auto
objectreference property watersoundmarker01 auto
objectreference property watersoundmarker02 auto
objectreference property collisionenablerexitgates auto 
objectreference property collisionenablerfight02 auto 
objectreference property collisionenablerfight03 auto 
objectreference property encounterenablemarkerfight01 auto 
objectreference property encounterenablemarkerfight02 auto 
objectreference property encounterenablemarkerfight03 auto 
objectreference property ambushtriggerfight01 auto 
objectreference property ambushtriggerfight02 auto 
objectreference property ambushtriggerfight03 auto 
objectreference property lightenablerfight01 auto 
objectreference property lightenablerfight02 auto 
objectreference property lightenablerfight03 auto 
objectreference property gate01 auto
objectreference property gate02 auto
objectreference property gate03 auto
objectreference property exitgate01 auto
objectreference property exitgate02 auto
objectreference property prizegate01 auto
objectreference property prizegate02 auto
objectreference property prizegate03 auto
objectreference property gem01 auto 
objectreference property gem02 auto 
objectreference property gem03 auto 
objectreference property gem04 auto 
objectreference property gem05 auto 
objectreference property gem06 auto 
objectreference property gem07 auto 
objectreference property gem08 auto 
objectreference property gem09 auto 
bool property fight1done = false auto hidden
bool property fight2done = false auto hidden
bool property fight3done = false auto hidden
int property enemieskilled = 0 auto hidden
function gemsgotofightstate()
endfunction
function gemsreset()     
endfunction
auto state default
event oncellattach()
endevent
event onactivate(objectreference actronaut)
endevent
endstate
state fight1
event onactivate(objectreference actronaut)
endevent
endstate
state fight2
event onactivate(objectreference actronaut)
endevent
endstate
state fight3
event onactivate(objectreference actronaut)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1