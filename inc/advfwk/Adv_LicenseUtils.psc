scriptname adv_licenseutils extends quest  
adv_interfacelicense_base property activeinterface auto hidden
int property interfaceselected auto hidden
globalvariable[] property statusglobals auto
function maintenance()
endfunction
adv_licenseutils function get() global
endfunction
bool function licensesavailable()
endfunction
function give(int aitype, int aiterm = 0, actor akissuer = none, bool abpay = false)
endfunction
bool function hasvalid(int aitype)
endfunction
function remove(int aitype)
endfunction
bool function isenabled(int aitype)
endfunction
bool function isvalid(objectreference akinstance)
endfunction
int[] function getstatuses()
endfunction
function updatestatus()
endfunction
state active
bool function licensesavailable()
endfunction
function give(int aitype, int aiterm = 0, actor akissuer = none, bool abpay = false)
endfunction
bool function hasvalid(int aitype)
endfunction
function remove(int aitype)
endfunction
bool function isenabled(int aitype)
endfunction
bool function isvalid(objectreference akinstance)
endfunction
int[] function getstatuses()
endfunction
function updatestatus()
endfunction
endstate
;This file was cleaned with PapyrusSourceHeadliner 1