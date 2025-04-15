scriptname mgrappb01spelleffectscript extends activemagiceffect  conditional
float property fdelay auto
imagespacemodifier property introfx auto
imagespacemodifier property mainfx auto
imagespacemodifier property outrofx auto
sound property introsoundfx auto ; create a sound property we'll point to in the editor
sound property outrosoundfx auto ; create a sound property we'll point to in the editor
quest property mgrappbrelyna01 auto
event oneffectstart(actor target, actor caster)
endevent
event oneffectfinish(actor target, actor caster)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1