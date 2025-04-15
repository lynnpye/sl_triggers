scriptname mg03questscript extends quest  conditional
int property mg03orthornfree  auto  conditional
int property mg03callerinit auto conditional
int property mg03orthorncaller  auto  conditional
int property mg03callerfactionswap  auto  conditional
int property mg03callerpermission  auto  conditional
int property mg03guardscenerun auto conditional
function vcount()
endfunction
function bossfight()
endfunction
event onupdate()
endevent
referencealias property mg03caller  auto  
faction property mg03callerhostilefaction  auto  
scene property guardscene  auto  
globalvariable property mg03booksfound  auto  
globalvariable property mg03bookstotal  auto
globalvariable property favorrewardsmall  auto  
int property mg03orthornintro  auto  conditional
int property endscenedone  auto  conditional
int property orthornfg  auto  conditional
int property orthornreject  auto  conditional
int property faraldagreet  auto  conditional
int property mg03ancanoconvo  auto  conditional
;This file was cleaned with PapyrusSourceHeadliner 1