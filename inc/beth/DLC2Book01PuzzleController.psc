scriptname dlc2book01puzzlecontroller extends objectreference
bool property book1placed = false auto hidden
bool property book2placed = false auto hidden
bool property book3placed = false auto hidden
bool property book4placed = false auto hidden
objectreference property dlc2book01puzzleactivatorref001 auto
objectreference property dlc2book01puzzleactivatorref002 auto
objectreference property dlc2book01puzzleactivatorref003 auto
objectreference property dlc2book01puzzleactivatorref004 auto
objectreference property dlc2book01inttoend auto
dlc2book01puzzleactivator property book1 auto hidden
dlc2book01puzzleactivator property book2 auto hidden
dlc2book01puzzleactivator property book3 auto hidden
dlc2book01puzzleactivator property book4 auto hidden
objectreference property dlc2mqpuzzlestandtentaclesref auto
objectreference property dlc2mqpuzzlestandclawsref auto
objectreference property dlc2mqpuzzlestandteethref auto
objectreference property dlc2mqpuzzlestandeyesref auto
objectreference property dlc2mq06puzzlestatueref auto
bool property booksregistered = false auto hidden
visualeffect property trailfx auto
visualeffect property trailfx02 auto
float property fdelay = 10.0 auto hidden
quest property dlc2book01puzzleqst auto
auto state waiting
endstate
state done
event onbeginstate()
endevent
function bookplaced(int booknumber)
endfunction
function bookremoved(int booknumber)
endfunction
endstate
function bookplaced(int booknumber)
endfunction
function bookremoved(int booknumber)
endfunction
function checkforpuzzlecompletion()
endfunction
function registerbooks()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1