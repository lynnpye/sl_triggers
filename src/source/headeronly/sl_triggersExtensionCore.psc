scriptname sl_triggersextensioncore extends sl_triggersextension
actorbase property    pksentinelbase auto
formlist property    thecontainersweknowandlove auto ; so many naming schemes to choose from
actor property pksentinel auto hidden
globalvariable  property dakstatus    auto hidden
bool    property dakavailable   auto hidden
globalvariable  property dakhotkey    auto hidden
float    property tohelapsedtime   auto hidden
float    property lasttopofthehour  auto hidden
float    property nexttopofthehour  auto hidden
int[] property checkedmodifierkeys hidden
int[] function get()
endfunction
endproperty
int property cs_default   = 0 autoreadonly hidden
int property cs_sltinit    = 1 autoreadonly hidden
int property cs_sentinel_setup  = 2 autoreadonly hidden
int property cs_polling   = 3 autoreadonly hidden
string function cs_tostring(int csstate)
endfunction
bool function ismcmconfigurable()
endfunction
function queueupdateloop(float afdelay = 1.0)
endfunction
event oninit()
endevent
event onupdate()
endevent
bool function populatesentinel()
endfunction
function populateperk()
endfunction
function sltready()
endfunction
function clearkeystates()
endfunction
function refreshdata()
endfunction
bool function customresolvescoped(sl_triggerscmd cmdprimary, string scope, string token)
endfunction
event onupdategametime()
endevent
event onsltnewsession(int _newsessionid)
endevent
event ontopofthehour(string eventname, string strarg, float fltarg, form sender)
endevent
event onkeyup(int keycode, float holdtime)
endevent
event onkeydown(int keycode)
endevent
event onsltrplayerequipevent(form baseform, objectreference objref, bool is_equipping)
endevent
event onsltrplayercombatstatechanged(actor target, bool player_in_combat)
endevent
event onsltrplayerhit(form kattacker, form ktarget, int ksourceformid, int kprojectileformid, bool was_player_attacker, bool kpowerattack, bool ksneakattack, bool kbashattack, bool khitblocked)
endevent
function send_sltr_onplayercellchange()
endfunction
function sltr_internal_playercellchange()
endfunction
function send_sltr_onplayeractivatecontainer(objectreference containerref, bool container_is_corpse, bool container_is_empty)
endfunction
function sltr_internal_playeractivatedcontainer(objectreference containerref, bool container_is_corpse, bool container_is_empty)
endfunction
function refreshthecontainersweknowandlove()
endfunction
function refreshtriggercache()
endfunction
function aligntonexthour(float _curtime)
endfunction
function updatedakstatus()
endfunction
function handleversionupdate(int oldversion, int newversion)
endfunction
function registerevents()
endfunction
function registerforkeyevents()
endfunction
function handletimers()
endfunction
function handlenewsession(int _newsessionid)
endfunction
function handletopofthehour()
endfunction
function handleonkeydown()
endfunction
function handleonplayercellchange(bool isnewgamelaunch, bool isnewsession, keyword playerlocationkeyword, bool playerwasininterior)
endfunction
int function getnextplayercellchangerequestid(int requesttargetformid, int cmdrequestid, bool playerwasininterior, keyword playerlocationkeyword)
endfunction
function handleplayercontaineractivation(objectreference containerref, bool container_is_corpse, bool container_is_empty, keyword playerlocationkeyword, bool playerwasininterior)
endfunction
int function getnextplayercontaineractivationrequestid(int requesttargetformid, int cmdrequestid, form containerref, bool container_is_corpse, bool container_is_empty, bool container_is_common, bool playerwasininterior, keyword playerlocationkeyword)
endfunction
function handlelocationchanged(location akoldloc, location aknewloc)
endfunction
int function getnextlocationchangerequestid(int requesttargetformid, int cmdrequestid, bool playerwasininterior, keyword playerlocationkeyword, location akoldloc, location aknewloc)
endfunction
int property kslotmask30 = 0x00000001 autoreadonly ; head
int property kslotmask31 = 0x00000002 autoreadonly ; hair
int property kslotmask32 = 0x00000004 autoreadonly ; body
int property kslotmask33 = 0x00000008 autoreadonly ; hands
int property kslotmask34 = 0x00000010 autoreadonly ; forearms
int property kslotmask35 = 0x00000020 autoreadonly ; amulet
int property kslotmask36 = 0x00000040 autoreadonly ; ring
int property kslotmask37 = 0x00000080 autoreadonly ; feet
int property kslotmask38 = 0x00000100 autoreadonly ; calves
int property kslotmask39 = 0x00000200 autoreadonly ; shield
int property kslotmask40 = 0x00000400 autoreadonly ; tail
int property kslotmask41 = 0x00000800 autoreadonly ; longhair
int property kslotmask42 = 0x00001000 autoreadonly ; circlet
int property kslotmask43 = 0x00002000 autoreadonly ; ears
int property kslotmask44 = 0x00004000 autoreadonly ; unnamed
int property kslotmask45 = 0x00008000 autoreadonly ; unnamed
int property kslotmask46 = 0x00010000 autoreadonly ; unnamed
int property kslotmask47 = 0x00020000 autoreadonly ; unnamed
int property kslotmask48 = 0x00040000 autoreadonly ; unnamed
int property kslotmask49 = 0x00080000 autoreadonly ; unnamed
int property kslotmask50 = 0x00100000 autoreadonly ; decapitatehead
int property kslotmask51 = 0x00200000 autoreadonly ; decapitate
int property kslotmask52 = 0x00400000 autoreadonly ; unnamed
int property kslotmask53 = 0x00800000 autoreadonly ; unnamed
int property kslotmask54 = 0x01000000 autoreadonly ; unnamed
int property kslotmask55 = 0x02000000 autoreadonly ; unnamed
int property kslotmask56 = 0x04000000 autoreadonly ; unnamed
int property kslotmask57 = 0x08000000 autoreadonly ; unnamed
int property kslotmask58 = 0x10000000 autoreadonly ; unnamed
int property kslotmask59 = 0x20000000 autoreadonly ; unnamed
int property kslotmask60 = 0x40000000 autoreadonly ; unnamed
int property kslotmask61 = 0x80000000 autoreadonly ; fx01
function handleequipmentchange(form akbaseobject, objectreference akref, bool is_equipping)
endfunction
int function getnextequipmentchangerequestid(int requesttargetformid, int cmdrequestid, form baseform, objectreference objref, bool is_equipping, bool is_unique, bool has_enchantments, string equipped_item_type)
endfunction
function handleplayercombatstatechanged(actor target, bool player_in_combat)
endfunction
function handleplayeronhit(form kattacker, form ktarget, int ksourceformid, int kprojectileformid, bool was_player_attacker, bool kpowerattack, bool ksneakattack, bool kbashattack, bool khitblocked)
endfunction
int function getnextplayeronhitrequestid(int requesttargetformid, int cmdrequestid, form kattacker, form ktarget, int ksourceformid, int kprojectileformid)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1