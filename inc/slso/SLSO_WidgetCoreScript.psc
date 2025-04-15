scriptname slso_widgetcorescript extends ski_widgetbase
float property width
float function get()
endfunction
function set(float a_val)
endfunction
endproperty
int property backgroundcolor
int function get()
endfunction
function set(int a_val)
endfunction
endproperty
float property backgroundalpha
float function get()
endfunction
function set(float a_val)
endfunction
endproperty
float property borderwidth
float function get()
endfunction
function set(float a_val)
endfunction
endproperty
int property bordercolor
int function get()
endfunction
function set(int a_val)
endfunction
endproperty
float property borderalpha
float function get()
endfunction
function set(float a_val)
endfunction
endproperty
bool property borderrounded
bool function get()
endfunction
function set(bool a_val)
endfunction
endproperty
float property paddingtop
float function get()
endfunction
function set(float a_val)
endfunction
endproperty
float property paddingright
float function get()
endfunction
function set(float a_val)
endfunction
endproperty
float property paddingbottom
float function get()
endfunction
function set(float a_val)
endfunction
endproperty
float property paddingleft
float function get()
endfunction
function set(float a_val)
endfunction
endproperty
int property labeltextcolor
int function get()
endfunction
function set(int a_val)
endfunction
endproperty
float property labeltextsize
float function get()
endfunction
function set(float a_val)
endfunction
endproperty
int property valuetextcolor
int function get()
endfunction
function set(int a_val)
endfunction
endproperty
float property valuetextsize
float function get()
endfunction
function set(float a_val)
endfunction
endproperty
float property iconsize
float function get()
endfunction
function set(float a_val)
endfunction
endproperty
int property iconcolor
int function get()
endfunction
function set(int a_val)
endfunction
endproperty
float property iconalpha
float function get()
endfunction
function set(float a_val)
endfunction
endproperty
float property iconspacing
float function get()
endfunction
function set(float a_val)
endfunction
endproperty
float property meterscale
float function get()
endfunction
function set(float a_val)
endfunction
endproperty
int property metercolora
int function get()
endfunction
function set(int a_val)
endfunction
endproperty
int property metercolorb
int function get()
endfunction
function set(int a_val)
endfunction
endproperty
float property meteralpha
float function get()
endfunction
function set(float a_val)
endfunction
endproperty
float property meterspacing
float function get()
endfunction
function set(float a_val)
endfunction
endproperty
int property meterflashcolor
int function get()
endfunction
function set(int a_val)
endfunction
endproperty
string property labeltext
string function get()
endfunction
function set(string a_val)
endfunction
endproperty
string property labeltextfont
string function get()
endfunction
function set(string a_val)
endfunction
endproperty
string property valuetext
string function get()
endfunction
function set(string a_val)
endfunction
endproperty
string property valuetextfont
string function get()
endfunction
function set(string a_val)
endfunction
endproperty
string property textalign
string function get()
endfunction
function set(string a_val)
endfunction
endproperty
string property iconsource
string function get()
endfunction
function set(string a_val)
endfunction
endproperty
string property iconname
string function get()
endfunction
function set(string a_val)
endfunction
endproperty
string property iconalign
string function get()
endfunction
function set(string a_val)
endfunction
endproperty
string property meterfillmode
string function get()
endfunction
function set(string a_val)
endfunction
endproperty
event onwidgetinit()
endevent
event onwidgetreset()
endevent
event onupdate()
endevent
string function getwidgetsource()
endfunction
string function getwidgettype()
endfunction
function setpadding(float a_paddingtop, float a_paddingright, float a_paddingbottom, float a_paddingleft)
endfunction
function settexts(string a_labeltext, string a_valuetext)
endfunction
function setmetercolors(int a_metercolora, int a_metercolorb)
endfunction
function setmeterpercent(float a_percent, bool a_force = false)
endfunction
function startmeterflash(bool a_force = false)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1