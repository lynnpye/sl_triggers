scriptname rpdefault_teleportonactivate extends objectreference
bool property bplayeronly = true auto
objectreference property teleporttotarget auto
event onactivate(objectreference akactivatedby)
endevent
state handlingactivation
event onactivate(objectreference akactivatedby)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1