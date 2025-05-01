scriptname slaconfigscr extends ski_configbase
bool property mbonusesslgender = true auto hidden
float property timeratehalflife = 2.0 auto hidden
bool property bdisabled = false auto hidden
float property cellscanfreq = 30.0 auto hidden
float property defaultexposurerate = 2.0 auto hidden
bool property enablenotifications = true auto hidden
bool property femaleanimation = false auto hidden
referencealias property follower auto
bool property isdesirespell auto
bool property isextendednpcnaked auto
bool property isnakedonly = false auto hidden
bool property isusesos auto
keyword property karmorcuirass auto
keyword property kclothingbody auto
bool property maleanimation = false auto hidden
int property notificationkey = 49 auto hidden
int property slaarousalofmostarousedactorinloc auto
actor property slamostarousedactorinlocation auto hidden
actor property slanakedactor auto hidden
actor property slapuppetactor auto
int[] property slaslotmaskvalues auto hidden
slainternalscr property slautil auto
int property smallupdatesperfull = 1 auto hidden
bool property uselos = true auto hidden
bool property wantspurging = false auto hidden
int function getversion()
endfunction
function onversionupdate(int newversion)
endfunction
function ongamereload()
endfunction
function resettodefault()
endfunction
function onconfigopen()
endfunction
function onconfigclose()
endfunction
function onpagereset(string page)
endfunction
function addoptionhelper(sla_pluginbase plugin, int option)
endfunction
actor function getsecondarytargetactor()
endfunction
function displaystatus()
endfunction
function displayactorstatus(actor who, bool editable)
endfunction
function displaypuppetmaster()
endfunction
function displayarmorlist()
endfunction
function displaywornitems(actor who)
endfunction
function updatewornitemstates(actor who)
endfunction
function getbikiniarmorsfortargetactor(actor who)
endfunction
function addslidersforbodyitem()
endfunction
function addtogglesforbodyitem()
endfunction
function onoptionmenuopen(int option)
endfunction
function onoptionmenuaccept(int option, int index)
endfunction
function onoptioninputopen(int option)
endfunction
function onoptioninputaccept(int option, string value)
endfunction
function onoptionselect(int option)
endfunction
function onoptionslideropen(int option)
endfunction
function onoptionslideraccept(int option, float value)
endfunction
function onoptionkeymapchange(int option, int keycode, string conflictingitem, string conflictname)
endfunction
function onoptionhighlight(int option)
endfunction
function onoptiondefault(int option)
endfunction
function updatenakedkeywords(armor item, int value)
endfunction
function updatebikinikeywords(form item, int value)
endfunction
function updatesexykeywords(armor item, int value)
endfunction
function updateslootykeywords(armor item, int value)
endfunction
function updateillegalkeywords(armor item, int value)
endfunction
function updateposhkeywords(armor item, int value)
endfunction
function updateraggedkeywords(armor item, int value)
endfunction
function updateheelskeywords(armor item, int value)
endfunction
function updatewearablestate(form item, string keyvalue, int statevalue)
endfunction
function restorekeywords(string keyvalue, keyword wordvalue)
endfunction
int function togglebodyarmorvalue(int value, string keytag)
endfunction
form[] function getequippedarmors(actor who)
endfunction
function initslotmaskvalues()
endfunction
function resetpagenames()
endfunction
function resetkeys()
endfunction
function resetkeywords()
endfunction
function resetgenderpreferencelist()
endfunction
function resetconstants()
endfunction
function clearactordata()
endfunction
function clearalldata()
endfunction
function exportsettings()
endfunction
function importsettings()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1