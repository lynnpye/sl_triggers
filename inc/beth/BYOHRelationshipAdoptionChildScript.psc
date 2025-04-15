scriptname byohrelationshipadoptionchildscript extends referencealias conditional
quest property byohrelationshipadoption auto
referencealias property currentchildschest auto ;link to the child's chest, as determined by the scheduler.
keyword property byohadoptionclotheskeyword auto ;keyword to identify children's clothes tokens.
keyword property byohadoptiontoykeyword auto  ;keyword to identify children's toys (dolls, etc.).
armor property clotheschild01 auto    ;armor forms for the childrens' outfits.
armor property clotheschild02 auto
armor property clotheschild03 auto
armor property clotheschild04 auto
armor property clotheschild05 auto
outfit property childoutfit01 auto  ;outfit forms for the childrens' outfits.
outfit property childoutfit02 auto
outfit property childoutfit03 auto
outfit property childoutfit04 auto
outfit property childoutfit05 auto
miscobject property clotheschild01male auto ;since children's clothes are non-playable, the system manipulates miscobject 'tokens' that represent them.
miscobject property clotheschild02male auto ;these are the tokens for the boy versions of the clothes.
miscobject property clotheschild03male auto
miscobject property clotheschild04male auto
miscobject property clotheschild05male auto
miscobject property clotheschild01female auto ;tokens for the girl versions of the clothes.
miscobject property clotheschild02female auto
miscobject property clotheschild03female auto
miscobject property clotheschild04female auto
miscobject property clotheschild05female auto
event onlocationchange(location oldloc, location newloc)
endevent
function issueorder(float order, float time)
endfunction
function issueplayorder(float order)
endfunction
event onupdategametime()
endevent
function setgiftstate(bool giftstate)
endfunction
event onitemadded(form item, int count, objectreference ref, objectreference source)
endevent
function removeoldclothes()
endfunction
function removeoldclothesifpresent(armor clothes, miscobject maletoken, miscobject femaletoken)
endfunction
function equipnewclothes()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1