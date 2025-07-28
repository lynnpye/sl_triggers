scriptname ostimaddon extends quest hidden
function installaddon(string name)
endfunction
osexintegrationmain property ostim auto 
actor property playerref auto 
string property addonname auto
int property requiredversion = 24 auto 
string[] property registeredevents auto      
bool property loadgameevents = true auto                                                       
event ongameload() ; you can either extend this, or not extend it and use registeredevents
endevent
event oninit()
endevent
function registersavedevents()
endfunction
function registerforoevent(string eventname)
endfunction
event ostim_prestart(string eventname, string strarg, float numarg, form sender)
endevent
event ostim_start(string eventname, string strarg, float numarg, form sender)
endevent
event ostim_animationchanged(string eventname, string strarg, float numarg, form sender)
endevent
event ostim_scenechanged(string eventname, string strarg, float numarg, form sender)
endevent
event ostim_orgasm(string eventname, string strarg, float numarg, form sender)
endevent
event ostim_end(string eventname, string strarg, float numarg, form sender)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1