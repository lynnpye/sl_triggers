scriptname ccstartafterchargenscript extends quest  
quest property mq101  auto
int property chargenstagetowatch = 1000 auto  
int property optionalrequiredplayerlevel = 1 auto
int property myqueststagetoset  auto 
float property secondsbetweenchecks = 30.0 auto
event oninit()
endevent
event onupdate()
endevent
function checkstagetostart()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1