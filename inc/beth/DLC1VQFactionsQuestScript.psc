scriptname dlc1vqfactionsquestscript extends quest  
faction property pfactiona  auto
faction property pfactionb  auto
faction property pfactionc  auto
faction property pfactiond  auto
faction property pplayerfaction  auto  
event oninit()
endevent
function makefactionsallies(faction factiona, faction factionb, bool makefriendsinstead = false)
endfunction
function makefactionsenemies(faction factiona, faction factionb, bool makeneutralinstead = false)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1