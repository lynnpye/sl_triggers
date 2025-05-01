scriptname dfr_outfits extends quest conditional
qf__gift_09000d62 property flow auto
actor property playerref auto
adv_outfitmanager property manager auto
dfr_licenses property licenses auto
dfr_relationshipmanager property relationship auto
globalvariable property gamedayspassed auto
globalvariable property loctransitioncooldown auto
globalvariable property targetseverity auto
globalvariable property whorearmorvalidstatus auto
float property lostarmorescalationchance = 0.5 auto hidden
bool property lostarmorescalate = false auto hidden conditional
int property currarmortype auto hidden conditional
int property numoutfitrulesactive = 0 auto hidden conditional
bool property swapoutfit = false auto hidden conditional
bool property progresstonextset auto hidden conditional
bool property bikiniarmor = false auto hidden conditional
int property swapcooldownmin = 1 auto hidden
int property swapcooldownmax = 3 auto hidden
float property swapcooldown auto hidden conditional
bool property outfitsequence = false auto hidden conditional
dfr_outfits function get() global
endfunction
function maintenance()
endfunction
function prep()
endfunction
string function getcurrentoutfit()
endfunction
event onseveritychange(int aiseverity)
endevent
function resetchange()
endfunction
function givewhorearmor(bool abpay = true, string asid = "")
endfunction
string function pickarmor()
endfunction
function checkswap()
endfunction
function setupswap()
endfunction
function completeswap()
endfunction
function undoswap()
endfunction
function swapwalkaway()
endfunction
string function getarmortype()
endfunction
bool function iswearingwhorearmor()
endfunction
function startwhorearmorrule()
endfunction
function changearmortype(int aitype)
endfunction
function togglebikiniarmor()
endfunction
function stopwhorearmorrule()
endfunction
function delayvalidationtimer()
endfunction
function log(string asmsg)
endfunction
bool function addrule(string asrule, string asoutfit, globalvariable akstatus)
endfunction
function setrule(string asrule, string asoutfit)
endfunction
bool function removerule(string asrule)
endfunction
string[] function getoutfits(string asrule)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1