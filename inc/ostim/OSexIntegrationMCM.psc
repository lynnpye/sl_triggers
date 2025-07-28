scriptname osexintegrationmcm extends ski_configbase
osexintegrationmain property main auto
event oninit()
endevent
function init()
endfunction
int function getversion()
endfunction
event onversionupdate(int version)
endevent
function setuppages()
endfunction
event onconfigregister()
endevent
event onconfigopen()
endevent
event onconfigclose()
endevent
event onpagereset(string page)
endevent
event onoptionhighlight(int option)
endevent
event onoptionselect(int option)
endevent
event onoptionslideropen(int option)
endevent
event onoptionslideraccept(int option, float value)
endevent
event onoptionmenuopen(int option)
endevent
event onoptionmenuaccept(int option, int index)
endevent
event onoptiondefault(int option)
endevent
function onslotselect(int option)
endfunction
function onslotmouseover(int option)
endfunction
event ongamereload()
endevent
function addcoloredheader(string in)
endfunction
function exportsettings()
endfunction
function importsettings(bool default = false)
endfunction
function drawgeneralpage()
endfunction
state oid_resetposition
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_customtimescale
event onhighlightst()
endevent
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
endstate
state oid_usefades
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_useintroscenes
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_addactorsatstart
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_malelightmode
event onhighlightst()
endevent
event onmenuopenst()
endevent
event onmenuacceptst(int index)
endevent
event ondefaultst()
endevent
endstate
state oid_femalelightmode
event onhighlightst()
endevent
event onmenuopenst()
endevent
event onmenuacceptst(int index)
endevent
event ondefaultst()
endevent
endstate
state oid_playerlightmode
event onhighlightst()
endevent
event onmenuopenst()
endevent
event onmenuacceptst(int index)
endevent
event ondefaultst()
endevent
endstate
state oid_onlylightindark
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_exportsettings
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_importsettings
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_autoexportsettings
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_autoimportsettings
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_resetsettings
event onhighlightst()
endevent
event onselectst()
endevent
endstate
function drawcontrolspage()
endfunction
state oid_keymain
event onhighlightst()
endevent
event onkeymapchangest(int keycode, string conflictcontrol, string conflictname)
endevent
endstate
state oid_keynpcstart
event onhighlightst()
endevent
event onkeymapchangest(int keycode, string conflictcontrol, string conflictname)
endevent
endstate
state oid_keyspeedup
event onhighlightst()
endevent
event onkeymapchangest(int keycode, string conflictcontrol, string conflictname)
endevent
endstate
state oid_keyspeeddown
event onhighlightst()
endevent
event onkeymapchangest(int keycode, string conflictcontrol, string conflictname)
endevent
endstate
state oid_keypullout
event onhighlightst()
endevent
event onkeymapchangest(int keycode, string conflictcontrol, string conflictname)
endevent
endstate
state oid_keycontroltoggle
event onhighlightst()
endevent
event onkeymapchangest(int keycode, string conflictcontrol, string conflictname)
endevent
endstate
state oid_keyfreecamtoggle
event onhighlightst()
endevent
event onkeymapchangest(int keycode, string conflictcontrol, string conflictname)
endevent
endstate
state oid_keysearchmenu
event onhighlightst()
endevent
event onkeymapchangest(int keycode, string conflictcontrol, string conflictname)
endevent
endstate
state oid_keyalignmentmenu
event onhighlightst()
endevent
event onkeymapchangest(int keycode, string conflictcontrol, string conflictname)
endevent
endstate
state oid_keyhideui
event onhighlightst()
endevent
event onkeymapchangest(int keycode, string conflictcontrol, string conflictname)
endevent
endstate
state oid_osa_keyup
event onhighlightst()
endevent
event onkeymapchangest(int keycode, string conflictcontrol, string conflictname)
endevent
endstate
state oid_osa_keydown
event onhighlightst()
endevent
event onkeymapchangest(int keycode, string conflictcontrol, string conflictname)
endevent
endstate
state oid_osa_keyleft
event onhighlightst()
endevent
event onkeymapchangest(int keycode, string conflictcontrol, string conflictname)
endevent
endstate
state oid_osa_keyright
event onhighlightst()
endevent
event onkeymapchangest(int keycode, string conflictcontrol, string conflictname)
endevent
endstate
state oid_osa_keytog
event onhighlightst()
endevent
event onkeymapchangest(int keycode, string conflictcontrol, string conflictname)
endevent
endstate
state oid_osa_keyyes
event onhighlightst()
endevent
event onkeymapchangest(int keycode, string conflictcontrol, string conflictname)
endevent
endstate
state oid_osa_keyend
event onhighlightst()
endevent
event onkeymapchangest(int keycode, string conflictcontrol, string conflictname)
endevent
endstate
state oid_osa_resetkeys
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_userumble
event onhighlightst()
endevent
event onselectst()
endevent
endstate
function drawautocontrolpage()
endfunction
state oid_autospeedcontrol
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_autospeedcontrolintervalmin
event onhighlightst()
endevent
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
endstate
state oid_autospeedcontrolintervalmax
event onhighlightst()
endevent
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
endstate
state oid_autospeedcontrolexcitementmin
event onhighlightst()
endevent
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
endstate
state oid_autospeedcontrolexcitementmax
event onhighlightst()
endevent
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
endstate
state oid_npcsceneduration
event onhighlightst()
endevent
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
endstate
state oid_endnpcsceneonorgasm
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_navigationdistancemax
event onhighlightst()
endevent
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
endstate
state oid_useautomodealways
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_useautomodesolo
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_useautomodedominant
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_useautomodesubmissive
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_useautomodevanilla
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_automodelimittonavigationdistance
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_useautomodefades
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_automodeanimdurationmin
event onhighlightst()
endevent
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
endstate
state oid_automodeanimdurationmax
event onhighlightst()
endevent
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
endstate
state oid_automodeforeplaychance
event onhighlightst()
endevent
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
endstate
state oid_automodeforeplaythresholdmin
event onhighlightst()
endevent
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
endstate
state oid_automodeforeplaythresholdmax
event onhighlightst()
endevent
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
endstate
state oid_automodepulloutchance
event onhighlightst()
endevent
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
endstate
state oid_automodepulloutthresholdmin
event onhighlightst()
endevent
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
endstate
state oid_automodepulloutthresholdmax
event onhighlightst()
endevent
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
endstate
function drawcamerapage()
endfunction
state oid_usefreecam
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_freecamfov
event onhighlightst()
endevent
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
endstate
state oid_freecamspeed
event onhighlightst()
endevent
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
endstate
state oud_usescreenshake
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_forcefirstpersononend
event onhighlightst()
endevent
event onselectst()
endevent
endstate
function drawexcitementpage()
endfunction
function onoptionhighlightexcitement(int option)
endfunction
function onoptionslideropenexcitement(int option)
endfunction
function onoptionslideracceptexcitement(int option, float value)
endfunction
state oid_maleexcitementmult
event onhighlightst()
endevent
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
endstate
state oid_femaleexcitementmult
event onhighlightst()
endevent
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
endstate
state oid_excitementdecayrate
event onhighlightst()
endevent
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
endstate
state oid_excitementdecaygraceperiod
event onhighlightst()
endevent
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
endstate
state oid_enableplayerbar
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_enablenpcbar
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_autohidebar
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_matchbarcolortogender
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_endonplayerorgasm
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_endonmaleorgasm
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_endonfemaleorgasm
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_endonallorgasm
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_slowmoonorgasm
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_bluronorgasm
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_autoclimaxanimations
event onhighlightst()
endevent
event onselectst()
endevent
endstate
function drawgenderrolespage()
endfunction
state oid_intendedsexonly
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_playeralwaysdomstraight
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_playeralwayssubstraight
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_playeralwaysdomgay
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_playeralwayssubgay
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_playerselectrolestraight
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_playerselectrolegay
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_playerselectrolethreesome
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_unequipstraponifnotneeded
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_defaultstrapon
event onhighlightst()
endevent
event onmenuopenst()
endevent
event onmenuacceptst(int index)
endevent
event ondefaultst()
endevent
endstate
state oid_playerstrapon
event onhighlightst()
endevent
event onmenuopenst()
endevent
event onmenuacceptst(int index)
endevent
event ondefaultst()
endevent
endstate
state oid_usesossex
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_usetngsex
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_futausemalerole
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_futausemaleexcitement
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_futausemaleclimax
event onhighlightst()
endevent
event onselectst()
endevent
endstate
function drawfurniturepage()
endfunction
state oid_usefurniture
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_selectfurniture
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_furnituresearchdistance
event onhighlightst()
endevent
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
endstate
state oid_resetclutter
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_resetclutterradius
event onhighlightst()
endevent
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
endstate
state oid_bedrealignment
event onhighlightst()
endevent
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
endstate
state oid_bedoffset
event onhighlightst()
endevent
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
endstate
function drawundressingpage()
endfunction
state oid_fullyundressatstart
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_fullyundressmidscene
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_partialundressing
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_animateredress
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_removeweaponsatstart
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_removeweaponswithslot
event onhighlightst()
endevent
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
endstate
state oid_undresswigs
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_undressabout
event onhighlightst()
endevent
endstate
function drawexpressionpage()
endfunction
state oid_expressiondurationmin
event onhighlightst()
endevent
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
endstate
state oid_expressiondurationmax
event onhighlightst()
endevent
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
endstate
state oid_defaulttonguemale
event onhighlightst()
endevent
event onmenuopenst()
endevent
event onmenuacceptst(int index)
endevent
event ondefaultst()
endevent
endstate
state oid_defaulttonguefemale
event onhighlightst()
endevent
event onmenuopenst()
endevent
event onmenuacceptst(int index)
endevent
event ondefaultst()
endevent
endstate
state oid_playertongue
event onhighlightst()
endevent
event onmenuopenst()
endevent
event onmenuacceptst(int index)
endevent
event ondefaultst()
endevent
endstate
function drawsoundpage()
endfunction
function onoptionhighlightsound(int option)
endfunction
function onoptionselectsound(int option)
endfunction
function onoptionmenuopensound(int option)
endfunction
function onoptionmenuacceptsound(int option, int index)
endfunction
function onoptiondefaultsound(int option)
endfunction
state oid_moanintervalmin
event onhighlightst()
endevent
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
endstate
state oid_moanintervalmax
event onhighlightst()
endevent
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
endstate
state oid_moanvolume
event onhighlightst()
endevent
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
endstate
state oid_maledialoguecountdownmin
event onhighlightst()
endevent
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
endstate
state oid_maledialoguecountdownmax
event onhighlightst()
endevent
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
endstate
state oid_femaledialoguecountdownmin
event onhighlightst()
endevent
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
endstate
state oid_femaledialoguecountdownmax
event onhighlightst()
endevent
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
endstate
state oid_soundvolume
event onhighlightst()
endevent
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
endstate
function drawalignmentpage()
endfunction
state oid_disablescaling
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_disableschlongbending
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_alignmentgroupbysex
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_alignmentgroupbyheight
event onhighlightst()
endevent
event onselectst()
endevent
endstate
state oid_alignmentgroupbyheels
event onhighlightst()
endevent
event onselectst()
endevent
endstate
function drawactorspage()
endfunction
function onoptionhighlightactors(int option)
endfunction
function onoptionselectactors(int option)
endfunction
function onoptionslideropenactors(int option)
endfunction
function onoptionslideracceptactors(int option, float value)
endfunction
function onoptionmenuopenactors(int option)
endfunction
function onoptionmenuacceptactors(int option, int index)
endfunction
function onoptiondefaultactors(int option)
endfunction
function drawdebugpage()
endfunction
function onoptionhighlightdebug(int option)
endfunction
function onoptionselectdebug(int option)
endfunction
function openequipobjectmenu(int formid, string type)
endfunction
function setequipobjectid(int option, int formid, string type, int index)
endfunction
function setequipobjectidst(int formid, string type, int index)
endfunction
function setequipobjectidtodefault(int option, int formid, string type)
endfunction
function setequipobjectidtodefaultst(int formid, string type)
endfunction
function openvoicesetmenu(int formid)
endfunction
function setvoiceset(int option, int formid, int index)
endfunction
function setvoicesettodefault(int option, int formid)
endfunction
function drawpage(int page)
endfunction
function drawpagetoptobottom(int page)
endfunction
function onoptionhighlightrefactored(int option)
endfunction
function onoptionselectrefactored(int option)
endfunction
function onoptionslideropenrefactored(int option)
endfunction
function onoptionslideracceptrefactored(int option, float value)
endfunction
function onoptionmenuopenrefactored(int option)
endfunction
function onoptionmenuacceptrefactored(int option, int index)
endfunction
event onoptioninputaccept(int option, string text)
endevent
event onoptionkeymapchange(int option, int keycode, string conflictcontrol, string conflictname)
endevent
function onoptiondefaultrefactored(int option)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1