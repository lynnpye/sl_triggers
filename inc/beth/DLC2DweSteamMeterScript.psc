scriptname dlc2dwesteammeterscript extends objectreference  
auto state off
function fillmeter()
endfunction
endstate
state on
function fillmeter()
endfunction
function emptymeter()
endfunction
endstate
state overload
function emptymeter()
endfunction
endstate
function fillmeter()
endfunction
function emptymeter()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1