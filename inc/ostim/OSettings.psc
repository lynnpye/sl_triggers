scriptname osettings
function menuopened() global native
int function getsettingpagecount() global native
string function getsettingpagename(int page) global native
int function getsettingpagedisplayorder(int page) global native
int function getsettinggroupcount(int page) global native
string function getsettinggroupname(int page, int group) global native
int function getsettinggroupdisplayorder(int page, int group) global native
int function getsettingcount(int page, int group) global native
string function getsettingname(int page, int group, int setting) global native
string function getsettingtooltip(int page, int group, int setting) global native
int function getsettingtype(int page, int group, int setting) global native
bool function issettingenabled(int page, int group, int setting) global native
bool function issettingactivatedbydefault(int page, int group, int setting) global native
bool function issettingactivated(int page, int group, int setting) global native
bool function togglesetting(int page, int group, int setting) global native
float function getdefaultsettingvalue(int page, int group, int setting) global native
float function getcurrentsettingvalue(int page, int group, int setting) global native
float function getsettingvaluestep(int page, int group, int setting) global native
float function getminsettingvalue(int page, int group, int setting) global native
float function getmaxsettingvalue(int page, int group, int setting) global native
bool function setsettingvalue(int page, int group, int setting, float value) global native
int function getdefaultsettingindex(int page, int group, int setting) global native
int function getcurrentsettingindex(int page, int group, int setting) global native
string function getcurrentsettingoption(int page, int group, int setting) global native
string[] function getsettingoptions(int page, int group, int setting) global native
bool function setsettingindex(int page, int group, int setting, int index) global native
string function getdefaultsettingtext(int page, int group, int setting) global native
string function getcurrentsettingtext(int page, int group, int setting) global native
bool function setsettingtext(int page, int group, int setting, string text) global native
int function getdefaultsettingkey(int page, int group, int setting) global native
int function getcurrentsettingkey(int page, int group, int setting) global native
bool function setsettingkey(int page, int group, int setting, int keycode) global native
bool function clicksetting(int page, int group, int setting) global native
;This file was cleaned with PapyrusSourceHeadliner 1