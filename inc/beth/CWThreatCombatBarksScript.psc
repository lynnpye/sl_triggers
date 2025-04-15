scriptname cwthreatcombatbarksscript extends quest  conditional
referencealias property imperialbridge auto
referencealias property imperialfence auto
referencealias property imperialfencearcher auto
referencealias property imperialfencemage auto
referencealias property imperialhouse auto
referencealias property imperialrock auto
referencealias property imperialstables auto
referencealias property imperialtower auto
referencealias property imperialtowerarcher auto
referencealias property imperialtowermage auto
referencealias property imperialtree auto
referencealias property imperialwall auto
referencealias property imperialwallarcher auto
referencealias property imperialwallmage auto
referencealias property imperialwindow auto
referencealias property imperialwindowarcher auto
referencealias property imperialwindowmage auto
referencealias property sonsbridge auto
referencealias property sonsfence auto
referencealias property sonsfencearcher auto
referencealias property sonsfencemage auto
referencealias property sonshouse auto
referencealias property sonsrock auto
referencealias property sonsstables auto
referencealias property sonstower auto
referencealias property sonstowerarcher auto
referencealias property sonstowermage auto
referencealias property sonstree auto
referencealias property sonswall auto
referencealias property sonswallarcher auto
referencealias property sonswallmage auto
referencealias property sonswindow auto
referencealias property sonswindowarcher auto
referencealias property sonswindowmage auto
keyword property cw1meleeclose auto
keyword property cw1meleewide auto
keyword property cw1missileclose auto
keyword property cw1missilewide auto
keyword property cw2meleeclose auto
keyword property cw2meleewide auto
keyword property cw2missileclose auto
keyword property cw2missilewide auto
keyword property cw3meleeclose auto
keyword property cw3meleewide auto
keyword property cw3missileclose auto
keyword property cw3missilewide auto
keyword property cw4meleeclose auto
keyword property cw4meleewide auto
keyword property cw4missileclose auto
keyword property cw4missilewide auto
keyword property cw5meleeclose auto
keyword property cw5meleewide auto
keyword property cw5missileclose auto
keyword property cw5missilewide auto
cwscript property cws auto
function processtriggeractor(actor triggeractor, float battlephase, bool bridge = false, bool fence = false, bool house = false, bool rock = false, bool stables = false, bool tower = false, bool tree = false, bool wall = false, bool window = false)
endfunction
referencealias function determinerolealias(actor actortocheck, float battlephase,  referencealias typearcheralias, referencealias typemagealias)
endfunction
globalvariable function determineroleglobal(actor actortocheck, float battlephase,  globalvariable typearcherglobal, globalvariable typemageglobal)
endfunction
bool function isarcher(actor actortocheck, float battlephase)
endfunction
bool function ismage(actor actortocheck, float battlephase)
endfunction
function clearaliasifactorisinit(referencealias aliastocheck, actor actortocheck, globalvariable globaltoclear)
endfunction
function processtriggeractorleaving(actor triggeractor)
endfunction
function registerbattlephasechanged()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1