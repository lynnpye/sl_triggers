scriptname dlc1_bf_wavecontrollerscript extends objectreference hidden 
keyword property linkcustom01 auto
keyword property linkcustom02 auto
keyword property linkcustom03 auto
keyword property linkcustom04 auto
keyword property linkcustom05 auto
keyword property linkcustom06 auto
keyword property linkcustom07 auto
keyword property linkcustom08 auto
objectreference property prince auto
idle property princecast auto
quest property myquest auto
int property myqueststage auto
int property additionaldeathsrequired = 0 auto
int property minusdeathsrequired = 0 auto
faction property playerfaction auto
faction property factiontoaddto auto
bool property removefromfactiononspawn = false auto
float property spawntimemin = 0.3 auto
float property spawntimemax = 1.0 auto
int property currentdead auto hidden
int property maxdead auto hidden
float property delaybeforesettingstage = 1.0 auto
float property delaybeforespawningnextwave = 0.0 auto
bool property nextwaveinstant = false auto
bool property shouldstartcombatwithplayer = true auto
function trytoenableactors()
endfunction
function enablingactor(objectreference aklink)
endfunction
function trytosetupactors()
endfunction
function setupactors(objectreference aklink)
endfunction
event onactivate(objectreference akactionref)
endevent
function activateactors(objectreference aklink)
endfunction
function countdead()
endfunction
objectreference property hiddenmarker  auto  
;This file was cleaned with PapyrusSourceHeadliner 1