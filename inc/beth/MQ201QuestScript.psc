scriptname mq201questscript extends quest  conditional
function startdistractionscene (scene pnewscene)
endfunction
function enddistractionscene ( scene pscene )
endfunction
function openexitdoor(bool bopen, bool bwaitforplayertoexittrigger = true)
endfunction
event onupdate()
endevent
function giveplayerdrink()
endfunction
function removedrinkfromplayer()
endfunction
potion property mq201drink  auto  
int property partydistractiondrunkstate = 0 auto  conditional
bool property partydistractiondrunkscenedone auto conditional
int property partydistractionstate = 0 auto  conditional
int property prisonerreleased = 0 auto  conditional
location property riverwoodinnlocation  auto  
location property thalmorembassylocation  auto  
referencealias property alias_partyexitdoor auto
scene property partydistractiondrunkscene  auto  
scene property partydistractionfriendscene  auto  
scene property leavepartyscene  auto  
int property delphineintroalduinathelgen  auto  conditional
scene property returntopartyscene  auto  
bool property ondolemardistractionflag  auto  
bool property playerinexitpartytrigger  auto  conditional
bool property playerinpartytrigger  auto  conditional
scene property partydistractionerikurbrelasscene  auto  
bool property playerliesaboutbrelas  auto  conditional
bool property nopartyconversationflag  auto  conditional
scene property partyvittoriaintroscene  auto  
scene property partyerikurintroscene  auto  
cell property thalmordungeoncell  auto  
defaultonenter property mq201malborninkitchentrigger  auto  
defaultonenter property mq201playerinkitchentrigger  auto  
bool property brelasreleased = false auto  conditional
referencealias property colovianbrandy  auto  
referencealias property partydrinkmarker  auto  
potion property drink1  auto  
potion property drink2  auto  
potion property drink3  auto  
potion property drink4  auto  
;This file was cleaned with PapyrusSourceHeadliner 1