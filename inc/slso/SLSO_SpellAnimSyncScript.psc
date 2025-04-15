scriptname slso_spellanimsyncscript extends activemagiceffect
sexlabframework property sexlab auto
sslthreadcontroller property controller auto
string property file auto
float property base_speed auto
float property min_speed auto
float property max_speed auto
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