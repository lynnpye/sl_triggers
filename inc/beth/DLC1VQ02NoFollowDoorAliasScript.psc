scriptname dlc1vq02nofollowdooraliasscript extends referencealias  
bool property blockwerewolves = false auto
quest property playerwerewolfquest auto
magiceffect property werewolfchangeeffect auto
bool property ismaindoor = false auto
auto state waiting
event onactivate(objectreference akactionref)
endevent
endstate
state busy
endstate
faction property allowdoorfaction01  auto  
faction property allowdoorfaction02  auto  
faction property allowdoorfaction03  auto 
quest property myquest auto
int property myqueststage auto 
message property followerblockedmessage auto 
int property doonce auto
;This file was cleaned with PapyrusSourceHeadliner 1