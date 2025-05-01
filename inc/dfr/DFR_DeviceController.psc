scriptname dfr_devicecontroller extends quest conditional
actor property playerref auto
zadlibs property libs auto
qf__gift_09000d62 property flow auto
globalvariable property lives auto
globalvariable property removalprice auto
miscobject property gold auto
float property favourminimum = 0.0 auto hidden conditional
globalvariable[] property removalblocked auto ; 0 = allowed, 1 = blocked (generic), 2 = blocked (deal)
dfr_devicecontroller function get() global
endfunction
function priceupdate()
endfunction
function blockremoval(int aicode, string assource, int aitype = 0)
endfunction
function allowremoval(int aicode, string assource)
endfunction
function prepdealremoval(int aicode)
endfunction
function remove(int aicode)
endfunction
keyword function devicecodetokeyword(int aicode)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1