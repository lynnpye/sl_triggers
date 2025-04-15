scriptname ski_favoritesmanager extends ski_questbase
bool property buttonhelpenabled = true auto
string property favorites_menu = "favoritesmenu" autoreadonly
int property group_flag_unequip_armor = 1 autoreadonly
int property group_flag_unequip_hands = 2 autoreadonly
int property groupaddkey
int function get()
endfunction
function set(int a_val)
endfunction
endproperty
int property groupusekey
int function get()
endfunction
function set(int a_val)
endfunction
endproperty
string property menu_root = "_root.menuholder.menu_mc" autoreadonly
actor property playerref auto
int property saveequipstatekey
int function get()
endfunction
function set(int a_val)
endfunction
endproperty
int property seticonkey
int function get()
endfunction
function set(int a_val)
endfunction
endproperty
int property togglefocuskey
int function get()
endfunction
function set(int a_val)
endfunction
endproperty
function onkeydown(int a_keycode)
endfunction
int function getversion()
endfunction
event oninit()
endevent
function ongamereload()
endfunction
function onversionupdate(int a_version)
endfunction
function onmenuopen(string a_menuname)
endfunction
function onfoundinvaliditem(string a_eventname, string a_strarg, float a_numarg, form a_sender)
endfunction
function ongroupadd(string a_eventname, string a_strarg, float a_numarg, form a_sender)
endfunction
function ongroupremove(string a_eventname, string a_strarg, float a_numarg, form a_sender)
endfunction
function onsaveequipstate(string a_eventname, string a_strarg, float a_numarg, form a_sender)
endfunction
function onsetgroupicon(string a_eventname, string a_strarg, float a_numarg, form a_sender)
endfunction
function ongroupuse(string a_eventname, string a_strarg, float a_numarg, form a_sender)
endfunction
bool function getgroupflag(int a_groupindex, int a_flag)
endfunction
function setgroupflag(int a_groupindex, int a_flag, bool a_value)
endfunction
int[] function getgrouphotkeys()
endfunction
bool function setgrouphotkey(int a_groupindex, int a_keycode)
endfunction
function initcontrols()
endfunction
function initmenugroupdata()
endfunction
function updatemenugroupdata(int a_groupindex)
endfunction
function cleanup()
endfunction
bool function groupadd(int a_groupindex, int a_itemid, form a_item)
endfunction
bool function groupremove(int a_groupindex, int a_itemid)
endfunction
function groupuse(int a_groupindex)
endfunction
function unequiphand(int a_hand)
endfunction
bool function isitemvalid(form a_item, int a_itemtype)
endfunction
bool function processitem(form a_item, int a_itemtype, bool a_allowdeferring, bool a_offhandonly, int a_itemid)
endfunction
function invalidateitem(int a_itemid, bool redrawicon)
endfunction
int function findfreeindex(int[] a_itemids, bool[] a_iteminvalidflags, int offset)
endfunction
function replacegroupicon(int a_groupindex)
endfunction
bool function isformingroup(int a_groupindex, form a_item)
endfunction
int function getnumformsingroup(int a_groupindex, form a_item)
endfunction
form function getformfromitemid(int a_groupindex, int itemid)
endfunction
int function getnthitemidingroup(int a_groupindex, form a_item, int a_num)
endfunction
bool function isitemidingroup(int a_groupindex, int a_itemid)
endfunction
function registerhotkeys()
endfunction
function swapcontrolkey(int a_newkey, int a_curkey)
endfunction
function printgroupitems(int a_groupindex)
endfunction
state processing
function ongroupuse(string a_eventname, string a_strarg, float a_numarg, form a_sender)
endfunction
function onkeydown(int a_keycode)
endfunction
endstate
;This file was cleaned with PapyrusSourceHeadliner 1