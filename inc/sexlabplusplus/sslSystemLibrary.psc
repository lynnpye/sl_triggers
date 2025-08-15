scriptname sslsystemlibrary extends quest hidden
sslthreadslots property threadslots auto
function loadlibs(bool forced = false)
endfunction
function setup()
endfunction
function log(string log, string type = "notice")
endfunction
sslactorlibrary property actorlib hidden
sslactorlibrary function get()
endfunction
endproperty
sslthreadlibrary property threadlib hidden
sslthreadlibrary function get()
endfunction
endproperty
sslanimationslots property animslots hidden
sslanimationslots function get()
endfunction
endproperty
sslcreatureanimationslots property creatureslots hidden
sslcreatureanimationslots function get()
endfunction
endproperty
sslactorstats property stats hidden
sslactorstats function get()
endfunction
endproperty
sslexpressionslots property expressionslots hidden
sslexpressionslots function get()
endfunction
endproperty
sslvoiceslots property voiceslots hidden
sslvoiceslots function get()
endfunction
endproperty
sslsystemconfig property config hidden
sslsystemconfig function get()
endfunction
endproperty
actor property playerref hidden
actor function get()
endfunction
endproperty
bool property indebugmode hidden
bool function get()
endfunction
endproperty
event setdebugmode(bool tomode)
endevent
event oninit()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1