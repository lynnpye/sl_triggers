scriptname ski_configmanager extends ski_questbase hidden
string property journal_menu = "journal menu" autoreadonly
string property menu_root = "_root.configpanelfader.configpanel" autoreadonly
function cleanup()
endfunction
function forcereset()
endfunction
int function getversion()
endfunction
event oninit()
endevent
function ongamereload()
endfunction
event onupdate()
endevent
function onmenuopen(string a_menuname)
endfunction
function onmenuclose(string a_menuname)
endfunction
function onmodselect(string a_eventname, string a_strarg, float a_numarg, form a_sender)
endfunction
function onpageselect(string a_eventname, string a_strarg, float a_numarg, form a_sender)
endfunction
function onoptionhighlight(string a_eventname, string a_strarg, float a_numarg, form a_sender)
endfunction
function onoptionselect(string a_eventname, string a_strarg, float a_numarg, form a_sender)
endfunction
function onoptiondefault(string a_eventname, string a_strarg, float a_numarg, form a_sender)
endfunction
function onkeymapchange(string a_eventname, string a_strarg, float a_numarg, form a_sender)
endfunction
function onsliderselect(string a_eventname, string a_strarg, float a_numarg, form a_sender)
endfunction
function onslideraccept(string a_eventname, string a_strarg, float a_numarg, form a_sender)
endfunction
function onmenuselect(string a_eventname, string a_strarg, float a_numarg, form a_sender)
endfunction
function onmenuaccept(string a_eventname, string a_strarg, float a_numarg, form a_sender)
endfunction
function oncolorselect(string a_eventname, string a_strarg, float a_numarg, form a_sender)
endfunction
function oncoloraccept(string a_eventname, string a_strarg, float a_numarg, form a_sender)
endfunction
function oninputselect(string a_eventname, string a_strarg, float a_numarg, form a_sender)
endfunction
function oninputaccept(string a_eventname, string a_strarg, float a_numarg, form a_sender)
endfunction
function ondialogcancel(string a_eventname, string a_strarg, float a_numarg, form a_sender)
endfunction
int function registermod(ski_configbase a_menu, string a_modname)
endfunction
int function nextid()
endfunction
function log(string a_msg)
endfunction
int function unregistermod(ski_configbase a_menu)
endfunction
state busy
function cleanup()
endfunction
function forcereset()
endfunction
int function unregistermod(ski_configbase a_menu)
endfunction
int function registermod(ski_configbase a_menu, string a_modname)
endfunction
endstate
;This file was cleaned with PapyrusSourceHeadliner 1