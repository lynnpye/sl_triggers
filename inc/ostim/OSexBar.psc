scriptname osexbar extends ski_widgetbase
bool property fadedout auto
float property width
float function get()
endfunction
function set(float a_val)
endfunction
endproperty
float property height
float function get()
endfunction
function set(float a_val)
endfunction
endproperty
int property primarycolor
int function get()
endfunction
function set(int a_val)
endfunction
endproperty
int property secondarycolor
int function get()
endfunction
function set(int a_val)
endfunction
endproperty
int property flashcolor
int function get()
endfunction
function set(int a_val)
endfunction
endproperty
string property filldirection
string function get()
endfunction
function set(string a_val)
endfunction
endproperty
float property percent
float function get()
endfunction
function set(float a_val)
endfunction
endproperty
event onwidgetreset()
endevent
string function getwidgetsource()
endfunction
string function getwidgettype()
endfunction
bool function isextending()
endfunction
function setpercent(float a_percent, bool a_force = false)
endfunction
function forcepercent(float a_percent)
endfunction
function startflash(bool a_force = false)
endfunction
function forceflash()
endfunction
function setcolors(int a_primarycolor, int a_secondarycolor = -1, int a_flashcolor = -1)
endfunction
function transitioncolors(int a_primarycolor, int a_secondarycolor = -1, int a_flashcolor = -1, int a_duration = 1000)
endfunction
function setbarvisible(bool visible)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1