scriptname odata
int function getundressingslotmask() global native
function setundressingslotmask(int mask) global native
string[] function pairstonames(string[] pairs) global native
string[] function getequipobjecttypes() global native
string[] function getequipobjectpairs(int formid, string type) global native
string function getequipobjectname(int formid, string type) global native
function setequipobjectid(int formid, string type, string id) global native
string[] function getvoicesetpairs() global native
string function getvoicesetname(int formid) global native
function setvoiceset(int formid, string voice) global native
string[] function getactions() global native
float function getactionstimulation(int role, int formid, string actn) global native
function setactionstimulation(int role, int formid, string actn, float stimulation) global native
float function getactionmaxstimulation(int role, int formid, string actn) global native
function setactionmaxstimulation(int role, int formid, string actn, float stimulation) global native
float function getactiondefaultstimulation(int role, string actn) global native
function resetactionstimulation(int role, int formid, string actn) global native
float function getactiondefaultmaxstimulation(int role, string actn) global native
function resetactionmaxstimulation(int role, int formid, string actn) global native
string[] function getevents() global native
float function geteventstimulation(int role, int formid, string evt) global native
function seteventstimulation(int role, int formid, string evt, float stimulation) global native
float function geteventmaxstimulation(int role, int formid, string evt) global native
function seteventmaxstimulation(int role, int formid, string evt, float stimulation) global native
float function geteventdefaultstimulation(int role, string evt) global native
function reseteventstimulation(int role, int formid, string evt) global native
float function geteventdefaultmaxstimulation(int role, string evt) global native
function reseteventmaxstimulation(int role, int formid, string evt) global native
function resetsettings() global native
function exportsettings() global native
function importsettings() global native
string function localize(string text) global native
;This file was cleaned with PapyrusSourceHeadliner 1