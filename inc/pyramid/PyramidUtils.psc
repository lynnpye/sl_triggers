scriptname pyramidutils hidden 
float function getversion() global
endfunction
function setactorcalmed(actor akactor, bool abcalmed) global native
function setactorfrozen(actor aktarget, bool abfrozen) global native
actor[] function getdetectedby(actor akactor) global native
form[] function getitemsbykeyword(objectreference akcontainer, keyword[] akkeywords, bool abmatchall = false) global native
form[] function filterformsbykeyword(form[] akforms, keyword[] akkeywords, bool abmatchall = false, bool abinvert = false) global native
form[] function filterformsbygoldvalue(form[] akforms, int aivalue, bool abgreaterthan = true, bool abequal = true) global native
form[] function filterbyenchanted(objectreference akcontainer, form[] akforms, bool abenchanted = true) global native
int function removeforms(objectreference akfromcont, form[] akforms, objectreference aktocont = none) global native
actor function getplayerspeechtarget() global native
string function replaceat(string asstr, int aiindex, string asreplace) global native
string function getbuttonfordxscancode(int aicode) global native
function registerforallalphanumerickeys(form akform) global
endfunction
bool function applyexpressionpreset(actor akactor, float[] aaexpression, bool abopenmouth, int exprpower, float exprstrmodifier, float modstrmodifier, float phstrmodifier, float afspeed, int aidelay)  global native 
bool function setphonememodifiersmooth(actor akactor, int aimode, int aid1, int aiid2, int aivalue, float afspeed, int aidelay) global native
bool function setexpressionsmooth(actor akactor, int aimood, int aistrength, int aicurrentstrength, float afmodifier, float afspeed, int aidelay) global native
bool function resetmfgsmooth(actor akactor, int aimode, float afspeed, int aidelay) global native
int function getphonemevalue(actor act, int id) global native
int function getmodifiervalue(actor act, int id) global native
int function getexpressionvalue(actor act) global native
int function getexpressionid(actor act) global native
;This file was cleaned with PapyrusSourceHeadliner 1