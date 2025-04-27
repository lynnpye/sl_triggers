scriptname qf__dflowdealcontroller_0a01c86d extends quest hidden conditional
dfr_events property events auto
function prep()
endfunction
function persistbuyoutdecision()
endfunction
function recalculatedealcosts()
endfunction
float function setdealbuyout(float now, string dealname, globalvariable timer, globalvariable targetprice)
endfunction
function updateit()
endfunction
function dealadd(int a)
endfunction
function dealmaxadd(int a)
endfunction
function res()
endfunction
int function selectrandomactivedeal()
endfunction
globalvariable function getdealtimer(int dealnumber)
endfunction
function addrndday()
endfunction
function adddaytotimer(globalvariable timer)
endfunction
function extendrandomdeal()
endfunction
function extenddeal(int dealnumber) 
endfunction
function extenddealtimer(globalvariable dealtimer)
endfunction
function savetimes()
endfunction
function loadtimes()
endfunction
function resetalldeals()
endfunction
function addrandomdeal()
endfunction
function removedevicebyindex(int index)
endfunction
function pickrandomdeal()
endfunction
function pickanyrandomdeal()
endfunction
function acceptpendingdeal()
endfunction
function rejectpendingdeal()
endfunction
bool function acceptrule(string asid)
endfunction
function refuserule(string asid)
endfunction
function resetrule(string asid)
endfunction
function buyout(int aiindex)
endfunction
_ldc property ldc auto
globalvariable property _dflowdealbaseprice auto ; the buyout cost
globalvariable property _dflowdealbasedebt auto ; the relief amount
globalvariable property _dflowdealmulti auto
globalvariable property _dflowdealbasedays auto
string[] property dealnames auto
globalvariable[] property dealprices auto
globalvariable[] property dealtimers auto
bool property finishedslaveryrules auto hidden conditional
bool property inenslavementsetup auto hidden conditional
float property rejectrulechance auto hidden
globalvariable property gamedayspassed auto
globalvariable property _dfcostscale auto
globalvariable property _dffatigue auto
globalvariable property _dffatiguerate auto
globalvariable property _dflowdebtperday auto
globalvariable property _dflowexpensivedebts auto
globalvariable property _dfdeepdebtdifficulty auto
quest property ubercontroller auto
quest property dealo  auto 
quest property dealb  auto 
quest property dealh  auto 
quest property dealp  auto 
quest property dealsq auto 
quest property dealm1 auto 
quest property dealm2 auto 
quest property dealm3 auto 
quest property dealm4 auto 
quest property dealm5 auto 
message property msg  auto  
_dftools property tool auto
int property deals = 0 auto  conditional
int property dealsmax = 0 auto  conditional ; number of maxed out deals.
int property dealomax  auto conditional
bool property dealo1 auto conditional
bool property dealo2 auto conditional
int property dealbmax  auto conditional
bool property dealb1 auto conditional
bool property dealb2 auto conditional
int property dealhmax  auto conditional
bool property dealh1 auto conditional
bool property dealh2 auto conditional
int property dealpmax  auto conditional
int property dealsqmax  auto conditional
string property newdeal auto conditional
string property selectedruleid auto conditional
actor property playerref auto
armor property item1 auto
armor property item1r auto
zadlibs property libs auto
float property dealbias = 50.0 auto
float property dealdebtrelief auto
float property dealbuyoutprice auto
float property dealearlyoutprice auto
float property expensivedebtcount auto
miscobject property gold auto
globalvariable property willpower auto
;This file was cleaned with PapyrusSourceHeadliner 1