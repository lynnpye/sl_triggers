scriptname wicommenttriggerscript extends objectreference  
keyword property commentkeyword  auto  
faction property followerfaction  auto  
package property followerpackage  auto  
objectreference property mylink auto hidden
auto state waitingtotrigger
event ontriggerenter(objectreference triggerref)
endevent
endstate
state hasbeentriggered
endstate
;This file was cleaned with PapyrusSourceHeadliner 1