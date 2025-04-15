scriptname utility hidden
string function gametimetostring(float afgametime) native global
float function getcurrentgametime() native global
float function getcurrentrealtime() native global
bool function isinmenumode() native global
int function randomint(int aimin = 0, int aimax = 100) native global
float function randomfloat(float afmin = 0.0, float afmax = 1.0) native global
function setinifloat(string ini, float value) native global
function setiniint(string ini, int value) native global
function setinibool(string ini, bool value) native global 
function setinistring(string ini, string value) native global
function wait(float afseconds) native global
function waitgametime(float afhours) native global
function waitmenumode(float afseconds) native global
string function captureframerate(int numframes) native global
function startframeratecapture() native global
function endframeratecapture() native global
float function getaverageframerate() native global
float function getminframerate() native global
float function getmaxframerate() native global
int function getcurrentmemory() native global ; must be called first, it sets up the memory stats used by the other functions
int function getbudgetcount() native global
int function getcurrentbudget(int aibudgetnumber) native global
bool function overbudget(int aibudgetnumber) native global
string function getbudgetname(int aibudgetnumber) native global
;This file was cleaned with PapyrusSourceHeadliner 1