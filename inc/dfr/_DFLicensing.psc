scriptname _dflicensing extends quest
qf__gift_09000d62 property _dflow auto
_dfdealubercontroller property _dflowdealcontroller auto
_dfgoldconqscript property _dflowgoldmode auto
formlist property _dflicenselocations auto
actor property playerref auto
keyword property keywordcity auto
float property baseprice = 150.0 auto
float property markup = 10.0 auto
globalvariable property _dflicensesupplyweapon auto
globalvariable property _dflicensesupplymagic auto
globalvariable property _dflicensesupplyprotection auto ; armor or bikini
globalvariable property _dflicensesupplybikini auto
globalvariable property _dflicensesupplyarmor auto
globalvariable property _dflicensesupplyclothes auto
globalvariable property _dflicensesupplywhore auto
globalvariable property _dflicensesupplycurfew auto
globalvariable property _dflicenseenabledmagic auto
globalvariable property _dflicenseenabledprotection auto
globalvariable property _dflicensestatus auto
globalvariable property _dflicenseenablecount auto
globalvariable property _dwill auto
int property licensecount = 9 autoreadonly hidden
int property stateignore = 0 autoreadonly hidden
int property stateask = 1 autoreadonly hidden
int property statewaitgrant = 2 autoreadonly hidden
int property statewaitexpire = 3 autoreadonly hidden
int property statewaitdisable = 4 autoreadonly hidden
int property statediscover = 5 autoreadonly hidden
bool property showdiagnostics auto
bool property fixedsls auto
bool property blockedweapons auto
bool property blockedprotection auto
bool property blockedclothes auto
bool property paused auto
bool property askedforactualarmor = false auto hidden
bool property cangetbikiniarmor = false auto hidden conditional
bool property cangetactualarmor = false auto hidden conditional
bool property enabled
bool function get()
endfunction
function set(bool value)
endfunction
endproperty
bool property supplyenabled
bool function get()
endfunction
endproperty
float property licensegranttimeoutingamedays
float function get()
endfunction
endproperty
int property licensesupplyweapon 
int function get()
endfunction
function set(int value)
endfunction
endproperty
int property licensesupplymagic 
int function get()
endfunction
function set(int value)
endfunction
endproperty
int property licensesupplyprotection
int function get()
endfunction
function set(int value)
endfunction
endproperty
int property licensesupplybikini 
int function get()
endfunction
function set(int value)
endfunction
endproperty
int property licensesupplyarmor 
int function get()
endfunction
function set(int value)
endfunction
endproperty
int property licensesupplyclothes 
int function get()
endfunction
function set(int value)
endfunction
endproperty
int property licensesupplywhore 
int function get()
endfunction
function set(int value)
endfunction
endproperty
int property licensesupplycurfew 
int function get()
endfunction
function set(int value)
endfunction
endproperty
int property licensesupplyany
int function get()
endfunction
endproperty
int property will
int function get()
endfunction
endproperty
int property statusreportid
int function get()
endfunction
function set(int value)
endfunction
endproperty
int property licenseenablecount
int function get()
endfunction
function set(int value)
endfunction
endproperty
int property licenseenabledmagic
int function get()
endfunction
function set(int value)
endfunction
endproperty
int property licenseenabledprotection
int function get()
endfunction
function set(int value)
endfunction
endproperty
function startlicensing()
endfunction
function tryresumelicensing()
endfunction
function trystop()
endfunction
function endlicensing()
endfunction
function updateenablestatus(bool newenable)
endfunction
function registereventlisteners()
endfunction
function unregistereventlisteners()
endfunction
function beginfromgoldcontrol()
endfunction
function beginsupply()
endfunction
function stopsupply()
endfunction
event licenceissuehandler(form licenceform, int licencetype, int term, form requestingmod)
endevent
event licenseupdatehandler(string eventname, string strarg, float numarg, form sender)
endevent
event onupdate()
endevent
function updatelicensestates()
endfunction
function updatestatusdialogselector(int currentstage, int enabledcount, int supplycount, int suppliedcount)
endfunction
function shownwhoredialog()
endfunction
function shownclothesdialog()
endfunction
function showngoldcontroldialog()
endfunction
function pause(bool pausemod)
endfunction
function refreshslsenablestatusandresetstates()
endfunction
float function decidearmororbikinlicensesupply(int supply)
endfunction
function supplyingfollowerdismissed()
endfunction
bool function havelicense(int licenseid)
endfunction
bool function cangetlicense(int licenseid)
endfunction
bool function islicensedisabledinsls(int licenseid)
endfunction
int function getlicenseenabledinsls(int licenseid)
endfunction
function dumplicensestates()
endfunction
function requestlicence(int licenseid, int term, form issuer, bool deductgold = false)
endfunction
function chargeforlicense(int licenseid)
endfunction
function setblocklicensepurchases(bool blockpurchase = true)
endfunction
bool function islicensepurchaseblocked()
endfunction
function revokelicensebyid(int index)
endfunction
function revokealllicenses()
endfunction
function revokerandomlicense()
endfunction
function revokelicense(string licensetype)
endfunction
function populatelicenselocations()
endfunction
state busy
function tryresumelicensing()
endfunction
function trystop()
endfunction
function updatelicensestates()
endfunction
endstate
;This file was cleaned with PapyrusSourceHeadliner 1