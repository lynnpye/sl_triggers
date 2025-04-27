scriptname zadribbedeffect extends activemagiceffect
bool property actorincombat auto
bool property actorismounted auto
bool property actorissprinting auto
int property jumpkey auto
zadlibs property libs auto
int[] property movementkeys auto
int property numkeysmonitored auto
sexlabframework property sexlab auto
int property sneakkey auto
int property sprintkey auto
actor property target auto
int function registerkey(string keyname)
endfunction
function clearkeys()
endfunction
function applyeffect()
endfunction
event oneffectstart(actor aktarget, actor akcaster)
endevent
event oneffectfinish(actor aktarget, actor akcaster)
endevent
event oncellattach()
endevent
function updatecachedstates()
endfunction
bool function isconflictingmenuopen()
endfunction
bool function shouldprocessinput()
endfunction
function onactoraction(int actiontype, actor akactor, form source, int slot)
endfunction
function processinput(int keycode, bool keydown, float holdtime)
endfunction
function onkeydown(int keycode)
endfunction
function onkeyup(int keycode, float holdtime)
endfunction
function starteffect(int strength, int duration)
endfunction
function stopeffect()
endfunction
function onjump()
endfunction
function onsneak()
endfunction
function onmeleeswing()
endfunction
function onbowrelease()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1