scriptname cwlockduringsiegescript extends objectreference  
cwscript property cw auto
int property locklevelduringsiege = 75 auto
int property locklevelpostsiege auto
bool property alwaysunlockifnosiege = true auto
bool property requiresiegequesttobeacceptedtolock = true auto
bool property treatcwsiegestage255asstopped = true auto
event oncellload() 
endevent
;This file was cleaned with PapyrusSourceHeadliner 1