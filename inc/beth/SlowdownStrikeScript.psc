scriptname slowdownstrikescript extends actor
spell property slowtime auto
event onload()
endevent
event onanimationevent(objectreference aksource, string eventname)
endevent
bool function slowdowncheck()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1