scriptname zadheavybondagequestscript extends quest conditional
message property customstruggleimpossiblemsg auto
message property customstrugglemsg auto
bool property disabledial auto conditional
bool property disablestruggle auto
bool property islocked auto
bool property isloose auto
bool property menumutex auto
sexlabframework property sexlab auto
int property strugglecount auto
key property devicekey auto hidden
armor property lastinventorydevice auto
armor property lastrendereddevice auto
zadlibs property libs auto
string[] property struggleidles auto
string[] property struggleidleshob auto
message property zad_devicemsg auto
function devicemenuendurebonds()
endfunction
function devicemenuext(int msgchoice)
endfunction
function devicemenupoststruggle()
endfunction
function devicemenuremove()
endfunction
function disabledialogue()
endfunction
function enabledialogue()
endfunction
function disablestruggling()
endfunction
function enablestruggling()
endfunction
function setdevicekey(key k)
endfunction
string[] function selectstrugglearray(actor akactor)
endfunction
function strugglescene(actor akactor)
endfunction
int function showdevicemenu(int msgchoice)
endfunction
function removeheavybondage(keyword kwd)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1