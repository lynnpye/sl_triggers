scriptname dlc2tribalwerebearscript extends actor  
spell property werebearchange auto
int property transformdistance = 500 auto
function transform()
endfunction
auto state human
function transform()
endfunction 
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
endstate
state bear
event onbeginstate()
endevent
endstate
event onload()
endevent
event oncellattach()
endevent
event oncelldetach()
endevent
event onupdate()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1