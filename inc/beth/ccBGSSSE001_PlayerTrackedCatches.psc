scriptname ccbgssse001_playertrackedcatches extends referencealias  
referencealias[] property trackeditemaliases auto
int[] property trackeditemcaughtstages auto
globalvariable property trackeditemscaughtcountglobal auto
globalvariable property trackeditemscaughttotalglobal auto
globalvariable property alltrackeditemscaughtglobal auto
int property trackeditemobjective auto
int property alltrackeditemscaughtstage = -1 auto
quest property myquest auto
event oninit()
endevent
auto state ready
event onitemadded(form akbaseitem, int aiitemcount, objectreference akitemreference, objectreference aksourcecontainer)
endevent
endstate
function giveplayeraliasquestitem(form trackeditem, referencealias trackeditemalias)
endfunction
form function gettrackeditem()
endfunction
state working
event onitemadded(form akbaseitem, int aiitemcount, objectreference akitemreference, objectreference aksourcecontainer)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1