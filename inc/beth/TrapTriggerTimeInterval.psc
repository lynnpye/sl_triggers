scriptname traptriggertimeinterval extends traptriggerbase
float property initialdelay = 0.1 auto
float property initialdelayrange = 0.1 auto
float property triggerinterval = 15.0 auto
float property triggerintervalrange = 3.0 auto
bool property isloaded = false auto hidden
cell property myparentcell auto hidden
auto state timedfirestate
event oncellattach()
endevent
event oncelldetach()
endevent
event onupdate()
endevent
endstate
event oncellattach()
endevent
event oncelldetach()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1