scriptname defaultfakesummonspell extends actor
activator property summonfx auto
activator property banishfx auto
bool property summoned = false auto
auto state waiting
event onactivate(objectreference or)
endevent
endstate
state done
event onactivate(objectreference or)
endevent
endstate
event summon()
endevent
event banish()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1