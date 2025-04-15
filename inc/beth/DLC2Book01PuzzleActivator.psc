scriptname dlc2book01puzzleactivator extends objectreference
objectreference property dlc2book01puzzlecontrollerref auto
dlc2book01puzzlecontroller property mycontroller auto hidden
message property dlc2book01puzzleactivatoremptymessage auto
message property dlc2book01puzzleactivatorbook1message auto
message property dlc2book01puzzleactivatorbook2message auto
message property dlc2book01puzzleactivatorbook3message auto
message property dlc2book01puzzleactivatorbook4message auto
int property correctbooknumber auto
int property booknumberplaced = 0 auto hidden
book property dlc2mq06puzzlebook01 auto
book property dlc2mq06puzzlebook02 auto
book property dlc2mq06puzzlebook03 auto
book property dlc2mq06puzzlebook04 auto
quest property dlc2book01puzzleqst auto
dlc2book01puzzlequestscript property questscript auto hidden
auto state waiting
event onactivate(objectreference akactivator)
endevent
endstate
state busy
endstate
state complete
event onbeginstate()
endevent
endstate
event onload()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1