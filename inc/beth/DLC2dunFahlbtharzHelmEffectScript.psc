scriptname dlc2dunfahlbtharzhelmeffectscript extends activemagiceffect  
spell property dlc2dunfahlbtharzsteambreath auto
float property duration = 5.0 auto
bool property breakout = false auto hidden
int property minstamina = 25  auto
float property recasttime = 0.2 auto
event oneffectstart(actor aktarget, actor akcaster)
endevent
event oneffectfinish(actor aktarget, actor akcaster)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1