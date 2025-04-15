scriptname animspeedhelper hidden
int function getversion() global native
function setanimationspeed(actor target, float scale, float transition, int absolute) global native
float function getanimationspeed(actor target, int absolute) global native
function resettransition(actor target) global native
string function getanimationeventname(actor target) global native
float function getanimationeventelapsed(actor target) global native
function warpanimation(actor target, float amount) global native
function resetall() global native
;This file was cleaned with PapyrusSourceHeadliner 1