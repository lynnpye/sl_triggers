scriptname cwsiegewhiteruncitydoorscript extends objectreference hidden 
quest property cwsiegewhiterunattackqst auto
quest property cwattackcity auto ;this is the quest that puts everyone in their houses handles getting the jarl to surrender, etc.
message property cwdoormessage auto  ;pointer to message to show when activating the door (whiterun = cwsiegewhiterundoormsg)
event onactivate (objectreference triggerref)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1