scriptname sprigganswarmactorscript extends activemagiceffect conditional
visualeffect property sprigganswarmfxattacheffect auto
objectreference property mysprigganswarm auto conditional hidden
actorbase property sprigganswarmbase auto
event oneffectstart(actor target, actor caster)
endevent
event ondeath(actor mykiller)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1