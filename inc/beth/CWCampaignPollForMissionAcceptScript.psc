scriptname cwcampaignpollformissionacceptscript extends quest 
quest property cw  auto  
quest property cwcampaign  auto  
cwscript property cws auto hidden
cwcampaignscript property cwcampaigns auto hidden
event oninit()
endevent
auto state notpolling
event onupdate()
endevent
endstate
state polling
event onupdate()
endevent
endstate
function startpolling()
endfunction
function stoppolling()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1