scriptname petframework_parentquestscript extends quest
globalvariable property petframework_maxpets auto ;max number of pets who can follow at once, default is 2
referencealias property dlc2severinmanorenablemarker auto
referencealias property homemarkerdlc2severinmanor auto
referencealias property byoh01doorlakeviewmanor auto
referencealias property byoh02doorwindstadmanor auto
referencealias property byoh03doorheljarchenhall auto
referencealias property homemarkerlakeviewmanor auto
referencealias property homemarkerwindstadmanor auto
referencealias property homemarkerheljarchenhall auto
faction property petframework_petfaction auto
faction property playerfaction auto
faction property cwsonsfaction auto
faction property cwimperialfaction auto
int property currentpetcount = 0 auto hidden ;current count of pets, this is manipulated by pet esps/esls using the functions below
event oninit()
endevent
int function getcurrentpetcount()
endfunction
int function getmaxpets()
endfunction
function incrementpetcount()
endfunction
function decrementpetcount()
endfunction
bool function hasmaxpets()
endfunction
function fillrefaliasesfromdlc()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1