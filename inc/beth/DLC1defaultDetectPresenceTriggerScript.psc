scriptname dlc1defaultdetectpresencetriggerscript extends objectreference conditional
bool property presencedetected auto conditional
referencealias property aliastosense auto
actor property actortosense auto
bool function __iswatched(objectreference akactivator)
endfunction
event ontriggerenter(objectreference akactivator)
endevent
event ontriggerleave(objectreference akactivator)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1