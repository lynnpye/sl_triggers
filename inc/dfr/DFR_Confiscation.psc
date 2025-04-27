scriptname dfr_confiscation extends quest conditional
actor property playerref auto
globalvariable property gamedayspassed auto
objectreference property tempconfiscationcontainer auto
int property numtempconfiscated = 0 auto hidden conditional
bool property enabled
bool function get()
endfunction
function set(bool abvalue)
endfunction
endproperty
float property returndelaymin = 1.0 auto hidden
float property returndelaymax = 3.0 auto hidden
float property returntimer = 0.0 auto hidden conditional
int property minfavourrequired = 0 auto hidden conditional
dfr_confiscation function get() global
endfunction
function takeclothing(objectreference akcontainer = none, bool abexcludefootwear = true)
endfunction
function returnitems()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1