scriptname zad_effinflatableplugsanalscript extends activemagiceffect
zadlibs property libs auto
keyword property locsetcave auto
keyword property loctypebanditcamp auto
keyword property loctypecity auto
keyword property loctypedragonpriestlair auto
keyword property loctypedraugrcrypt auto
keyword property loctypedungeon auto
keyword property loctypedwarvenautomatons auto
keyword property loctypedwelling auto
keyword property loctypefalmerhive auto
keyword property loctypehabitation auto
keyword property loctypehold auto
keyword property loctypeinn auto
keyword property loctypejail auto
keyword property loctypemilitaryfort auto
keyword property loctypemine auto
keyword property loctypetown auto
keyword property loctypevampirelair auto
bool property terminate auto hidden
keyword property loctypeplayerhome auto
actor property target auto hidden
function doregister()
endfunction
function dostart()
endfunction
function dounregister()
endfunction
bool function isinhomeorjail()
endfunction
bool function isincity()
endfunction
bool function isinhold()
endfunction
event onupdate()
endevent
event oneffectstart(actor aktarget, actor akcaster)
endevent
event oneffectfinish(actor aktarget, actor akcaster)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1