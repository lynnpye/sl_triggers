scriptname sexlabstatistics hidden
actor[] function getalltrackedactors() native global
actor[] function getalltrackeduniqueactorssorted() native global
int property lastupdate_gametime  = 0   autoreadonly
int property secondsinscene       = 1   autoreadonly
int property xp_vaginal           = 2   autoreadonly
int property xp_anal              = 3   autoreadonly
int property xp_oral              = 4   autoreadonly
int property partnersmale         = 5   autoreadonly
int property partnersfemale       = 6   autoreadonly
int property partnersfuta         = 7   autoreadonly
int property partnerscreature     = 8   autoreadonly
int property timesoral            = 9   autoreadonly
int property timesvaginal         = 10  autoreadonly
int property timesanal            = 11  autoreadonly
int property timesmasturbated     = 12  autoreadonly
int property timessubmissive      = 13  autoreadonly
int property timesdominant        = 14  autoreadonly
int property timestotal           = 15  autoreadonly
int property sexuality            = 16  autoreadonly
int property arousal              = 17  autoreadonly
float function getstatistic(actor akactor, int id) native global
int property sexuality_hetero = 0 autoreadonly
int property sexuality_homo   = 1 autoreadonly
int property sexuality_bi     = 2 autoreadonly
int function getsexuality(actor akactor) native global
int function mapsexuality(float aisexualitystat) native global
function setcustomstatflt(actor akactor, string asstat, float afvalue) native global
function setcustomstatstr(actor akactor, string asstat, string asvalue) native global
float function getcustomstatflt(actor akactor, string asstat, float afdefault = 0.0) native global
string function getcustomstatstr(actor akactor, string asstat, string asdefault = "") native global
bool function hascustomstat(actor akactor, string asstat) native global
function deletecustomstat(actor akactor, string asstat) native global
int property enc_any      = 0 autoreadonly hidden
int property enc_victim    = 1 autoreadonly hidden
int property enc_assault   = 2 autoreadonly hidden
int property enc_submissive = 3 autoreadonly hidden
int property enc_dominant   = 4 autoreadonly hidden
actor[] function getallencounters(actor akactor) native global
actor[] function getallencounteredvictims(actor akactor) native global
actor[] function getallencounteredassailants(actor akactor) native global
actor function getmostrecentencounter(actor akactor, int aiencountertype) native global
float function getlastencountertime(actor akactor, actor akpartner) native global
int function gettimesmet(actor akactor, actor akpartner) native global
int function gettimesvictimzed(actor akactor, actor akassailant) native global
int function gettimesassaulted(actor akactor, actor akvictim) native global
int function gettimessubmissive(actor akactor, actor akpartner) native global
int function gettimesdominant(actor akactor, actor akpartner) native global
string[] function getallcustomstatids(actor akactor) native global
function setstatistic(actor akactor, int id, float afvalue) native global
function setsexuality(actor akactor, int mapping) native global
function addencounter(actor akactor, actor akpartner, int aiencountertype) native global
function resetstatistics(actor akactor) native global
;This file was cleaned with PapyrusSourceHeadliner 1