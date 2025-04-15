scriptname cwmissionpollforfaildayscript extends quest
quest property cw  auto  
quest property cwcampaign  auto  
cwscript property cws auto hidden
cwcampaignscript property cwcampaigns auto hidden
cwmissionscript property mymissions auto hidden
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
function startpolling()  ;usually called in cwmission quest's stage 10
endfunction
function stoppolling()
endfunction
function failmissionquest()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1