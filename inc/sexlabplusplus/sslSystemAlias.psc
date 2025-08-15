scriptname sslsystemalias extends referencealias
sexlabframework property sexlab auto
sslsystemconfig property config auto
sslthreadlibrary property threadlib auto
sslthreadslots property threadslots auto
bool property isinstalled hidden
bool function get()
endfunction
endproperty
event oninit()
endevent
event onplayerloadgame()
endevent
bool function setupsystem()
endfunction
event installsystem()
endevent
function loadlibs(bool forced = false)
endfunction
bool property preloaddone = true auto hidden
sslanimationslots property animslots hidden
sslanimationslots function get()
endfunction
endproperty
sslcreatureanimationslots property creatureslots hidden
sslcreatureanimationslots function get()
endfunction
endproperty
sslobjectfactory property factory hidden
sslobjectfactory function get()
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
sslactorlibrary property actorlib hidden
sslactorlibrary function get()
endfunction
endproperty
function log(string log, string type = "notice")
endfunction
function logall(string log)
endfunction
bool property updatepending hidden
bool function get()
endfunction
endproperty
int property currentversion hidden
int function get()
endfunction
endproperty
function cleantrackedactors()
endfunction
function cleantrackedfactions()
endfunction
event updatesystem(int oldversion, int newversion)
endevent
function sendversionevent(string versionevent)
endfunction
bool function isactor(form formref) global
endfunction
function menuwait()
endfunction
function cleanactorstorage()
endfunction
function clearfromactorstorage(form formref)
endfunction
bool function isimportant(actor actorref, bool strict = false) global
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1