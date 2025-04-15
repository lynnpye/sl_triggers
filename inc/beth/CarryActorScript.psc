scriptname carryactorscript extends objectreference  
miscobject property carryitemmisc  auto  
int property carryitemmisccount = 1 auto
potion property carryitempotion  auto  
int property carryitempotioncount = 1 auto
ingredient property carryitemingredient  auto  
int property carryitemingredientcount = 1 auto
idle property stopcarryingevent  auto  
function changecarrystate(bool bbegincarrying, bool bdropitem = false)
endfunction
event oncombatstatechanged(actor aktarget, int aecombatstate)
endevent
function addcarrieditems()
endfunction
function removecarrieditems(bool bdrop = false)
endfunction
function dropcarrieditems(form itemtodrop, int idropcount)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1