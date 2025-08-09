scriptname sl_triggerssetup extends ski_configbase
sl_triggersmain  property slt auto
string    property currentextensionkey auto hidden
string[] property scriptslist auto hidden
function callthistoresettheoidvalueshextun()
endfunction
int function getversion()
endfunction
event onconfiginit()
endevent
event onconfigopen()
endevent
event onconfigclose()
endevent
event onpagereset(string page)
endevent
int property ptype_string = 1 autoreadonly hidden
int property ptype_int = 2 autoreadonly hidden
int property ptype_float = 3 autoreadonly hidden
int property ptype_form = 4 autoreadonly hidden
int function showattribute(string attrname, int widgetoptions, string triggerkey, string _datafile, bool _istriggerattributes)
endfunction
function showextensionsettings()
endfunction
function showextensionpage()
endfunction
function showheaderpage()
endfunction
event onoptionhighlight(int option)
endevent
event onoptiondefault(int option)
endevent
bool function dosaveandreset(int option, string jkey, bool value)
endfunction
event onoptionselect(int option)
endevent
event onoptionslideropen(int option)
endevent
event onoptionslideraccept(int option, float value)
endevent
event onoptionmenuopen(int option)
endevent
event onoptionmenuaccept(int option, int index)
endevent
event onoptionkeymapchange(int option, int keycode, string conflictcontrol, string conflictname)
endevent
event onoptioninputopen(int option)
endevent
event onoptioninputaccept(int option, string _input)
endevent
bool function isextensionpage()
endfunction
string function trigger_create()
endfunction
string[] function getextensiontriggerkeys()
endfunction
function addoid(int _oid, string _triggerkey, string _attrname)
endfunction
string function getoidtriggerkey(int _oid)
endfunction
string function getoidattributename(int _oid)
endfunction
int function getattrwidget(bool _istk, string _attr)
endfunction
int function getattrtype(bool _istk, string _attr)
endfunction
float function getattrminvalue(bool _istk, string _attr)
endfunction
float function getattrmaxvalue(bool _istk, string _attr)
endfunction
float function getattrinterval(bool _istk, string _attr)
endfunction
int function getattrdefaultvalue(bool _istk, string _attr)
endfunction
float function getattrdefaultfloat(bool _istk, string _attr)
endfunction
string function getattrdefaultstring(bool _istk, string _attr)
endfunction
string function getattrlabel(bool _istk, string _attr)
endfunction
string function getattrformatstring(bool _istk, string _attr)
endfunction
int function getattrdefaultindex(bool _istk, string _attr)
endfunction
string[] function getattrmenuselections(bool _istk, string _attr)
endfunction
int function getattrmenuselectionindex(bool _istk, string _attr, string _selection)
endfunction
bool function hasattrhighlight(bool _istk, string _attr)
endfunction
string function getattrhighlight(bool _istk, string _attr)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1