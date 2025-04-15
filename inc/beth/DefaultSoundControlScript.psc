scriptname defaultsoundcontrolscript extends objectreference  
string property soundmarker1name auto
string property soundmarker2name auto
string property soundmarker3name auto
sound property soundmarker1 auto
sound property soundmarker2 auto
sound property soundmarker3 auto
function playsoundbyname(string soundname, objectreference objecttoplayat = none)
endfunction
function stopsoundbyname(string soundname, objectreference objecttoplayat = none)
endfunction
function handlesoundbyname(string soundname, bool playsound, objectreference objecttoplayat = none)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1