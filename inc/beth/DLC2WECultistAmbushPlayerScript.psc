scriptname dlc2wecultistambushplayerscript extends referencealias  
locationalias property plocation auto
referencealias property cultist1 auto
referencealias property cultist2 auto
int property stagetostoppollingplayerlocation auto
event onlocationchange(location akoldloc, location aknewloc)
endevent
function stopquestifnotinlocationandcultistsnotloaded()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1