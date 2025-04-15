scriptname faction extends form hidden
bool function canpaycrimegold() native
int function getcrimegold() native
int function getcrimegoldnonviolent() native
int function getcrimegoldviolent() native
int function getinfamy() native
int function getinfamynonviolent() native
int function getinfamyviolent() native
int function getreaction(faction akother) native
int function getstolenitemvaluecrime() native
int function getstolenitemvaluenocrime() native
bool function isfactionincrimegroup(faction akother) native
bool function isplayerexpelled() native
function modcrimegold(int aiamount, bool abviolent = false) native
function modreaction(faction akother, int aiamount) native
function playerpaycrimegold(bool abremovestolenitems = true, bool abgotojail = true) native
function sendassaultalarm() native
function sendplayertojail(bool abremoveinventory = true, bool abrealjail = true) native
function setally(faction akother, bool abselfisfriendtoother = false, bool abotherisfriendtoself = false) native
function setcrimegold(int aigold) native
function setcrimegoldviolent(int aigold) native
function setenemy(faction akother, bool abselfisneutraltoother = false, bool abotherisneutraltoself = false) native
function setplayerenemy(bool abisenemy = true) native
function setplayerexpelled(bool abisexpelled = true) native
function setreaction(faction akother, int ainewvalue) native
;This file was cleaned with PapyrusSourceHeadliner 1