scriptname _dfpotionquest extends quest  conditional
_dftools property tool auto
qf__dflowdealcontroller_0a01c86d property dc auto
qf__gift_09000d62 property q auto
quest property dtick auto
globalvariable property gamedayspassed auto
globalvariable property _dflowpotiondeal auto
globalvariable property _dflowpotiondealevil auto
actor property playerref  auto  
actor property tempactor auto
int property nstate auto conditional
float property delay auto conditional
float property delaymin = 3.0 auto 
float property delaymax = 11.0 auto 
float property delaypenalty auto 
bool property enabled auto conditional      ; standard voluntary potion
bool property enabledevil auto conditional  ; forced potion
referencealias property _dmaster auto
referencealias property _daddicted auto
referencealias property follower auto
message property weakenmsg auto
message property gagmsg auto
message property forceddrink auto
idle property bleedoutstart auto
idle property bleedoutstop auto
armor property ropesi auto
armor property ropesr auto
miscobject property gold001 auto
scene property thescene auto
potion property _dfpotion  auto  
perk property weakened2 auto
function runscene()
endfunction
function givepotion()
endfunction
function setwaitdelay()
endfunction
function firstdelay()
endfunction
function delay()
endfunction
function weaken()
endfunction
bool function isanimating(actor who)
endfunction
function unweaken()
endfunction
function resetquest()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1