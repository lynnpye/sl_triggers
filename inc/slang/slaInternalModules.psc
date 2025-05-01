scriptname slainternalmodules hidden
int function cleanupactors(float lastupdatebefore) global native
actor[] function duplicateactorarray(actor[] actors, int count) global native
string function formathex(int formid) global native
float function getarousal(actor who) global native
string function getdynamiceffect(actor who, int number) global native
int function getdynamiceffectcount(actor who) global native
float function getdynamiceffectvalue(actor who, int number) global native
float function getdynamiceffectvaluebyname(actor who, string effectid) global native
int function getstaticeffectaux(actor who, int effectidx) global native
float function getstaticeffectauxfloat(actor who, int effectidx) global native
int function getstaticeffectcount() global native
float function getstaticeffectlimit(actor who, int effectidx) global native
float function getstaticeffectparam(actor who, int effectidx) global native
float function getstaticeffectvalue(actor who, int effectidx) global native
bool function groupeffects(actor who, int effidx1, int effidx2) global native
bool function isstaticeffectactive(actor who, int effectidx) global native
function moddynamicarousaleffect(actor who, string effectid, float modifier, float limit) global native
float function modstaticarousalvalue(actor who, int effectidx, float diff, float limit) global native
int function registerstaticeffect(string id) global native
bool function removeeffectgroup(actor who, int effidx1) global native
function setdynamicarousaleffect(actor who, string effectid, float initialvalue, int functionid, float param, float limit) global native
function setstaticarousaleffect(actor who, int effectidx, int functionid, float param, float limit, int auxilliary) global native
function setstaticarousalvalue(actor who, int effectidx, float value) global native
function setstaticauxillaryfloat(actor who, int effectidx, float value) global native
function setstaticauxillaryint(actor who, int effectidx, int value) global native
bool function trylock(int lockid) global native
function unlock(int lockid) global native
bool function unregisterstaticeffect(string id) global native
function updatesingleactorarousal(actor who, float gamedayspassed) global native
event onbeginstate()
endevent
event onendstate()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1