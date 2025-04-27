scriptname _dtick extends quest  conditional
quest property _dflowsleep auto
_dftools property tool auto
sexlabframework property sexlab auto
zadlibs property libs auto
quest property _dflow auto
qf__gift_09000d62 property q  auto  
dialoguefollowerscript property vanilladialogfollower auto
_dflowfollowercontroller property followercontroller auto
_dflowfollowercontroller property dflowfollowercontroller auto ; duplicate of above, because i messed up and released an esp with it unset.
_dfgoldconqscript property goldcontrol auto ; not set in earlier versions - mod event code will not add gold control properly in old games.
quest property dealcontroller auto
_dflowmoddealcontroller property moddealcontroller auto
dfr_relationshipmanager property relmanager auto
dfr_services property services auto
dfr_outfits property outfits auto
dfr_locscanner property scanner auto
dfr_rules property rules auto
dfr_skincare property skincare auto
dfr_speech property speech auto
actor property playerref auto
actor property follower auto
referencealias property followeralias auto
formlist property _dfpausemodslist auto
faction property enslaved auto ; not set and hopefully, not used. probably intended to be soft-dep'd onto zap.
faction property dismissedfollowerfaction auto
faction property dmasterfaction auto
faction property dignorefaction auto
faction property denablefaction auto
armor property mittsi auto
armor property mittsr auto
armor property glovesi auto
armor property glovesr auto
armor property dealamulet auto
armor property dealcirclet auto
armor property dealring auto
miscobject property gold001 auto
keyword property newproperty  auto
keyword property _dfcrawlrequired auto
keyword property _dfslavegloves auto
keyword property _dfslavemitts auto
globalvariable property lives auto
globalvariable property _dflowlivesmax auto
globalvariable property _dffollowerhasmaxlives auto
globalvariable property _dflivesfollowerrape auto
globalvariable property _dwill auto
globalvariable property _dfminimumcontract auto
globalvariable property _dfminimumcontractremaining auto
globalvariable property _dffollowercount auto
globalvariable property _dfstanding auto
globalvariable property pplayerfollowercount auto
globalvariable property _dfseveritymitigation auto
globalvariable property _dfseveritymitigationbase auto
globalvariable property _dfslutcount auto
globalvariable property _dfmodmmepresent auto
globalvariable property _dfmodskoomawhorepresent auto
globalvariable property _dfmodslspresent auto
globalvariable property pause auto
globalvariable property _df_state2 auto
globalvariable property _df_state3 auto
globalvariable property _df_state4 auto
objectreference property getcrosshairtarget 
objectreference function get()
endfunction
endproperty
bool property ispaused
bool function get()
endfunction
endproperty
bool property notpaused
bool function get()
endfunction
endproperty
bool property runonce auto
bool property wasenslaved auto
int property suspend = 0 auto conditional
int property penslaved = 0 auto conditional
float property sluttimer auto
float property sluttimerperiod
float function get()
endfunction
endproperty
string function getscriptversionname()
endfunction
int function getscriptversion()
endfunction
function unblockevents()
endfunction
event init()
endevent
event onanimationstart(int tid, bool hasplayer)
endevent
event onanimationend(int tid, bool hasplayer)
endevent
event pausebyevent(bool pausedstate, form sender)
endevent
event ssclean(string eventname, string strarg, float numarg, form sender)
endevent
event penslave(string eventname, string strarg, float numarg, form sender)
endevent
event punenslave(string eventname, string strarg, float numarg, form sender)
endevent
event enslavefromsimpleslavery(string eventname, string strarg, float numarg, form sender)
endevent
event suspend(string eventname, string strarg, float numarg, form sender)
endevent
event resume(string eventname, string strarg, float numarg, form sender)
endevent
event handleresistancelosswithseverity(string eventnameunused, string severity, float resistanceloss, form sender)
endevent
event handleresistanceloss(string eventnameunused, string strunused, float resistanceloss, form sender)
endevent
event handleresistancegain(string eventnameunused, string strunused, float resistancegain, form sender)
endevent
event handledebtadjust(string eventnameunused, string strunused, float debtdelta, form sender)
endevent
event handleminimumcontractchange(string eventnameunused, string strunused, float durationindays, form sender)
endevent
event handleaddfollower(form sender, form followertoaddform, int debttoadd, bool forcegoldcontrolmode, float minimumcontractdays)
endevent
event handleremovefollower(form followertoremoveform)
endevent
event handlemilkdone(form who, int bottles, int boobgasmcount, int cumcount)
endevent
event handlespanks(string eventnameunused, string actorformid, float severity, form sender)
endevent
bool function waitforunpause()
endfunction
bool function waitforpause()
endfunction
function pauseworker(bool pausedstate, form sender)
endfunction
function firepauseevent(bool pauseon)
endfunction
function setminimumcontract(float durationindays)
endfunction
event rapecheck(string eventname, string argstring, float argnum, form sender)
endevent
function steal()
endfunction
bool function checkforvictimchange()
endfunction
bool function checkforfollowervictimchange()
endfunction
function checkfornewfollowers()
endfunction
float function ismmepresent()
endfunction
float function isskoomawhorepresent()
endfunction
float function isslspresent()
endfunction
function registerslsexceptions()
endfunction
event onupdate()
endevent
state inevent
event init()
endevent
event pausebyevent(bool pausedstate, form sender)
endevent
event ssclean(string eventname, string strarg, float numarg, form sender)
endevent
event penslave(string eventname, string strarg, float numarg, form sender)
endevent
event punenslave(string eventname, string strarg, float numarg, form sender)
endevent
event enslavefromsimpleslavery(string eventname, string strarg, float numarg, form sender)
endevent
event suspend(string eventname, string strarg, float numarg, form sender)
endevent
event resume(string eventname, string strarg, float numarg, form sender)
endevent
event handleresistancelosswithseverity(string eventnameunused, string severity, float resistanceloss, form sender)
endevent
event handleresistanceloss(string eventnameunused, string strunused, float resistanceloss, form sender)
endevent
event handleresistancegain(string eventnameunused, string strunused, float resistancegain, form sender)
endevent
event handledebtadjust(string eventnameunused, string strunused, float debtdelta, form sender)
endevent
event handleminimumcontractchange(string eventnameunused, string strunused, float durationindays, form sender)
endevent
event handleaddfollower(form sender, form followertoaddform, int debttoadd, bool forcegoldcontrolmode, float minimumcontractdays)
endevent
event handleremovefollower(form followertoremoveform)
endevent
event handlemilkdone(form who, int bottles, int boobgasmcount, int cumcount)
endevent
event handlespanks(string eventnameunused, string actorformid, float severity, form sender)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1