scriptname dunustenpuztrigscript extends objectreference
keyword property linkcustom01 auto
keyword property linkcustom02 auto
bool property isloaded auto hidden
bool property activatedbylever auto hidden
objectreference property dragonstone01 auto hidden
objectreference property dragonstonelight01 auto hidden
quest property dunustengravqst auto
event onload()
endevent
auto state waiting   ;waiting to be triggered
event ontriggerenter(objectreference triggerref)
endevent
event onactivate(objectreference triggerref)
endevent
endstate
state triggered   ;was triggered
event ontriggerleave(objectreference triggerref)
endevent
event onbeginstate()
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1