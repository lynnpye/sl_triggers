scriptname dlc2expspidercraftingscript extends objectreference hidden
formlist property recipelist auto
formlist property resultlist auto
formlist property recipebookliststatic auto
formlist property sigilrecipelist auto
formlist property sigilresultlist auto
objectreference  property createpoint auto
objectreference property dropbox auto
activator property summonfx auto
objectreference property summonfxpoint auto
bool property sigilstoneinstalled auto hidden
objectreference property lastsummonedobject auto hidden
bool property bhasloaded auto hidden
state busy
event onactivate(objectreference actronaut)
endevent
endstate
auto state ready
event oncellattach()
endevent
event onactivate(objectreference actronaut)
endevent
endstate
bool function scanforrecipes(formlist recipes, formlist results)
endfunction
bool function scansublist(formlist recipe)
endfunction
function removeingredients(formlist recipe)
endfunction
function removesubingredients(formlist subingredients)
endfunction
function filldynamiclist()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1