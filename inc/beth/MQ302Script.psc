scriptname mq302script extends quest  conditional
location property highhrothgarlocation  auto  
function movetocouncil(referencealias guestalias, objectreference partymarker)
endfunction
function movehome(referencealias guestalias)
endfunction
function transferholdcontrol()
endfunction
function startloopingconcessionscene()
endfunction
function incrementnegotiationdelta(int value)
endfunction
function setnegotiationlocations()
endfunction
location property imperialtownraided  auto  conditional
location property sonstownraided  auto  conditional
int property imperialmajorholdid auto conditional
int property imperialminorholdid auto conditional
int property imperialminorhold2id auto conditional
int property sonsmajorholdid auto conditional
int property sonsminorholdid auto conditional
int property sonsminorhold2id auto conditional
quest property cw auto
int property negotiationdelta = 0 auto  conditional
globalvariable property startingnegotiationdelta auto
scene property councilscene5_s auto
scene property councilscene5_i auto
bool property kickoutflag = false auto conditional
int property  citytoswitch auto  conditional
locationalias property alias_imperialmajorhold  auto  
locationalias property alias_imperialminorhold  auto  
locationalias property alias_imperialminorhold2  auto  
locationalias property alias_sonsmajorhold  auto  
locationalias property alias_sonsminorhold  auto  
locationalias property alias_sonsminorhold2  auto  
referencealias property alias_playerchair  auto  
int property sidefavored  auto  conditional
bool property hidecwmiscobjectives  auto  conditional
favordialoguescript property dialoguefavorgeneric  auto  
faction property cwsonsfaction  auto  
bool property bimperialcouncilblocked  auto  conditional
bool property bstormcloakcouncilblocked  auto  conditional
;This file was cleaned with PapyrusSourceHeadliner 1