scriptname dlc2dunfloorpathpuzzlescript extends objectreference hidden 
sound property floorappearsound auto
sound property floorhidesound auto
keyword property linkcustom01 auto
keyword property linkcustom02 auto
keyword property linkcustom03 auto
float property timetoactivatenextblock = 1.0 auto
float property timetodisableself = 2.0 auto
float property timetoresetactivation = 4.0 auto
auto state waitingtobeactivated
event onactivate(objectreference akactionref)
endevent
endstate
state busy
event onactivate(objectreference akactionref)
endevent
endstate
state done
endstate
;This file was cleaned with PapyrusSourceHeadliner 1