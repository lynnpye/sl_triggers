scriptname sl_triggersstatics
function sltdebugmsg(string msg) global
endfunction
function slterrmsg(string msg) global
endfunction
function sltinfomsg(string msg) global
endfunction
function sltwarnmsg(string msg) global
endfunction
int function getmodversion() global
endfunction
function saferegisterformodevent_quest(quest _theself, string _theevent, string _thehandler) global
endfunction
function saferegisterformodevent_objectreference(objectreference _theself, string _theevent, string _thehandler) global
endfunction
function saferegisterformodevent_ame(activemagiceffect _theself, string _theevent, string _thehandler) global
endfunction
string function event_slt_request_command() global
endfunction
string function event_slt_request_list() global
endfunction
string function event_slt_register_extension() global
endfunction
string function event_slt_on_new_session() global
endfunction
string function event_slt_internal_ready_event() global
endfunction
string function event_slt_reset() global
endfunction
string function event_slt_settings_updated() global
endfunction
string function event_slt_delay_start_command() global
endfunction
string function event_sltr_on_player_container_activate() global
endfunction
string function event_sltr_on_player_cell_change() global
endfunction
string function event_sltr_on_player_loading_screen() global
endfunction
string function event_sltr_on_player_equip() global
endfunction
string function event_sltr_on_player_combat_state_changed() global
endfunction
string function event_sltr_on_player_hit() global
endfunction
float function slt_list_request_su_key_is_global() global
endfunction
string function deleted_attribute() global
endfunction
sl_triggersmain function getsltmain() global
endfunction
form function getform_slt_main() global
endfunction
form function getform_slt_extensioncore() global
endfunction
form function getform_slt_extensionsexlab() global
endfunction
form function getform_slt_extensionostim() global
endfunction
form function getform_skyrim_actortypenpc() global
endfunction
form function getform_skyrim_actortypeundead() global
endfunction
form function getform_dak_status() global
endfunction
form function getform_dak_hotkey() global
endfunction
form function getform_sexlab_framework() global
endfunction
form function getform_sexlab_animatingfaction() global
endfunction
form function getform_deviousdevices_zadlibs() global
endfunction
form function getform_deviousfollowers_dfquest() global
endfunction
form function getform_ostim_integration_main() global
endfunction
int function getrelativeformid_deviousfollowers_mcm() global
endfunction
string function getmodfilename_deviousfollowers_mcm() global
endfunction
form function getform_deviousfollowers_mcm() global
endfunction
string function commandsfolder() global
endfunction
string function fullcommandsfolder() global
endfunction
string function extensiontriggersfolder(string _extensionkey) global
endfunction
string function fn_settings() global
endfunction
string function fn_morecontainersweknowandlove() global
endfunction
string function fn_x_settings(string _x) global
endfunction
string function fn_x_attributes(string _x) global
endfunction
string function fn_trigger(string _x, string _t) global
endfunction
bool function getflag(bool bdbgout, string filename, string flagname, bool defaultvalue = false) global
endfunction
bool function updateflag(bool bdbgout, string filename, string flagname, bool newvalue) global
endfunction
int function globalhextoint(string _value) global
endfunction
bool function isstringtruthy(string _value) global
endfunction
function squawkfunctionerror(sl_triggerscmd _cmdprimary, string msg) global
endfunction
function squawkfunctionwarn(sl_triggerscmd _cmdprimary, string msg) global
endfunction
function squawkfunctioninfo(sl_triggerscmd _cmdprimary, string msg) global
endfunction
function squawkfunctiondebug(sl_triggerscmd _cmdprimary, string msg) global
endfunction
bool function paramlengthlt(sl_triggerscmd _cmdprimary, int actuallength, int neededlength) global
endfunction
bool function paramlengthgt(sl_triggerscmd _cmdprimary, int actuallength, int neededlength) global
endfunction
bool function paramlengtheq(sl_triggerscmd _cmdprimary, int actuallength, int neededlength) global
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1