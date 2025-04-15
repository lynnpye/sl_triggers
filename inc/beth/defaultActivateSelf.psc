scriptname defaultactivateself extends objectreference
bool property doonce = true auto
bool property disablewhendone = false auto
bool property playeronly = true auto
bool property playerandalliesonly = false auto
int property minlevel auto
faction property playerfaction auto
faction property currentfollowerfaction auto
package property follow auto
package property followerpackagetemplate auto
auto state waiting
event ontriggerenter(objectreference triggerref)
endevent
endstate
bool function isplayerally(objectreference triggerobj)
endfunction
state alldone
endstate
;This file was cleaned with PapyrusSourceHeadliner 1