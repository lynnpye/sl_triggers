scriptname dlc1vq04bloodbowlscript extends objectreference
quest property dlc1vq04 auto
int property stage auto
miscobject property dlc1vq04ingredbonemeal auto
miscobject property dlc1vq04ingredvoidsalt auto
miscobject property dlc1vq04ingredsoulgemshard auto
bool property bonemealplaced auto hidden
bool property voidsaltsplaced auto hidden
bool property soulgemsplaced auto hidden
objectreference property dlc1vq04bloodbowlfurniture auto
auto state waiting
event onactivate(objectreference activateref)
endevent
endstate
state busy
endstate
function processingredients()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1