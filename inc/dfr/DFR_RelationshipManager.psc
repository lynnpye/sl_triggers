scriptname dfr_relationshipmanager extends quest conditional
globalvariable property gamedayspassed auto
globalvariable property debugmode auto
dfr_events property events auto
dfr_rules property rules auto
_dfdealubercontroller property deals auto
_dflowmcm property config auto
dfr_collar property collar auto
quest property slaveryintro auto
int property slaverymethod auto hidden conditional
int property favour auto hidden conditional
globalvariable property favourglobal auto
globalvariable property targetseverity auto
bool property busy = false auto hidden conditional
bool property servicespaused auto hidden conditional
int property numfavourlevels = 4 auto hidden
float property lastserviced auto hidden
float property recentlyfavoured auto hidden conditional
float property lastfavoured = -1.0 auto hidden
float property forcedeventtimer = 0.0 auto hidden conditional
float property apologytimer = 0.0 auto hidden conditional
float property numservicestoseverity hidden
float function get()
endfunction
function set(float afvalue)
endfunction
endproperty
float property serviceruletimer = 0.0 auto hidden
int property favourincrement = 10 auto hidden
int property favourdecrement = 10 auto hidden
int property favourdailydecay = 10 auto hidden
int property favourdailydecayslave = 20 auto hidden
int property favourdailydecaydealprevention = 2 auto hidden
float property remembersfor = 30.0 auto hidden
int[] property forcedpunishchances auto hidden
int property recentlyfavouredduration = 3 auto hidden
int property servicecooldown = 4 auto hidden
int property maxservicerules = 10 auto hidden
bool property allowforcedevents = true auto hidden conditional
float property forcedservicecooldown = 8.0 auto hidden
float property forcedpunishmentcooldown = 0.25 auto hidden
float property servicerulecooldownmin = 2.0 auto hidden
float property servicerulecooldownmax = 3.0 auto hidden
float property timetoapologise = 2.0 auto hidden
dfr_relationshipmanager function get() global
endfunction
event oninit()
endevent
function maintenance()
endfunction
function setuppunishchances()
endfunction
function setstageregular(actor akmaster)
endfunction
function setupslavery(actor akmaster, int aimethod)
endfunction
function completeslaverysetup()
endfunction
function decfavour(int aiseverity = 1)
endfunction
function incfavour(int aiseverity = 1)
endfunction
function savefavour(actor akmaster)
endfunction
function checkandclearfavour(actor akmaster)
endfunction
bool function isslave()
endfunction 
string function getsubject()
endfunction
function refreshfavourdailydecaytimer()
endfunction
function restartpolling()
endfunction
event onupdategametime()
endevent
function checkfavour()
endfunction
int function getfavourlevel()
endfunction
bool function hashighfavour()
endfunction
bool function haslowfavour()
endfunction
int[] function createfavourarray()
endfunction
string function selectevent(string astype, int aiseverity, bool abrulesonly, string[] asexclude)
endfunction
function onlocationchange(location aknewlocation)
endfunction
function setupdialogue()
endfunction
function delayforcedevent(float aitime)
endfunction
bool function pauseservices(string askey)
endfunction
function resumeservices(string askey)
endfunction
function acceptevent(string asid, int aicontext)
endfunction
function refuseevent(string asid, int aicontext)
endfunction
function completeevent(string asid)
endfunction
function failevent(string asid)    
endfunction
function neutralcomplete(string asid)
endfunction
function escalate(int aiamount = 1)
endfunction
function deescalate(int aiamount = 1)
endfunction
function settargetseverity()
endfunction
int function getmaxseverity()
endfunction
int function gettargetseverity()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1