scriptname mq103questscript extends quest  conditional
location property korvanjundlocation  auto  
quest property cw03 auto
globalvariable property exteriordefendertotal auto  
globalvariable property exteriordefenderdeadcount auto  
function incrementdefenderdeadcount(actor deaddefender)
endfunction
globalvariable property draugrtotal auto  
globalvariable property draugrdeadcount auto  
function incrementdraugrdeadcount(actor deaddefender)
endfunction
scene property exteriorattack  auto  
scene property interiorattack  auto  
scene property interiorattack02  auto  
objectreference property lockeddoor01  auto  
referencealias property leader auto  
referencealias property friendly01 auto
referencealias property friendly02 auto
objectreference property leadergatemoveto  auto  
objectreference property friendly01gatemoveto  auto  
objectreference property friendly02gatemoveto  auto  
location property hqcitylocation  auto  
objectreference property korvanjundmapmarker  auto  
scene property mq103ainteriorattack03  auto  
int property draugrcount  auto  conditional
int property draugrobjamount  auto  conditional
scene property mq103abookroom  auto  
objectreference property respawnpoint  auto  
objectreference property respawnmoveto10  auto  
objectreference property respawnmoveto20  auto  
objectreference property respawnmoveto30  auto  
objectreference property respawnmoveto40  auto  
objectreference property respawnmoveto50  auto  
weapon property warhammer  auto  
scene property exteriorintro  auto  
quest property cw01solitudemaptablescene auto
faction property dunprisonerfaction  auto  
faction property cwbuddies  auto  
cwscript property cws  auto  
quest property mq102a  auto  
quest property mq102b  auto  
;This file was cleaned with PapyrusSourceHeadliner 1