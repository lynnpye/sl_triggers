scriptname ccbgssse001_fishtankcontainerscript extends objectreference
formlist property placeablefishlist auto
formlist property placeablefishactivatorlist auto
formlist property hostilefishlist auto
keyword property ccbgssse001_fishtankmarkerkw01 auto
keyword property ccbgssse001_fishtankmarkerkw02 auto
keyword property ccbgssse001_fishtankmarkerkw03 auto
message property fishtankfirsttimemsg auto
message property notallowedfishmsg auto
message property ccbgssse001_fishtanknomoreroommsg auto
message property ccbgssse001_fishtankhostilefishmsg auto
message property ccbgssse001_fishtankroomleftmsg auto
globalvariable property fishtankactivated auto
int property maxfishallowed = 3 autoreadonly
event onactivate(objectreference akactionref)
endevent
event onitemremoved(form akbaseitem, int aiitemcount, objectreference akitemreference, objectreference akdestcontainer)
endevent
event onitemadded(form akbaseitem, int aiitemcount, objectreference akitemreference, objectreference aksourcecontainer)
endevent
event onload()
endevent
function updatefish()
endfunction
ccbgssse001_fishtankcritterscript function updatesinglefish(form targetfish, ccbgssse001_fishtankcritterscript placedfishref, objectreference targetmarker)
endfunction
state updatingfish
function updatefish()
endfunction
endstate
function addfish(form akfish, int fishcount)
endfunction
function removefish(form akfish, int fishcount)
endfunction
function makefishpanic()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1