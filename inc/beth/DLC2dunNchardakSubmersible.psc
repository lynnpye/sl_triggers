scriptname dlc2dunnchardaksubmersible extends objectreference
quest property dlc2dunnchardaktracking auto  ;nchardak tracking quest.
bool property isactuallysubmersible = true auto ;is this particular reference actually submersible (will water cover it?). if not, don't bother with anything else.
objectreference property mywaterplane auto   ;which water plane this object can be submerged by.
bool property usestagedwaterheight = true auto  ;should we use 'staged' water heights, instead of relying on the object's acutal height to determine if it's accessible? much safer.
bool property failsafedontsubmerge = false auto ;if true, don't clear this object's name when it becomes submerged. used as a failsafe to keep cubes-in-pedestals from becoming inaccessible.
int property mywaterstage auto      ;if we are using staged heights, and the water plane is at this stage or higher, the object is considered submerged and becomes unusable.
int property myindex = -1  auto hidden   ;internal: this object's index in the nchardak tracking quest's array of submersible objects.
bool property issubmerged = false auto hidden ;internal: is this object presently submerged?
event oncellattach()
endevent
function checksubmerged()
endfunction
function submerge()
endfunction
function unsubmerge()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1