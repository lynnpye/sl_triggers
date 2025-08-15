scriptname sexlabthread extends quest
int function getthreadid()
endfunction
int property status_undef = 0 autoreadonly  ; undefined
int property status_idle = 1 autoreadonly  ; idling (inactive)
int property status_setup = 2 autoreadonly  ; preparing an animation. available data may be incomplete
int property status_inscene = 3 autoreadonly  ; playing an animation
int property status_ending = 4 autoreadonly  ; ending. data is still available but most functionality is disabled
int function getstatus()
endfunction
string function getactivescene()
endfunction
string function getactivestage()
endfunction
string[] function getplayingscenes()
endfunction
bool function resetscene(string asscene)
endfunction
function branchto(int ainextbranch)
endfunction
function skipto(string asnextstage)
endfunction
string[] function getstagehistory()
endfunction
int function getstagehistorylength()
endfunction
function stopanimation()
endfunction
bool function hastag(string astag)
endfunction
bool function hasscenetag(string astag)
endfunction
bool function hasstagetag(string astag)
endfunction
bool function isscenevaginal()
endfunction
bool function issceneanal()
endfunction
bool function issceneoral()
endfunction
bool function hascontext(string astag)
endfunction
function addcontext(string ascontext)
endfunction
function removecontext(string ascontext)
endfunction
bool function isconsent()
endfunction
function setconsent(bool abisconsent)
endfunction
int property ctype_any     = -1  autoreadonly
int property ctype_vaginal    = 1  autoreadonly ; position is being penetrated by partner
int property ctype_anal     = 2  autoreadonly ; position is being penetrated by partner
int property ctype_oral     = 3  autoreadonly ; position is licking/sucking partner
int property ctype_grinding   = 4  autoreadonly ; position is being grinded against by partner (crotch area)
int property ctype_deepthroat  = 5  autoreadonly ; implies oral, partner's penis close to/at maximum depth
int property ctype_skullfuck   = 6  autoreadonly ; positions head penetrated in an unexpected way by partner (usually gore)
int property ctype_lickingshaft = 7  autoreadonly ; position licking partners shaft
int property ctype_footjob    = 8  autoreadonly ; position pleasuring partner using at least one foot
int property ctype_handjob    = 9  autoreadonly ; position pleasuring partner using at least one hand
int property ctype_kissing    = 10  autoreadonly ; position kissing partner
int property ctype_facial    = 11  autoreadonly ; positions face in front of partner penis
int property ctype_animobjface  = 12  autoreadonly ; position mouth close to partner anim object node
int property ctype_suckingtoes = 13 autoreadonly ; position mouth close to partner toes
bool function isinteractionregistered()
endfunction
int[] function getinteractiontypes(actor akposition, actor akpartner)
endfunction
bool function hasinteractiontype(int aitype, actor akposition, actor akpartner)
endfunction
actor function getpartnerbytype(actor akposition, int aitype)
endfunction
actor[] function getpartnersbytype(actor akposition, int aitype)
endfunction
actor function getpartnerbytyperev(actor akpartner, int aitype)
endfunction
actor[] function getpartnersbytyperev(actor akpartner, int aitype)
endfunction
float function getvelocity(actor akposition, actor akpartner, int aitype)
endfunction
float function gettime()
endfunction
float function gettimetotal()
endfunction
bool function hasactor(actor akactor)
endfunction
bool function hasplayer()
endfunction
actor[] function getpositions()
endfunction
int function getpositionidx(actor akactor)
endfunction
int function getactorsex(actor akactor)
endfunction
int function getnthpositionsex(int n)
endfunction
int[] function getpositionsexes()
endfunction
bool function getsubmissive(actor akactor)
endfunction
function setissubmissive(actor akactor, bool abissubmissive)
endfunction
actor[] function getsubmissives()
endfunction
function setcustomstrip(actor akactor, int aislots, bool abweapon, bool abapplynow)
endfunction
function resetcustomstrip(actor akactor)
endfunction
bool function isundressanimationallowed(actor akactor)
endfunction
function setisundressanimationallowed(actor akactor, bool aballowed)
endfunction
bool function isredressallowed(actor akactor)
endfunction
function setisredressallowed(actor akactor, bool aballowed)
endfunction
function setactorvoice(actor akactor, string asvoice, bool abforcesilent)
endfunction
string function getactorvoice(actor akactor)
endfunction
function setactorexpression(actor akactor, string asexpression)
endfunction
string function getactorexpression(actor akactor)
endfunction
function disableorgasm(actor actorref, bool orgasmdisabled = true)
endfunction
bool function isorgasmallowed(actor actorref)
endfunction
function forceorgasm(actor actorref)
endfunction
int function getenjoyment(actor akactor)
endfunction
actor[] function canbeimpregnated(actor akactor, bool aballowfutaimpregnation, bool abfutacanpregnate, bool abcreaturecanpregnate)
endfunction
function setstrapon(actor actorref, form tostrapon)
endfunction
form function getstrapon(actor actorref)
endfunction
bool function isusingstrapon(actor actorref)
endfunction
int property pathing_disable = -1 autoreadonly ; always be teleported
int property pathing_enable = 0 autoreadonly  ; let the user config decide (default)
int property pathing_force = 1 autoreadonly   ; always try to walk unless the distance is too great
function setpathingflag(actor akactor, int aipathingflag)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1