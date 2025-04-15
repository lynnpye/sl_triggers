scriptname festivalendscript extends objectreference
quest property ms05kingolafsfestival auto
int property stage = 200 auto
float property minbreakdowntimer = 15.0 auto
auto state waiting
endstate
state listening
event onbeginstate()
endevent
event oncellattach()
endevent
event oncelldetach()
endevent
endstate
state done
endstate
event onupdate()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1