scriptname mineorescript extends objectreference
sound property drscoreopen auto
formlist property mineoretoolslist auto
message property failuremessage auto  
message property depletedmessage auto  
miscobject property ore auto  
leveleditem property litemgems10 auto
int property resourcecount = 1 auto
int property resourcecounttotal = 3 auto
int property resourcecountcurrent = -1 auto hidden
int property strikesbeforecollection = 1 auto
int property strikescurrent = -1 auto hidden
int property attackstrikesbeforecollection = 3 auto
int property attackstrikescurrent = -1 auto hidden
mineorefurniturescript property myfurniture auto hidden
objectreference property objself auto hidden
achievementsscript property achievementsquest auto
location property cidhnaminelocation auto
quest property ms02 auto
quest property dialoguecidhnamine auto
objectreference property cidhnamineplayerbedref auto
event oncellattach()
endevent
event onactivate(objectreference akactivator)
endevent
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
event onreset()
endevent
bool function playerhastools()
endfunction
function proccessattackstrikes()
endfunction
function proccessstrikes()
endfunction
function giveore()
endfunction
function depleteoreduetofailure()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1