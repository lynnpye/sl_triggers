scriptname dlc1dunredwaterdenbloodspringscript extends objectreference
spell property dlc1vampirechalicepower auto
spell property dlc1dunredwaterdenpower auto
globalvariable property dlc1dunredwaterdenpowerstopday auto
globalvariable property gamedayspassed auto
globalvariable property playerisvampire auto
spell property trapdiseaseataxia auto
spell property trapdiseasebonebreakfever auto
spell property trapdiseasebrainrot auto
spell property trapdiseaserattles auto
spell property trapdiseaserockjoint auto
spell property trapdiseasewitbane auto
spell property trapdiseasesanguinarevampiris auto
message property dlc1dunredwaterdentaintedbloodmessage auto
message property dlc1dunredwaterdenvhqbloodmessage auto
float property diseasechance = 100.0 auto
float property vampchance = 100.0 auto
quest property dlc1vampirebaseintro auto
event onupdategametime()
endevent
event onactivate(objectreference activateref)
endevent
function drinkfrompool()
endfunction
function processinfection (actor mytarget)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1