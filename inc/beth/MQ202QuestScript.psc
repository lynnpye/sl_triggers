scriptname mq202questscript extends quest  conditional
event onupdate()
endevent
quest property tg01 auto
int property vekeltoldaboutthalmor = 0 auto  conditional
function checkforgissuroverhearing( actor pspeaker = none )
endfunction
referencealias property alias_gissur  auto  
referencealias property alias_flagonbartender  auto  
favordialoguescript property dialoguefavorgeneric  auto  
referencealias property alias_vekel  auto  
referencealias property alias_dirge  auto  
;This file was cleaned with PapyrusSourceHeadliner 1