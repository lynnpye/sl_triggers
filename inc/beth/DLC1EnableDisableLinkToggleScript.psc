scriptname dlc1enabledisablelinktogglescript extends objectreference
bool property playeronly = true auto
int property enabledisabletoggle = 0 auto
function handleonenteronleave(int inum, bool benteredtrigger)
endfunction
event ontriggerenter(objectreference akactionref)
endevent
event ontriggerleave(objectreference akactionref)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1