scriptname dlc2explodingspidereggscript extends objectreference hidden 
actorbase property spidetospawn auto
explosion property myexplosion auto
faction property dlc2expspiderenemyfaction auto
int property amounttospawn = 1 auto
event onload()
endevent
auto state waitingtoexplode
event ontriggerenter(objectreference akactionref)
endevent
event ontriggerleave(objectreference akactionref)
endevent
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
endstate
state done
event onbeginstate()
endevent
endstate
function watchplayer()
endfunction
function explodeegg()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1