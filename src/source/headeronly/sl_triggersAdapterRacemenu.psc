scriptname sl_triggersadapterracemenu
int function getnumbodyoverlays() global
endfunction
int function getnumhandoverlays() global
endfunction
int function getnumfeetoverlays() global
endfunction
int function getnumfaceoverlays() global
endfunction
string function getnodeoverridestring(objectreference ref, bool isfemale, string node, int _key, int index) global
endfunction
function addnodeoverridefloat(objectreference ref, bool isfemale, string node, int _key, int index, float value, bool persist) global
endfunction
function addnodeoverrideint(objectreference ref, bool isfemale, string node, int _key, int index, int value, bool persist) global
endfunction
function addnodeoverridebool(objectreference ref, bool isfemale, string node, int _key, int index, bool value, bool persist) global
endfunction
function addnodeoverridestring(objectreference ref, bool isfemale, string node, int _key, int index, string value, bool persist) global
endfunction
function addnodeoverridetextureset(objectreference ref, bool isfemale, string node, int _key, int index, textureset value, bool persist) global
endfunction
function applynodeoverrides(objectreference ref) global
endfunction
function removeallnodenameoverrides(objectreference ref, bool isfemale, string node) global
endfunction
function addoverlays(objectreference ref) global
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1