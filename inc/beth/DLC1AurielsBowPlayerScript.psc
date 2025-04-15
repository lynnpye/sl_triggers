scriptname dlc1aurielsbowplayerscript extends activemagiceffect  
spell property dlc1aurielsbowsunattackspell auto
spell property dlc1aurielsboweclipsespell auto
imagespacemodifier property lightimodfx auto
imagespacemodifier property darkimodfx auto
event onobjectequipped(form akweapon, objectreference akweaponref)
endevent
event onplayerbowshot(weapon akweapon, ammo akammo, float akbowdraw, bool absungazing)
endevent
event onupdategametime()
endevent
event onobjectunequipped(form akweapon, objectreference akweaponref)
endevent
imagespacemodifier function getsungazeimod()
endfunction
weapon property dlc1aurielsbow  auto  
ammo property dlc1elvenarrowblood  auto  
ammo property dlc1elvenarrowblessed  auto  
bool property bloodarrowequipped  auto  
bool property blessedarrowequipped  auto  
globalvariable property dlc1eclipseactive  auto  
globalvariable property gamehour  auto  
formlist property sunaffectingworldspaces  auto  
;This file was cleaned with PapyrusSourceHeadliner 1