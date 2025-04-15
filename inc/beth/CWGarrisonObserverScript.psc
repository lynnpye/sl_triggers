scriptname cwgarrisonobserverscript extends quest  
cwscript property cws auto
locationalias property garrison auto
int property countsoldiers auto hidden
int property maxcountsoldiers auto hidden ;holds the max counted... needed to make sure when we have 0 guys it's because they all died, not because there were none.
bool property donesettinginitialcount auto hidden
function modcountsoldiers(int valuetomod)
endfunction
function countaliasiffilledandalive(referencealias aliastocount)
endfunction
function processsoldierdeath(actor deadsoldier)
endfunction
function playerleftlocation()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1