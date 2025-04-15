scriptname playersleepquestscript extends quest
spell property rested auto
spell property wellrested auto
spell property marriagesleepability auto
spell property byohadoptionsleepabilitymale auto
spell property byohadoptionsleepabilityfemale auto
referencealias property loveinterest auto
locationalias property currenthomelocation auto
keyword property loctypeinn auto
keyword property loctypeplayerhouse auto
quest property relationshipmarriagefin auto
quest property byohrelationshipadoption auto
spell property pdoomloverability auto
companionshousekeepingscript property chscript auto
function removerested()
endfunction
function removeadoptionrested()
endfunction
event onsleepstop(bool abinterrupted)
endevent
message property restedmessage  auto  
message property wellrestedmessage  auto  
message property marriagerestedmessage  auto  
message property beastbloodmessage  auto
message property byohadoptionrestedmessagemale  auto  
message property byohadoptionrestedmessagefemale  auto  
;This file was cleaned with PapyrusSourceHeadliner 1