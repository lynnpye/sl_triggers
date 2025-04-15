scriptname dlc2dunfrostmoontransformscript extends actor
spell property dlc2dunfrostmoonwerewolfchangefx auto
quest property dlc2dunfrostmoonqst auto
race property nordrace auto
bool property allowwerewolftransform = false auto
event oncombatstatechanged(actor aktarget, int combatstate)
endevent
event onraceswitchcomplete()
endevent
event oncellload()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1