scriptname survival_playerlocationinfo extends referencealias
actor property playerref auto
bool property inwarmarea = false auto hidden
bool property incoolarea = false auto hidden
bool property infreezingarea = false auto hidden
bool property insouthforestmountainsfreezingarea = false auto hidden
bool property infallforestmountainsfreezingarea = false auto hidden
formlist property survival_interiorareas auto
formlist property survival_coldinteriorlocations auto
formlist property survival_coldinteriorcells auto
function regionentered(string regionname)
endfunction
function regionleft(string regionname)
endfunction
int function getcurrentareatype()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1