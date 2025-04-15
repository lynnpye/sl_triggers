scriptname ccbgssse001_crabmq3_quest extends quest  
float property timetobuildstall auto
float property timeforcourier auto
int property stallbuiltstage auto
int property startcourierstage auto
function startcouriertimer()
endfunction
function startmarketstalltimer()
endfunction
state couriertimer
event onupdategametime()
endevent
endstate
state stalltimer
event onupdategametime()
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1