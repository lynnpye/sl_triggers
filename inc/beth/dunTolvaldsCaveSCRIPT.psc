scriptname duntolvaldscavescript extends quest hidden 
bool property trapsprung = false auto hidden
bool property trapevaded = false auto hidden
objectreference property trapsprunggroup auto
objectreference property trapevadedgroup auto
objectreference property hiddendoortrigger auto
auto state greedtrapset
function springtrap()
endfunction
function evadetrap()
endfunction
endstate
state greedtrapsprung  
event onbeginstate()
endevent
endstate
state greedtrapevaded
event onbeginstate()
endevent
endstate
function springtrap()
endfunction
function evadetrap()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1