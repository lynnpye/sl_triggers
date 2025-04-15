scriptname dragondeathscript extends actor  
event ondeath(actor akkiller)
endevent
state waiting
event onupdate()
endevent
endstate
state done
endstate
int property triggerdistance = 1000 auto
quest property mqkilldragon auto
;This file was cleaned with PapyrusSourceHeadliner 1