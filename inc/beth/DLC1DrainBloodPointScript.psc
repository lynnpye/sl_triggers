scriptname dlc1drainbloodpointscript extends activemagiceffect  
event oneffectstart(actor aktarget, actor akcaster)
endevent
event ondying(actor akkiller)
endevent
event oneffectfinish(actor aktarget, actor akcaster)
endevent
formlist property prohibitedcreatures  auto  
message property dlc1bloodpointsmsg  auto  
globalvariable property dlc1vampirebloodpoints  auto  
globalvariable property dlc1vampirenextperk  auto  
globalvariable property dlc1vampireperkpoints  auto  
message property dlc1vampireperkearned  auto  
globalvariable property dlc1vampiremaxperks  auto  
globalvariable property dlc1vampiretotalperksearned  auto  
magiceffect property reanimatesecondaryffaimed  auto  
spell property ghostabilitynew  auto  
;This file was cleaned with PapyrusSourceHeadliner 1