scriptname magicsoundplayintrooutro extends activemagiceffect
sound property introsoundfx auto ; create a sound property we'll point to in the editor
sound property outrosoundfx auto ; create a sound property we'll point to in the editor
event oneffectstart(actor target, actor caster)
endevent
event oneffectfinish(actor target, actor caster)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1