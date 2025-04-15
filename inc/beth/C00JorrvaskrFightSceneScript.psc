scriptname c00jorrvaskrfightscenescript extends quest conditional
bool property fightprepped auto
bool property fightongoing auto conditional
bool property clockwise auto conditional
bool property playerendedfight auto conditional
int property startphase auto conditional
bool property endvolley auto conditional
bool property crowdscenesetup auto conditional
objectreference property centerpoint  auto  
objectreference property athisstartpoint  auto  
objectreference property njadastartpoint  auto  
objectreference property skjorstartpoint  auto  
objectreference property torvarstartpoint  auto  
objectreference property vignarstartpoint  auto  
objectreference property brillstartpoint  auto  
objectreference property tilmastartpoint  auto  
referencealias property athis  auto  
referencealias property njada  auto  
referencealias property skjor  auto  
referencealias property torvar  auto  
referencealias property vignar  auto  
referencealias property brill  auto  
referencealias property tilma  auto  
faction property govruling auto
bool property countingdown auto
weapon property unarmed auto
weapon property ironsword auto
function fightprep()
endfunction
function fightstart()
endfunction
function startvolley()
endfunction
function fightloop()
endfunction
function fightend()
endfunction
function fightfinish()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1