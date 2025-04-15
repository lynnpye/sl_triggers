scriptname defaultdisableselfonload extends objectreference  
quest property myquest  auto  
int property disablestage  auto  
bool property bstagemustbedone = false auto  
auto state waiting
event onload()
endevent
endstate
state done
endstate
;This file was cleaned with PapyrusSourceHeadliner 1