scriptname mqsovngardeshouttrigger extends mqshouttrigger  
event onload()
endevent
event onactivate(objectreference akactionref)
endevent
function firetriggerevent(spell akspell)
endfunction
function resolvetriggerlogic(objectreference triggerref = none, spell spellref = none)
endfunction
function devoursoulchangestate(int newstate)
endfunction
function trytochangestate(keyword pkeyword, int newstate)
endfunction
quest property mq305  auto  
keyword property dragonkeyword  auto  
keyword property lostsoulkeyword  auto  
;This file was cleaned with PapyrusSourceHeadliner 1