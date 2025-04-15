scriptname caravanleaderscript extends referencealias  conditional
int property caravannumber auto
referencealias property leader  auto
referencealias property follower1  auto
referencealias property follower2 auto
referencealias property follower3 auto
referencealias property follower4 auto
event onupdategametime()
endevent
event ondeath(actor akkiller)
endevent 
function promote(referencealias aliastofill, objectreference reftofillwith)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1