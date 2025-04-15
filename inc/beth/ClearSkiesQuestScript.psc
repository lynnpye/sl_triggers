scriptname clearskiesquestscript extends quest  
event onstoryscript(keyword akkeyword, location aklocation, objectreference akref1, objectreference akref2, \
int aivalue1, int aivalue2)
endevent
function clearskiesstart()
endfunction
event onupdategametime()
endevent
int property iclearskieslevel  auto  
weather property clearweatheroverride  auto  
int property idurationlevel1 = 1  auto  
int property idurationlevel2  = 2 auto  
int property idurationlevel3  = 3 auto  
int property newweathertype  auto  
;This file was cleaned with PapyrusSourceHeadliner 1