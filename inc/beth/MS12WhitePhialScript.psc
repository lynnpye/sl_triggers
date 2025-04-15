scriptname ms12whitephialscript extends referencealias  
float property refilltime auto ; in hours
miscobject property emptyphial auto
objectreference property currentcontainer auto
objectreference property spawnmarker auto
miscobject property whitephialbaseobject auto
event oncontainerchanged(objectreference aknewcontainer, objectreference akoldcontainer)
endevent
function refill(potion fillitem)
endfunction
function setforrefill(actor drinker)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1