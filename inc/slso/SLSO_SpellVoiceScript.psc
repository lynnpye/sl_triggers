scriptname slso_spellvoicescript extends activemagiceffect
sexlabframework property sexlab auto
sslthreadcontroller property controller auto
string property file auto
bool property isvictim auto
bool property isplayer auto
bool property issilent auto
bool property isfemale auto
int property voice auto
formlist property soundcontainer auto
event oneffectstart( actor aktarget, actor akcaster )
endevent
event start_widget(int widget_id, int thread_id)
endevent
event onsexlabend(string eventname, string argstring, float argnum, form sender)
endevent
event onupdate()
endevent
event onplayerloadgame()
endevent
event oneffectfinish( actor aktarget, actor akcaster )
endevent
function remove()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1