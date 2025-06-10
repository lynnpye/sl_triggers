Scriptname sl_triggersOptional Hidden

; Optional type constants - accessible via global functions
int function TYPE_NONE() global
    return 0
endFunction

int function TYPE_BOOL() global
    return 1
endFunction

int function TYPE_INT() global
    return 2
endFunction

int function TYPE_FLOAT() global
    return 3
endFunction

int function TYPE_STRING() global
    return 4
endFunction

int function TYPE_FORM() global
    return 5
endFunction

int function TYPE_ACTIVEEFFECT() global
    return 6
endFunction

int function TYPE_ALIAS() global
    return 7
endFunction

; Factory functions - return handle to Optional object
int function CreateEmpty() global native
int function CreateBool(bool value) global native
int function CreateInt(int value) global native
int function CreateFloat(float value) global native
int function CreateString(string value) global native
int function CreateForm(Form value) global native
int function CreateActiveEffect(ActiveMagicEffect value) global native
int function CreateAlias(Alias value) global native

; Query functions
bool function IsValid(int handle) global native
int function GetType(int handle) global native
bool function IsBool(int handle) global native
bool function IsInt(int handle) global native
bool function IsFloat(int handle) global native
bool function IsString(int handle) global native
bool function IsForm(int handle) global native
bool function IsActiveEffect(int handle) global native
bool function IsAlias(int handle) global native

; Value getters
bool function GetBool(int handle) global native
int function GetInt(int handle) global native
float function GetFloat(int handle) global native
string function GetString(int handle) global native
Form function GetForm(int handle) global native
ActiveMagicEffect function GetActiveEffect(int handle) global native
Alias function GetAlias(int handle) global native

; Value setters
function SetBool(int handle, bool value) global native
function SetInt(int handle, int value) global native
function SetFloat(int handle, float value) global native
function SetString(int handle, string value) global native
function SetForm(int handle, Form value) global native
function SetActiveEffect(int handle, ActiveMagicEffect value) global native
function SetAlias(int handle, Alias value) global native

; Utility functions
function Clear(int handle) global native
function Destroy(int handle) global native

; Example usage helper functions (implemented in Papyrus)
bool function HasValue(int handle) global
    return IsValid(handle)
endFunction

string function TypeName(int handle) global
    int type = GetType(handle)
    if type == 0 ; TYPE_NONE
        return "None"
    elseif type == 1 ; TYPE_BOOL
        return "Bool"
    elseif type == 2 ; TYPE_INT
        return "Int"
    elseif type == 3 ; TYPE_FLOAT
        return "Float"
    elseif type == 4 ; TYPE_STRING
        return "String"
    elseif type == 5 ; TYPE_FORM
        return "Form"
    elseif type == 6 ; TYPE_ACTIVEEFFECT
        return "ActiveEffect"
    elseif type == 7 ; TYPE_ALIAS
        return "Alias"
    else
        return "Unknown"
    endif
endFunction