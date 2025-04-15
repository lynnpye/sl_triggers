scriptname c06ysgramorstatuescript extends objectreference  
weapon property bladeofysgramor auto
objectreference property bladeinstance auto
quest property c06 auto
objectreference property tombdoor auto
auto state noblade
event onbeginstate()
endevent
event onactivate(objectreference akactivator)
endevent
endstate
state blade
event onbeginstate()
endevent
event onactivate(objectreference akactivator)
endevent
endstate
state done
event onbeginstate()
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1