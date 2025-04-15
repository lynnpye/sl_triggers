scriptname ski_main extends ski_questbase
string property barter_menu = "bartermenu" autoreadonly
bool property bartermenucheckenabled
bool function get()
endfunction
function set(bool a_val)
endfunction
endproperty
string property container_menu = "containermenu" autoreadonly
string property crafting_menu = "crafting menu" autoreadonly
bool property containermenucheckenabled
bool function get()
endfunction
function set(bool a_val)
endfunction
endproperty
bool property craftingmenucheckenabled
bool function get()
endfunction
function set(bool a_val)
endfunction
endproperty
int property err_ini_papyrus = 4 autoreadonly
int property err_skse_broken = 7 autoreadonly
int property err_skse_missing = 1 autoreadonly
int property err_skse_version_rt = 2 autoreadonly
int property err_skse_version_scpt = 3 autoreadonly
int property err_swf_invalid = 5 autoreadonly
int property err_swf_version = 6 autoreadonly
bool property errordetected = false auto
string property favorites_menu = "favoritesmenu" autoreadonly
bool property favoritesmenucheckenabled
bool function get()
endfunction
function set(bool a_val)
endfunction
endproperty
string property gift_menu = "giftmenu" autoreadonly
bool property giftmenucheckenabled
bool function get()
endfunction
function set(bool a_val)
endfunction
endproperty
string property hud_menu = "hud menu" autoreadonly
string property inventory_menu = "inventorymenu" autoreadonly
bool property inventorymenucheckenabled
bool function get()
endfunction
function set(bool a_val)
endfunction
endproperty
string property journal_menu = "journal menu" autoreadonly
string property magic_menu = "magicmenu" autoreadonly
string property map_menu = "mapmenu" autoreadonly
bool property magicmenucheckenabled
bool function get()
endfunction
function set(bool a_val)
endfunction
endproperty
bool property mapmenucheckenabled
bool function get()
endfunction
function set(bool a_val)
endfunction
endproperty
int property minskserelease = 53 autoreadonly
string property minskseversion = "2.0.4" autoreadonly
int property reqswfrelease = 2018 autoreadonly
string property reqswfversion = "5.2 se" autoreadonly
event oninit()
endevent
function ongamereload()
endfunction
function onmenuopen(string a_menuname)
endfunction
function error(int a_errid, string a_msg)
endfunction
bool function checkmenuversion(string a_swfname, string a_menu, string a_class)
endfunction
bool function checkitemmenucomponents(string a_menu)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1