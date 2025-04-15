scriptname wispactorscript extends activemagiceffect  
keyword property wispchild01 auto
keyword property wispchild02 auto
keyword property wispchild03 auto
spell property wispbuff01 auto
spell property wispbuff02 auto
spell property wispbuff03 auto
spell property phase1concspell auto
spell property phase2concspell auto
actorbase property encwispshade auto
visualeffect property wispfxattacheffect auto
explosion property explosionillusionlight01 auto
activator property ashpileobject auto
float property phasethreehppercent auto
event onload()
endevent
event oneffectstart(actor target, actor caster)
endevent
event ongetup(objectreference akfurniture)
endevent
event oncombatstatechanged(actor victim, int aecombatstate)
endevent
event onactivate(objectreference actronaut)
endevent
event onupdate()
endevent
event ondying(actor akkiller)
endevent
function evpall()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1