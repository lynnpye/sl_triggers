scriptname _dfdealubercontroller extends quest  
_ddeal property bondagedeal auto
_ddeal property slutdeal auto ; h
_ddeal property ownershipdeal auto
_ddeal property piercingdeal auto
_ddeal property whoredeal auto ; sq
_mddeal property m1 auto ; 100
_mddeal property m2 auto ; 200
_mddeal property m3 auto ; 300
_mddeal property m4 auto ; 400
_mddeal property m5 auto ; 500
string property rejecteddeal auto 
bool property showdiagnostics auto
_dflowmoddealcontroller property mdc auto
_dftools property tool auto
qf__gift_09000d62 property dflowq auto
_dflowprops property dflowprops auto
globalvariable property _dfzero auto
globalvariable property debugmode auto 
dfr_relationshipmanager property relmanager auto
dfr_events property events auto
string property context = "deviousfollowers" auto
function startdeals()
endfunction
string function adddeal()
endfunction
bool function adddealbyid(string targetdeal, bool reducedebt = true)
endfunction
function rejectdeal(string targetdeal)
endfunction
string[] function getcandidates()
endfunction
string[] function filterbyseverity(string[] asrules, int aimode)
endfunction
function initializedeal(string asname, float afbias)
endfunction
string function pickrule(string asdeal)
endfunction
string[] function getforcedrules()
endfunction
string function pickdeal(float afbias)
endfunction
string function getpotentialdeal(float bias = 50.0)
endfunction
function makedeal(string id, bool reducedebt = true)
endfunction
int function setmodulardeal(_mddeal dealquest, int id)
endfunction
bool function checkdealopen(string id)
endfunction
bool function havenakeddeals()
endfunction
function deviceremovaldeal()
endfunction
bool function removerandomdeal()
endfunction
function removedealbyid(string asdeal)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1