scriptname  lumbermill01 extends objectreference
objectreference property log auto
objectreference property sash auto
objectreference property saw auto
event oninit()
endevent
auto state normal
event onactivate ( objectreference triggerref )
endevent
endstate
state sabotage
event onactivate ( objectreference triggerref )
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1