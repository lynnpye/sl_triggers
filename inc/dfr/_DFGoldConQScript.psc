scriptname _dfgoldconqscript extends quest  conditional
qf__gift_09000d62 property q auto
dfr_licenses property licenses auto 
message property _dflowdebtcreditmsg0 auto
message property _dflowdebtcreditmsg1 auto
message property _dflowdebtcreditmsg2 auto
miscobject property gold001 auto
miscobject property _dfcred001 auto
globalvariable property _dwill auto
globalvariable property _dflowdebt auto
float property decay auto conditional
float property redgoldmod auto conditional ; modifier for reducegold
int property credit auto conditional
int property credtoleave auto conditional
int property agreedgold auto conditional
int property agreedgoldslavedefault auto
int property agreedgolddefault auto
int property agreedgoldmin auto
int property agreedgoldmax auto
int property askformore auto conditional
bool property stay0 auto conditional ; if player loses all gold it won't be replaced.
bool property knockdown auto conditional 
bool property other auto conditional 
bool property credtoleavebool auto conditional
bool property active auto conditional  ; if gold control is enabled in mcm (means enabled)
bool property enabled auto conditional ; if gold control is currently running (means active)
bool property isenabledforcedlicensecontrol auto
bool property wasactive auto
bool property wasenabled auto
int property hadgold auto
_dfgoldconqscript function get() global
endfunction
function resetit()
endfunction
function startit()
endfunction
function endit()
endfunction
function enditnocredit()
endfunction
function coinflip()
endfunction
function addcredit(int surpluscash)
endfunction
function block(string askey)
endfunction
function unblock(string askey)
endfunction
function recalc() ; occurs on location change, or if you talk to the follower about debt.
endfunction
function rebalancedebtandcredit()
endfunction
function incagreedgold(int a)
endfunction
function resetcurrentgold()
endfunction
function resetagreedgold() ; use this only when sleeping
endfunction
function addcreditnoti(int n)
endfunction
function removecreditnoti(int n)
endfunction
function followerknockeddown()
endfunction
function liveslost()
endfunction
function pause()
endfunction
function unpause()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1