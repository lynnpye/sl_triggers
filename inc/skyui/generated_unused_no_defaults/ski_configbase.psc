scriptname ski_configbase extends ski_questbase
string property currentpage
string function get()
endfunction
endproperty
string property journal_menu = "journal menu" autoreadonly
int property left_to_right = 1 autoreadonly
string property menu_root = "_root.configpanelfader.configpanel" autoreadonly
string property modname auto
int property option_flag_disabled = 1 autoreadonly
int property option_flag_hidden = 2 autoreadonly
int property option_flag_none = 0 autoreadonly
int property option_flag_with_unmap = 4 autoreadonly
int property option_type_color = 6 autoreadonly
int property option_type_empty = 0 autoreadonly
int property option_type_header = 1 autoreadonly
int property option_type_input = 8 autoreadonly
int property option_type_keymap = 7 autoreadonly
int property option_type_menu = 5 autoreadonly
int property option_type_slider = 4 autoreadonly
int property option_type_text = 2 autoreadonly
int property option_type_toggle = 3 autoreadonly
string[] property pages auto
int property state_color = 4 autoreadonly
int property state_default = 0 autoreadonly
int property state_input = 5 autoreadonly
int property state_menu = 3 autoreadonly
int property state_reset = 1 autoreadonly
int property state_slider = 2 autoreadonly
int property top_to_bottom = 2 autoreadonly
function oncoloracceptst(int a_color)
endfunction
function oncoloropenst()
endfunction
function onconfigclose()
endfunction
function onconfiginit()
endfunction
function onconfigopen()
endfunction
function onconfigregister()
endfunction
function ondefaultst()
endfunction
function onhighlightst()
endfunction
function oninputacceptst(string a_input)
endfunction
function oninputopenst()
endfunction
function onkeymapchangest(int a_keycode, string a_conflictcontrol, string a_conflictname)
endfunction
function onmenuacceptst(int a_index)
endfunction
function onmenuopenst()
endfunction
function onoptioncoloraccept(int a_option, int a_color)
endfunction
function onoptioncoloropen(int a_option)
endfunction
function onoptiondefault(int a_option)
endfunction
function onoptionhighlight(int a_option)
endfunction
function onoptioninputaccept(int a_option, string a_input)
endfunction
function onoptioninputopen(int a_option)
endfunction
function onoptionkeymapchange(int a_option, int a_keycode, string a_conflictcontrol, string a_conflictname)
endfunction
function onoptionmenuaccept(int a_option, int a_index)
endfunction
function onoptionmenuopen(int a_option)
endfunction
function onoptionselect(int a_option)
endfunction
function onoptionslideraccept(int a_option, float a_value)
endfunction
function onoptionslideropen(int a_option)
endfunction
function onpagereset(string a_page)
endfunction
function onselectst()
endfunction
function onslideracceptst(float a_value)
endfunction
function onslideropenst()
endfunction
function onversionupdate(int a_version)
endfunction
event oninit()
endevent
function ongamereload()
endfunction
function onconfigmanagerreset(string a_eventname, string a_strarg, float a_numarg, form a_sender)
endfunction
function onconfigmanagerready(string a_eventname, string a_strarg, float a_numarg, form a_sender)
endfunction
function onmessagedialogclose(string a_eventname, string a_strarg, float a_numarg, form a_sender)
endfunction
int function getversion()
endfunction
string function getcustomcontrol(int a_keycode)
endfunction
function forcepagereset()
endfunction
function settitletext(string a_text)
endfunction
function setinfotext(string a_text)
endfunction
function setcursorposition(int a_position)
endfunction
function setcursorfillmode(int a_fillmode)
endfunction
int function addemptyoption()
endfunction
int function addheaderoption(string a_text, int a_flags)
endfunction
int function addtextoption(string a_text, string a_value, int a_flags)
endfunction
int function addtoggleoption(string a_text, bool a_checked, int a_flags)
endfunction
int function addslideroption(string a_text, float a_value, string a_formatstring, int a_flags)
endfunction
int function addmenuoption(string a_text, string a_value, int a_flags)
endfunction
int function addcoloroption(string a_text, int a_color, int a_flags)
endfunction
int function addkeymapoption(string a_text, int a_keycode, int a_flags)
endfunction
int function addinputoption(string a_text, string a_value, int a_flags)
endfunction
function addtextoptionst(string a_statename, string a_text, string a_value, int a_flags)
endfunction
function addtoggleoptionst(string a_statename, string a_text, bool a_checked, int a_flags)
endfunction
function addslideroptionst(string a_statename, string a_text, float a_value, string a_formatstring, int a_flags)
endfunction
function addmenuoptionst(string a_statename, string a_text, string a_value, int a_flags)
endfunction
function addcoloroptionst(string a_statename, string a_text, int a_color, int a_flags)
endfunction
function addkeymapoptionst(string a_statename, string a_text, int a_keycode, int a_flags)
endfunction
function addinputoptionst(string a_statename, string a_text, string a_value, int a_flags)
endfunction
function loadcustomcontent(string a_source, float a_x, float a_y)
endfunction
function unloadcustomcontent()
endfunction
function setoptionflags(int a_option, int a_flags, bool a_noupdate)
endfunction
function settextoptionvalue(int a_option, string a_value, bool a_noupdate)
endfunction
function settoggleoptionvalue(int a_option, bool a_checked, bool a_noupdate)
endfunction
function setslideroptionvalue(int a_option, float a_value, string a_formatstring, bool a_noupdate)
endfunction
function setmenuoptionvalue(int a_option, string a_value, bool a_noupdate)
endfunction
function setcoloroptionvalue(int a_option, int a_color, bool a_noupdate)
endfunction
function setkeymapoptionvalue(int a_option, int a_keycode, bool a_noupdate)
endfunction
function setinputoptionvalue(int a_option, string a_value, bool a_noupdate)
endfunction
function setoptionflagsst(int a_flags, bool a_noupdate, string a_statename)
endfunction
function settextoptionvaluest(string a_value, bool a_noupdate, string a_statename)
endfunction
function settoggleoptionvaluest(bool a_checked, bool a_noupdate, string a_statename)
endfunction
function setslideroptionvaluest(float a_value, string a_formatstring, bool a_noupdate, string a_statename)
endfunction
function setmenuoptionvaluest(string a_value, bool a_noupdate, string a_statename)
endfunction
function setcoloroptionvaluest(int a_color, bool a_noupdate, string a_statename)
endfunction
function setkeymapoptionvaluest(int a_keycode, bool a_noupdate, string a_statename)
endfunction
function setinputoptionvaluest(string a_value, bool a_noupdate, string a_statename)
endfunction
function setsliderdialogstartvalue(float a_value)
endfunction
function setsliderdialogdefaultvalue(float a_value)
endfunction
function setsliderdialogrange(float a_minvalue, float a_maxvalue)
endfunction
function setsliderdialoginterval(float a_value)
endfunction
function setmenudialogstartindex(int a_value)
endfunction
function setmenudialogdefaultindex(int a_value)
endfunction
function setmenudialogoptions(string[] a_options)
endfunction
function setcolordialogstartcolor(int a_color)
endfunction
function setcolordialogdefaultcolor(int a_color)
endfunction
function setinputdialogstarttext(string a_text)
endfunction
bool function showmessage(string a_message, bool a_withcancel, string a_acceptlabel, string a_cancellabel)
endfunction
function error(string a_msg)
endfunction
function openconfig()
endfunction
function closeconfig()
endfunction
function setpage(string a_page, int a_index)
endfunction
int function addoption(int a_optiontype, string a_text, string a_strvalue, float a_numvalue, int a_flags)
endfunction
function addoptionst(string a_statename, int a_optiontype, string a_text, string a_strvalue, float a_numvalue, int a_flags)
endfunction
int function getstateoptionindex(string a_statename)
endfunction
function writeoptionbuffers()
endfunction
function clearoptionbuffers()
endfunction
function setoptionstrvalue(int a_index, string a_strvalue, bool a_noupdate)
endfunction
function setoptionnumvalue(int a_index, float a_numvalue, bool a_noupdate)
endfunction
function setoptionvalues(int a_index, string a_strvalue, float a_numvalue, bool a_noupdate)
endfunction
function requestsliderdialogdata(int a_index)
endfunction
function requestmenudialogdata(int a_index)
endfunction
function requestcolordialogdata(int a_index)
endfunction
function requestinputdialogdata(int a_index)
endfunction
function setslidervalue(float a_value)
endfunction
function setmenuindex(int a_index)
endfunction
function setcolorvalue(int a_color)
endfunction
function setinputtext(string a_text)
endfunction
function selectoption(int a_index)
endfunction
function resetoption(int a_index)
endfunction
function highlightoption(int a_index)
endfunction
function remapkey(int a_index, int a_keycode, string a_conflictcontrol, string a_conflictname)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1