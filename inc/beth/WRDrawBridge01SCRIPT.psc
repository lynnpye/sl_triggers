scriptname wrdrawbridge01script extends objectreference  
keyword property linkcustom01 auto
keyword property linkcustom02 auto
objectreference property drawbridge auto hidden
objectreference property collision auto hidden
objectreference property partnerlever auto hidden
quest property cwsiege auto
event onload()
endevent
function lowerdrawbridge()
endfunction
function raisedrawbridge()
endfunction
state readyforclose
event onactivate(objectreference triggerref)
endevent
endstate
auto state readyforopen
event onactivate(objectreference triggerref)
endevent
endstate
state done
event onbeginstate()
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1