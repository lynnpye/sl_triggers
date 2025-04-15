scriptname dunfrostmerecryptfakesummon extends actor
explosion property summonfx auto
explosion property banishfx auto
bool property summoned = false auto
bool property shouldfadeout = false auto
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