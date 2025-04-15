scriptname fxreadelderscrollscript extends objectreference  
effectshader property fxalduintimefadefxs auto
imagespacemodifier property fxreadscrollimod auto
imagespacemodifier property fxtimetravelimodstatic auto
imagespacemodifier property fxreadscrollsblindimod auto
imagespacemodifier property ismdwhiteout200 auto
visualeffect property fxreadelderscrolleffect auto
visualeffect property fxtimetravelcamattacheffect auto
explosion property fxalduintimewarpexplosion auto
objectreference property ancientalduinreference auto
activator property fxancienttimewound auto
auto state waiting
event onactivate(objectreference akactionref)
endevent
endstate
state timetravel
event onactivate(objectreference akactionref)
endevent
endstate
state alduintimejump
event onactivate(objectreference akactionref)
endevent
endstate
state timetravelcleanup
event onactivate(objectreference akactionref)
endevent
endstate
state wait
event onbeginstate()
endevent
endstate
state temploop
event onbeginstate()
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1