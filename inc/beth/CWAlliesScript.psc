scriptname cwalliesscript extends quest  
cwscript property cws auto
referencealias property phase0marker auto
referencealias property phase1marker auto
referencealias property phase2marker auto
referencealias property phase3marker auto
referencealias property phase4marker auto
referencealias property phase5marker auto
referencealias property phase6marker auto
referencealias property potentialally1 auto
referencealias property potentialally2 auto
referencealias property potentialally3 auto
referencealias property potentialally4 auto
referencealias property potentialally5 auto
referencealias property potentialally6 auto
referencealias property potentialally7 auto
referencealias property potentialally8 auto
referencealias property potentialally9 auto
referencealias property potentialally10 auto
referencealias property activeally1 auto
referencealias property activeally2 auto
referencealias property activeally3 auto
referencealias property activeally4 auto
referencealias property activeally5 auto
referencealias property activeally6 auto
referencealias property activeally7 auto
referencealias property activeally8 auto
referencealias property activeally9 auto
referencealias property activeally10 auto
faction property cwallieshaafingarfaction auto
faction property cwalliesreachfaction auto
faction property cwallieshjaalmarchfaction auto
faction property cwallieswhiterunfaction auto
faction property cwalliesfalkreathfaction auto
faction property cwalliespalefaction auto
faction property cwallieswinterholdfaction auto
faction property cwallieseastmarchfaction auto
faction property cwalliesriftfaction auto
faction property cwalliesimperialsonlyfaction auto
faction property cwalliessonsonlyfaction auto
location property haafingarholdlocation auto 
location property reachholdlocation auto 
location property hjaalmarchholdlocation auto 
location property whiterunholdlocation auto 
location property falkreathholdlocation auto 
location property paleholdlocation auto 
location property winterholdholdlocation auto 
location property eastmarchholdlocation auto 
location property riftholdlocation auto 
function makehadvarandralofpotentialallies()
endfunction
function addpotentialally( \
objectreference referencetoadd, \
endfunction
referencealias function getfreepotentialallyalias()
endfunction
function registerallyphasemarkers(objectreference phase0markerref, objectreference phase1markerref, objectreference phase2markerref, objectreference phase3markerref, objectreference phase4markerref, objectreference phase5markerref, objectreference phase6markerref)
endfunction
function processalliesforsiege(location holdlocation)
endfunction
function trytoprocessally(referencealias potentialally, location holdlocation, objectreference phase0markerref)
endfunction
actor function trypromotetoactiveallyandreturnactor(referencealias potentialallytopromote, location holdlocation)
endfunction
bool function isallowedinlocation(actor actortocheck, location holdlocationtocheck)
endfunction
bool function isallowedtojoinplayersfaction(actor actortocheck)
endfunction
referencealias function getfreeactiveallyalias()
endfunction
function enableactiveallies()
endfunction
function deactivateallies()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1