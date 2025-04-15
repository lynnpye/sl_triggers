scriptname sovngardestatuescript extends objectreference  
float property fmaxdelta = 65.0 auto ; max total change from starting angle (+/-)
float property fmaxchange = 20.0 auto ; max change per update
float property fminchange = 1.0 auto  ; don't turn if change less than this
bool property bdebug = false auto
event oninit()
endevent
event oncellload()
endevent
event onunload()
endevent
event oncelldetach()
endevent
event onupdate()
endevent
event ontranslationcomplete()
endevent
quest property mq305  auto  
;This file was cleaned with PapyrusSourceHeadliner 1