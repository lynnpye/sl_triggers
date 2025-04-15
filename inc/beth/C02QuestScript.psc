scriptname c02questscript extends companionsstoryquest conditional
referencealias property previousquestbuddylocal auto
referencealias property questgiver auto
referencealias property kodlak auto
referencealias property aela auto
referencealias property skjor auto
referencealias property farkas auto
referencealias property vilkas auto
objectreference property aelastart auto
objectreference property skjorstart auto
objectreference property farkasstart auto
objectreference property vilkasstart auto
objectreference property kodlakstart auto
objectreference property observerwaitpoint auto
quest property c02postquest auto
objectreference property c02kickertrigger auto
scene property ceremony auto
bool property playertalkedtoquestgiver auto conditional
bool property playerenteredceremonyroom auto conditional
bool property kodlakpresentedconflict auto conditional
bool function oktomovequestionmark(actor check)
endfunction
function init()
endfunction
function teardown()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1