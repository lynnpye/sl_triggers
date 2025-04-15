scriptname cr08questscript extends companionsradiantquest conditional
referencealias property victim auto
referencealias property protectedvictim auto
referencealias property victimmarker auto
locationalias property victimhome auto
referencealias property skjor auto  ; on c00
referencealias property vilkas auto ; on c00
keyword property crskjor auto
keyword property crvilkas auto
event onstoryscript(keyword akkeyword, location aklocation, objectreference akref1, objectreference akref2, int aivalue1, int aivalue2)
endevent
function accepted()
endfunction
function locationchangecheck(location newlocation)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1