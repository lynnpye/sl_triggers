scriptname favordialoguescript extends quest  conditional
globalvariable property gamedayspassed  auto  
globalvariable property intimidatebribedelaydays  auto  
globalvariable property flatterdelaydays  auto  
globalvariable property bribereward  auto  
globalvariable property flatterreward  auto  
globalvariable property intimidatereward  auto  
globalvariable property intimidatecost  auto  
miscobject property gold auto
keyword property brawlkeyword  auto  
companionsradiantquest property cr04 auto
referencealias property ms10stig auto
float property skillusepersuade auto  conditional
float property skillusebribe auto  conditional
float property skilluseintimidate auto  conditional
float property skillusemultiplier auto conditional
float property skillusegivegiftmult = 1.0  auto  conditional
globalvariable property speechskillmult  auto  
function persuade(actor ptarget)
endfunction
function arrestpersuade(actor ptarget)
endfunction
function bribe(actor ptarget)
endfunction
function intimidate(actor ptarget)
endfunction
function brawl(actor ptarget, actor ptargetfriend = none)
endfunction
function givegift(actor ptarget)
endfunction
quest property dgintimidatequest  auto  
;This file was cleaned with PapyrusSourceHeadliner 1