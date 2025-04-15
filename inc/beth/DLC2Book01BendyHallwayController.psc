scriptname dlc2book01bendyhallwaycontroller extends objectreference
bool property bending = false auto hidden
int property startingposition = 0 auto
int property currentposition auto hidden
int property previousposition auto hidden
function bend(int mybend)
endfunction
event oncellattach()
endevent
function gotostartingposition()
endfunction
function returntostartingposition()
endfunction
function returntolastposition()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1