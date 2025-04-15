scriptname mq201partyscript extends quest  conditional
quest property mq201  auto  
function movetoparty(referencealias guestalias, objectreference partymarker, bool bisjarl = false)
endfunction
function movehome(referencealias guestalias)
endfunction
function startfrienddistractionscene(actor friend, bool bpersuade = true)
endfunction
function endfrienddistractionscene()
endfunction
function trytostarterikurintroscene()
endfunction
function addtoguestlist(referencealias guest)
endfunction
event onupdate()
endevent
formlist property guestlist  auto  
float property frandomizehellotimer = 10.0 auto conditional
int property imaxguesthellos = 2 auto
favordialoguescript property dialoguefavorgeneric auto  
scene property frienddistractionscene  auto  
referencealias property alias_friend  auto  
globalvariable property favorcost  auto  
actorbase property ondolemar  auto  
referencealias property alias_erikur auto
bool property orthusintroducedvittoria  auto  conditional
bool property hidetulliuscwobjectives  auto  conditional
faction property govexiled  auto  
bool property balljarls  auto  
objectreference property exiledjarlmovetomarker  auto  
faction property mq201frienddistractiondonefaction  auto  
;This file was cleaned with PapyrusSourceHeadliner 1