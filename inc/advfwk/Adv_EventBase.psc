scriptname adv_eventbase extends referencealias
string property eventname auto
function onmoduleload()
endfunction
bool function isvalid(actor aktarget)
endfunction
bool function onselect(actor aktarget)
endfunction
function onunselect()
endfunction
bool function onstart(actor aktarget)
endfunction
function onstop()
endfunction
function onpause()
endfunction
function onresume()
endfunction
event oninit()
endevent
event onplayerloadgame()
endevent
string function geteventid()
endfunction
bool function start(actor aktarget)
endfunction
function stop()
endfunction
bool function select(actor akspeaker)
endfunction 
bool function unselect()
endfunction
bool function enable()
endfunction
bool function disable()
endfunction
bool function isactive()
endfunction
int function getstatus()
endfunction
function log(string asmsg)
endfunction
bool function resume()
endfunction
bool function pause()
endfunction
function setobjectivetargets(form[] aktargets)
endfunction
function clearobjectivetargets()
endfunction
bool function lock()
endfunction
bool function release()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1