scriptname dlc2rieklingbarrelscript extends objectreference  
explosion property fallingdustexplosion01 auto 
float property rumbleamount1 = 0.2 auto
float property rumbleduration = 0.7 auto
float property camerashakeamount1 = 0.2 auto
keyword property mylink auto
event onreset()
endevent
event onactivate(objectreference activateref)
endevent
function triggerexplosion(objectreference explosioncauseref)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1