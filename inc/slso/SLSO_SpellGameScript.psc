scriptname slso_spellgamescript extends activemagiceffect
sexlabframework property sexlab auto
sslthreadcontroller property controller auto
string property file auto
bool property isaggressor auto
bool property isvictim auto
bool property isfemale auto
bool property mentallybroken auto
bool property forced auto
bool property pausegame auto
actor property partnerreference auto
float property vibrate auto
float property getmodselfsta auto
float property getmodselfmag auto
float property getmodpartsta auto
float property getmodpartmag auto
int property position auto
int property relationshiprank auto
event oneffectstart( actor aktarget, actor akcaster )
endevent
event start_widget(int widget_id, int thread_id)
endevent
event onsexlabend(string eventname, string argstring, float argnum, form sender)
endevent
event onupdate()
endevent
float function getmod(string var = "", actor partnerref = none)
endfunction
function game(string var = "")
endfunction
function modenjoyment(actor partnerref, float mod, float fullenjoymentmod)
endfunction
function mentalbreak(actor partnerref)
endfunction
event onplayerloadgame()
endevent
event oneffectfinish( actor aktarget, actor akcaster )
endevent
function remove()
endfunction
function change_partner(int partnerid = 0)
endfunction
event onvibratestart(string eventname, string argstring, float argnum, form sender)
endevent
event onvibratestop(string eventname, string argstring, float argnum, form sender)
endevent
function registerkey(int rkey = 0)
endfunction
event onkeydown(int keycode)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1