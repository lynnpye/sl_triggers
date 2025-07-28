scriptname othreadbuilder
int function create(actor[] actors) global native
function setdominantactors(int builderid, actor[] actors) global native
function setfurniture(int builderid, objectreference furnitureref) global native
function setduration(int builderid, float duration) global native
function setstartinganimation(int builderid, string animation) global native
function addstartinganimation(int builderid, string animation, float duration = 0.0, bool navigateto = false) global native
function setstartingsequence(int builderid, string sequence) global native
function concatstartingsequence(int builderid, string sequence, bool navigateto = false) global native
function endaftersequence(int buidlerid) global native
function undressactors(int builderid) global native
function noautomode(int builderid) global native
function noplayercontrol(int builderid) global native
function noundressing(int builderid) global native
function nofurniture(int builderid) global native
function setmetadata(int builderid, string[] metadata) global native
function setmetadatacsv(int builderid, string metadata) global native
int function start(int builderid) global native
function cancel(int builderid) global native
;This file was cleaned with PapyrusSourceHeadliner 1