scriptname magicsetactoralphascript extends activemagiceffect
float property alphavalue = 1.0 auto
bool property fadetoalpha = false auto
bool property dontfadeback = false auto
event oneffectstart(actor target, actor caster)
endevent
event oneffectfinish(actor target, actor caster)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1