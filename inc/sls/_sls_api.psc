scriptname _sls_api extends quest  
event oninit()
endevent
function registerforevents()
endfunction
event on_sls_int_playerloadsgame(string eventname, string strarg, float numarg, form sender)
endevent
function setversion(float version)
endfunction
event on_sls_issuelicence(int licencetype, int termduration, form issuer, form givelicto, bool deductgold, form sender)
endevent
function sendlicenceissuedevent(objectreference licence, int licencetype, int termduration, form requestingmod)
endfunction
event on_sls_blocklicencebuy(form sender, bool blocklicence)
endevent
event on_sls_revokelicence(string eventname, string strarg, float numarg, form sender)
endevent
event on_sls_sendtokennel(form akactor = none, string hold = "")
endevent
event on_sls_evictfromhome(int homeint, form evictform, string evictreason)
endevent
event on_sls_unevictfromhome(int homeint, form evictform)
endevent
event on_sls_increasegroundtime(form akspeaker, int locint = -1, int days)
endevent
event on_sls_removemagiccurse(form aktarget)
endevent
event on_sls_addmagiccurse(form aktarget)
endevent
event on_sls_addstashtracking(form akcontainer, float theftfreq = -1.0, float containersafety = -1.0)
endevent
event on_sls_removestashtracking(form akcontainer)
endevent
event on_sls_addstashexception(form akcontainer)
endevent
event on_sls_removestashexception(form akcontainer)
endevent
function sendslavetownevent(int playerisinslavetown)
endfunction
function sendcumhungerchangeevent(int hungerstate)
endfunction
function sendauthorativeconvoendevent(actor akspeaker)
endfunction
function sendlicencestateupdateevent()
endfunction
function setupquartermasters()
endfunction
function sendcumswallowevent(form aksource, bool didswallow, float cumamount, float loadsizebase, bool iscumpotion)
endfunction
event on_sls_swallowcum(form cumsource = none, float cumamount = -1.0, bool didswallow = true,  int addcumtoface = 0)
endevent
event on_sls_addtraumatoplayer(string eventname, string strarg, float numarg, form sender)
endevent
function cleanup()
endfunction
;actor property playerref auto
;globalvariable property _sls_licbuyblockapi auto
;_sls_licenceutil property licutil auto
;_sls_apilichandler property lichandle auto
sls_utility property util auto
;sls_evictiontrack property eviction auto
;sls_stashtrackplayer property stashtrack auto
;_sls_trauma property trauma auto
;This file was cleaned with PapyrusSourceHeadliner 1