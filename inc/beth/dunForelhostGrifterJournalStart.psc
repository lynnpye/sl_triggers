scriptname dunforelhostgrifterjournalstart extends referencealias
scene property myscene auto
objectreference property myjournal auto
auto state waitingforitem
event onitemadded(form akbaseitem, int aiitemcount, objectreference akitemreference, objectreference aksourcecontainer)
endevent
endstate
state donothing
endstate
event oninit()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1