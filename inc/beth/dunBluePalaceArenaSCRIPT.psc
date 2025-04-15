scriptname dunbluepalacearenascript extends objectreference  
objectreference property playerthrallstorm auto
objectreference property playerthrallfrost auto
objectreference property playerthrallfire auto
objectreference property pelagiusarena auto
objectreference property pelagiusthrallstorm auto
objectreference property pelagiusthrallfrost auto
objectreference property pelagiusthrallfire auto
objectreference property bodyguarda auto
objectreference property bodyguardawolf auto
objectreference property bodyguardb auto
objectreference property bodyguardbwolf auto
spell property healspell auto
int property pelagiusactive=0 auto hidden
int property playeractive=0 auto hidden
objectreference property activeatr auto hidden
event ontriggerenter(objectreference obj)
endevent
state polling
event onupdate()
endevent
endstate
function combatantheal()
endfunction
bool function gethealthperc()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1