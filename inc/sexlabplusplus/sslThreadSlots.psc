scriptname sslthreadslots extends quest
int function gettotalthreadcount() global
endfunction
sslthreadcontroller[] property threads auto
sslthreadmodel function pickmodel(float timeout = 5.0)
endfunction
sexlabthread function getthread(int aithreadid)
endfunction
int function findactorcontroller(actor actorref)
endfunction
sexlabthread function getthreadbyactor(actor akactor)
endfunction
int function activethreads()
endfunction
bool function isrunning()
endfunction
function stopall()
endfunction
function stopthread(sslthreadcontroller slot)
endfunction
function setup()
endfunction
bool function testslots()
endfunction
function installslots()
endfunction
state ready
function setup()
endfunction
endstate
state locked
function setup()
endfunction
sslthreadmodel function pickmodel(float timeout = 5.0)
endfunction
endstate
auto state tobeinitialized
sslthreadmodel function pickmodel(float timeout = 5.0)
endfunction
endstate
sslsystemconfig property config hidden
sslsystemconfig function get()
endfunction
function set(sslsystemconfig aset)
endfunction
endproperty
sexlabframework property sexlab hidden
sexlabframework function get()
endfunction
function set(sexlabframework aset)
endfunction
endproperty
sslthreadcontroller function getcontroller(int tid)
endfunction
sslthreadcontroller function getactorcontroller(actor actorref)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1