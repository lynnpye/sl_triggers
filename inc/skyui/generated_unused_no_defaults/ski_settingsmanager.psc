scriptname ski_settingsmanager extends ski_questbase
string property barter_menu = "bartermenu" autoreadonly
string property container_menu = "containermenu" autoreadonly
string property crafting_menu = "crafting menu" autoreadonly
string property gift_menu = "giftmenu" autoreadonly
string property inventory_menu = "inventorymenu" autoreadonly
string property magic_menu = "magicmenu" autoreadonly
string property menu_root = "_global.skyui.util.configmanager" autoreadonly
event oninit()
endevent
function ongamereload()
endfunction
function onmenuopen(string a_menuname)
endfunction
function onsetconfigoverride(string a_eventname, string a_strarg, float a_numarg, form a_sender)
endfunction
bool function setoverride(string a_key, string a_value)
endfunction
bool function clearoverride(string a_key)
endfunction
int function nextfreeindex()
endfunction
state locked
function onmenuopen(string a_menuname)
endfunction
endstate
;This file was cleaned with PapyrusSourceHeadliner 1