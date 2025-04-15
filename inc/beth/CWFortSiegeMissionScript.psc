scriptname cwfortsiegemissionscript extends cwmissionscript  
keyword property cwfortsiegespecialstart auto  ;this is the keyword used to start the cwfortsiege quest not for a normal fort battle. for example, the final battle in solitude and windhelm's fighting inside the city uses this system.
keyword property cwfortsiegeminorcapitalstart auto
int property specialnonfortsiege auto hidden conditional
int property specialcapitalresolutionfortsiege auto hidden conditional
event onstoryscript(keyword akkeyword, location aklocation, objectreference akref1, objectreference akref2, int aivalue1, int aivalue2)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1