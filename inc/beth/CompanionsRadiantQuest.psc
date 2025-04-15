scriptname companionsradiantquest extends quest conditional
quest property parentquest auto
referencealias property questgiver auto
referencealias property mapmarker auto
bool property isregistered = false auto
bool property questgivercomesalong = false auto conditional
bool property isactive = false auto conditional
bool property isaccepted = false auto conditional
bool property wasrejected = false auto conditional
int  property rewardamount = 100 auto
bool property succeeded = false auto
bool property premature = false auto
function setup()
endfunction
function accepted()
endfunction
function rejected()
endfunction
function finished(bool _succeeded = true, bool _finished = true)
endfunction
function cleanup()
endfunction
function prematureshutdown()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1