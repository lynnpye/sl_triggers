scriptname sslthreadhook extends referencealias
sexlabframework property sexlab auto hidden
sslsystemconfig property sexlabconfig auto hidden
bool function animationstarting(sslthreadmodel thread)
endfunction
bool function animationprepare(sslthreadcontroller thread)
endfunction
bool function stagestart(sslthreadcontroller thread)
endfunction
bool function stageend(sslthreadcontroller thread)
endfunction
bool function animationending(sslthreadcontroller thread)
endfunction
bool function animationend(sslthreadcontroller thread)
endfunction
bool property hasactorfilter hidden
bool function get()
endfunction
endproperty
function addactorfilter(actor _filteredref)
endfunction
function removeactorfilter(actor _filteredref)
endfunction
function clearallactorfilters()
endfunction
actor[] function getfilteredactors()
endfunction
bool function isactorfiltered(actor _filteredref)
endfunction
bool function actorfiltermatch(actor[] _actorlist)
endfunction
bool property hastagfilter hidden
bool function get()
endfunction
endproperty
function addtagfilter(string _filteredtag)
endfunction
function removetagfilter(string _filteredtag)
endfunction
function clearalltagfilters()
endfunction
string[] function getfilteredtags()
endfunction
bool function istagfiltered(string _filteredtag)
endfunction
bool function tagfiltermatch(string[] _taglist)
endfunction
bool property ishookfiltered hidden
bool function get()
endfunction
endproperty
bool function canrunhook(actor[] _actorlist, string[] _taglist)
endfunction
event oninit()
endevent
event onplayerloadgame()
endevent
function onstartup()
endfunction
event sexlabgameloaded()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1