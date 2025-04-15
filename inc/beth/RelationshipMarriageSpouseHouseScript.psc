scriptname relationshipmarriagespousehousescript extends quest conditional
quest property byohrelationshipadoption auto
referencealias property solitudehouse  auto  
referencealias property windhelmhouse  auto  
referencealias property markarthhouse  auto  
referencealias property riftenhouse  auto  
referencealias property whiterunhouse  auto  
referencealias property falkreathhouse auto
referencealias property hjaalmarchhouse auto
referencealias property palehouse auto
referencealias property spousehouse auto
referencealias property cchouse01 auto
referencealias property cchouse02 auto
referencealias property cchouse03 auto
referencealias property cchouse04 auto
referencealias property cchouse05 auto
referencealias property cchouse06 auto
referencealias property cchouse07 auto
referencealias property cchouse08 auto
referencealias property cchouse09 auto
referencealias property cchouse10 auto
referencealias property cchouse11 auto
referencealias property cchouse12 auto
referencealias property cchouse13 auto
referencealias property cchouse14 auto
referencealias property cchouse15 auto
referencealias property cchouse16 auto
referencealias property cchouse17 auto
referencealias property cchouse18 auto
referencealias property cchouse19 auto
referencealias property cchouse20 auto
faction property jobblacksmithfaction auto
faction property jobspellfaction auto
faction property jobapothecaryfaction auto
faction property jobinnkeeperfaction auto
faction property jobmiscfaction auto
int property spousecurrenthome auto conditional hidden
function movespouseadoption (actor spouse, int newhouse)
endfunction
function movespouse (actor spouse, referencealias newhouse)
endfunction
function spouseshop (actor spouse)
endfunction
faction property jobmerchantfaction  auto  
int function translatehousealiastoint(referencealias newhouse)
endfunction
referencealias function translatehouseinttoalias(int newhouse)
endfunction
function updatespousehouseint()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1