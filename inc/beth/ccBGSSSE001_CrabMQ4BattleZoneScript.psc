scriptname ccbgssse001_crabmq4battlezonescript extends objectreference  
actor property playerref auto
musictype property bossmusic auto
weather property battleweather auto
int property music_type_none = 0 autoreadonly
int property music_type_boss = 1 autoreadonly
event ontriggerenter(objectreference akactionref)
endevent
event ontriggerleave(objectreference akactionref)
endevent
function checkzoneplayback()
endfunction
event onunload()
endevent
function removezone()
endfunction
function setandplaybossmusic()
endfunction
function setandplaynomusic()
endfunction
function stopmusic()
endfunction
function playweatherandmusic()
endfunction
function suspendweatherandmusic()
endfunction
function stopweatherandmusic()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1