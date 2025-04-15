scriptname dlc1vampirecastlecontrollerscript extends quest  conditional
dlc1_2stateactivatorwithglobal property pmaingate auto hidden
objectreference property pdlc1vcmaingateref auto
location property dlc1vampirecastleguildhalllocation auto
objectreference property dlc1vcrubbletocourtyardmarker  auto  
objectreference property dlc1vcseranaroom auto
objectreference property dlc1vcseranaroomdisused auto
bool property seranasroomenabled auto hidden
objectreference property dlc1vcbanquetlockdown auto
objectreference property dlc1vcvalericasroom auto
objectreference property dlc1vcvalericasgarden auto
bool property valericasgardenenabled auto hidden
objectreference property dlc1vcvalericasgardenruined auto
objectreference property dlc_vcghtoext auto
objectreference property dlc1vq08loaddoorenablemarker auto
objectreference property dlc1vq08bossroomcleanupref auto
objectreference property dlc1vcbossroomgargoylesparent auto
objectreference property dlc1vqtutorialdoor auto
cell property dlc1vampirecastleguildhall auto
faction property dlc1vampirefaction auto
faction property nofaction auto hidden
bool property bosscellisattached auto  hidden
bool property guildhallisattached auto  hidden
bool property movelistinuse auto hidden
objectreference property dlc1vq08actorcleanupmarker auto
objectreference property dlc1vq08cleanupchestref auto
objectreference property dlc1vq08cleanupguildhallpor auto
objectreference property dlc1vq08cleanupbossroompor auto
objectreference property dlc1vq08tutorialroomenablemarker auto
objectreference property dlc1vq08tutorialroomblackplanemarker auto
objectreference property dlc1vcexttodungeon02 auto
objectreference property dlc1vcbalconydoorenableparent auto
objectreference property dlc1vcbossdoorgh auto
objectreference property dlc1vcbossdoor auto
bool property bossroomcleanupcomplete = false auto hidden
bool property bossroomcleanupstarted = false auto hidden
quest property dlc1vq08 auto
formlist property dlc1vq08flbossroomtrackinglist  auto  
function setgateopen()
endfunction
function setgateclosed()
endfunction
function enabledoortocourtyard()
endfunction
function cleanseranasroom(bool enablestate = true)
endfunction
function enablevalericasroom(bool enablestate = true)
endfunction
function enablevalericasgarden(bool enablestate = true)
endfunction
function lockbalconydoor(bool lockstate = true)
endfunction
function lockdownbanquethall(bool banquetlockstate = true)
endfunction
function unlockbanquethall()
endfunction
function lockbossroomdoor(bool bossroomlockstate = true)
endfunction
function unlockbossroomdoor()
endfunction
function starttutorialroomcleanup()
endfunction
function finishtutorialroomcleanup()
endfunction
function processcleanuplist()
endfunction
function printcleanuplist()
endfunction
function setguildhallcellattached()
endfunction
function setguildhallcelldetached()
endfunction
function setbosscelldetached()
endfunction
function setbosscellattached()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1