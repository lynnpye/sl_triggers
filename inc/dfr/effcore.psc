scriptname effcore extends quest conditional
dialoguefollowerscript property followerscript auto
effmenuscript property xflmenu auto
effidlemonitor property xflidlemonitor auto
topic property dialoguefollowerdismisstopic auto ; don't use the package anymore
globalvariable property xfl_followercountex auto
globalvariable property xfl_maximumfollowers auto
globalvariable property xfl_config_autoinvisiblity auto
globalvariable property xfl_config_ignoretimeout auto
objectreference property xfl_unclaimeditemsstatic auto ; static ref to the unclaimed barrel
objectreference property xfl_unclaimeditems auto ; unclaimed items are moved here
objectreference[] property xfl_followerinventories auto ; all follower inventories
referencealias[] property xfl_followeraliases auto 
faction property xfl_followerfaction auto
message property xfl_followerdeathmessage auto
formlist property xfl_followerplugins auto
formlist property xfl_followerlist  auto  
activator property xfl_portaleffect auto
spell property xfl_portal auto
spell property xfl_followertelepathy auto
spell property xfl_followerteleportation auto
spell property xfl_followerfocustarget auto
spell property xfl_followerinvisibility auto
spell property xfl_followermuffled auto
magiceffect property xfl_followermuffleeffect auto
magiceffect property xfl_followerinvisibilityeffect auto
effoutfit property xfl_outfitcontroller auto
effpanel property xfl_panel auto
float[] property recruittimes auto
bool[] property tmrestore auto
bool[] property ffrestore auto
int[] property actorflags auto
bool property xfl_autosandboxing = false auto conditional
int property plugin_event_clear_all = -1 autoreadonly
int property plugin_event_wait = 0x04 autoreadonly
int property plugin_event_sandbox = 0x05 autoreadonly
int property plugin_event_follow = 0x03 autoreadonly
int property plugin_event_add_follower = 0x00 autoreadonly
int property plugin_event_remove_follower = 0x01 autoreadonly
int property plugin_event_remove_dead_follower = 0x02 autoreadonly
int property actor_flag_disable_wait = 1 autoreadonly
int property actor_flag_disable_follow = 2 autoreadonly
int property actor_flag_disable_dismiss = 4 autoreadonly
int property actor_flag_disable_relax = 8 autoreadonly
int property actor_flag_disable_trade_equip = 16 autoreadonly
int property actor_flag_disable_trade_inventory = 32 autoreadonly
int property actor_flag_disable_trade_magic = 64 autoreadonly
int property actor_flag_disable_stats = 128 autoreadonly
int property actor_flag_disable_more = 128 autoreadonly
bool property skseextended auto ; skse loaded
bool property dlc1extended auto ; dlc1 dawnguard loaded
bool property menuextended auto ; menu system loaded
bool property apnlextended auto ; actor panel loaded
bool property skseevents auto ; skse event callbacks available
event oninit()
endevent
function xfl_registerextensions()
endfunction
function xfl_registerplugin(quest questref)
endfunction
event oncontroldown(string control)
endevent
function xfl_setwait(form follower)
endfunction
function xfl_setsandbox(form follower)
endfunction
function xfl_setfollow(form follower)
endfunction
function xfl_addfollower(form follower)
endfunction
function xfl_removefollower(form follower, int imessage = 0, int isayline = 1)
endfunction
function xfl_removedeadfollower(form follower)
endfunction
bool function xfl_isrunning()
endfunction
bool function xfl_isdefault(actor follower)
endfunction
function xfl_sendpluginevent(int aktype, form akref1 = none, form akref2 = none, int aivalue1 = 0, int aivalue2 = 0)
endfunction
effplugin function xfl_getplugin(int akidentifier)
endfunction
function xfl_sendactionevent(int akidentifier, int akcmd, form akform1 = none, form akform2 = none, int aivalue1 = 0, int aivalue2 = 0)
endfunction
function xfl_setlastfollower()
endfunction
actor function xfl_getlastfollower()
endfunction
actor function xfl_getclosestfollower(objectreference aksource)
endfunction
actor function xfl_getfollower(int i)
endfunction
int function xfl_getindex(actor follower)
endfunction
int function xfl_getfollowerflags(actor follower)
endfunction
bool function xfl_setfollowerflags(actor follower, int flags, bool setflag)
endfunction
bool function xfl_hasfollowerflags(actor follower, int flags)
endfunction
int function xfl_getcount()
endfunction
function xfl_setcount()
endfunction
int function xfl_getmaximum()
endfunction
function xfl_setmaximum()
endfunction
function xfl_forceclearall()
endfunction
bool function xfl_isfollower(actor follower)
endfunction
function xfl_clearalias(actor follower)
endfunction
referencealias function xfl_getalias(actor follower)
endfunction
int function xfl_setalias(actor follower)
endfunction
function xfl_openinventory(form akref)
endfunction
function xfl_movetoinventory(form akref, form akform, int aicount)
endfunction
function xfl_updatepanel(form akref)
endfunction
function xfl_removeall(int imessage = 0, int isayline = 1)
endfunction
function xfl_sandboxall()
endfunction
function xfl_waitall()
endfunction
function xfl_followall()
endfunction
function xfl_evaluateall()
endfunction
function xfl_sneakall(bool addmuffle = false, bool addinvisibility = false)
endfunction
function xfl_dismisslist(form akref, int imessage = 0, int isayline = 1)
endfunction
function xfl_sandboxlist(form akref)
endfunction
function xfl_waitlist(form akref)
endfunction
function xfl_followlist(form akref)
endfunction
function xfl_autosandbox(bool engage)
endfunction
function xfl_focustarget(form aktarget, form akref, bool safecheck)
endfunction
function xfl_teleport(form aktarget, form akref)
endfunction
function xfl_warpactor(actor akactor, actor dest)
endfunction
function xfl_sendsystemevent(int eventid, objectreference akref1 = none, objectreference akref2 = none, int aivalue1 = 0, int aivalue2 = 0)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1