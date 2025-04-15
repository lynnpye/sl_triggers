scriptname dlc1seranalevelingscript extends actor 
keyword property vampirekeyword auto
event oninit()
endevent
event onupdategametime()
endevent
event oncombatstatechange(actor aktarget, int combatstate)
endevent
float property currenthealth auto
int property currentlevel auto
int property lastlevel  auto  
int property stage1 = 20 auto  
int property stage2 = 28 auto  
int property stage3 = 38 auto  
int property stage4 = 48 auto  
int property stage5 = 99 auto  
spell property crvampiredrain02  auto  
spell property crvampiredrain03  auto  
spell property crvampiredrain04  auto  
spell property crvampiredrain05  auto  
spell property crvampiredrain06  auto  
spell property icespikelefthand  auto  
spell property reanimatecorpselefthand  auto  
spell property lightningboltlefthand  auto  
spell property revenantlefthand  auto  
spell property icestormlefthand  auto  
spell property chainlightninglefthand  auto  
spell property raisezombielefthand  auto  
;This file was cleaned with PapyrusSourceHeadliner 1