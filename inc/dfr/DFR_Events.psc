scriptname dfr_events extends quest conditional
referencealias property followeralias auto
dfr_relationshipmanager property relmanager auto
qf__dflowdealcontroller_0a01c86d property dealcontroller auto
_dftools property tool auto
bool property display auto hidden conditional
bool property loop auto hidden conditional
bool property allowwalkaway auto hidden conditional
globalvariable property forced auto
globalvariable property eventcontext auto
int property context_type_deals = 0 autoreadonly hidden
int property context_type_forced = 1 autoreadonly hidden
int property context_type_service = 2 autoreadonly hidden
int property context_type_apology = 3 autoreadonly hidden
int property context_type_slavery_setup = 4 autoreadonly hidden
int property context_type_challenge = 5 autoreadonly hidden
dfr_events function get() global
endfunction
function setup(string[] asevents, int aicontext, bool abincfavour = true, bool abforced = false, bool aballowwalkaway = true)
endfunction
function accept()
endfunction
function refuse()
endfunction
function activateevent(string asid)
endfunction
function deactivateevent(string asid)
endfunction
bool function isrule(string asid)
endfunction
function next()
endfunction
function gave()
endfunction
int function getcontext(string asid)
endfunction
bool function wasforced(string asid)
endfunction
string function increasesfavour(string asid)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1