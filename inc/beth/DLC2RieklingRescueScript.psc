scriptname dlc2rieklingrescuescript extends quest  
globalvariable property dlc2rieklingrescuechance auto
globalvariable property dlc2rieklingnextallowedday auto
globalvariable property gamedayspassed auto
referencealias[] property rieklingaliasarray auto
worldspace property dlc2solstheimworld auto
quest property dlc2mh02 auto
function rollforrieklings(bool wasprojectile = false)
endfunction
function rieklingsappear()
endfunction
function movetobehindplayer(objectreference thingtomove, int unitsbehind = 1000, bool waitforplayerweaponsdrawn = true)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1