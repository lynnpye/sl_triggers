scriptname spiritwolfscript extends actor
idle property pa_extractwerewolfspirit auto
visualeffect property werewolfextractvfx auto
effectshader property ghostshader auto
sound property qstwolfchest auto
bool property donewithextraction = false auto
function extract(actor extractionpartner)
endfunction
event ondying(actor akkiller)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1