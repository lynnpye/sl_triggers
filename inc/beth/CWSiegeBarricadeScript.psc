scriptname cwsiegebarricadescript extends referencealias  
globalvariable property cwpathclear1 auto
globalvariable property cwpathclear2 auto
globalvariable property cwpathclear3 auto
bool property setpathclear1 auto
bool property setpathclear2 auto
bool property setpathclear3 auto
int property oldstage = 3 auto
int property newstage = 4 auto
int property stagetosetwhendestroyed auto
event ondestructionstagechanged(int aioldstage, int aicurrentstage)
endevent
function clearglobals()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1