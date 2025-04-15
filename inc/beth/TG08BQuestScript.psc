scriptname tg08bquestscript extends quest  conditional
actorbase property ptg08bmercer auto conditional
faction property ptg08bfalmerfaction auto conditional
faction property ptg08bcreaturefaction auto conditional
int property ptg08bkarliahfg01 auto conditional
int property ptg08bkarliahaccompany auto conditional
int property ptg08bmercerfg01 auto conditional
int property ptg08bkarliahfg02 auto conditional
int property ptg08bscene02done auto conditional
int property ptg08bnocheck auto conditional
cell property ptg08irkngthand  auto  conditional
quest property ptg09quest  auto  conditional
quest property ptg08bquest auto conditional
miscobject property ptg08bskeletonkey  auto  conditional
objectreference property ptg08bkarliahref auto conditional
objectreference property ptg08brisingwaterref auto conditional
objectreference property ptg08bmonsterdisablerref auto conditional
objectreference property ptg08bkarliahfinal auto conditional
objectreference property ptg08bbrynjolffinal auto conditional
scene property ptg08bfinalscene01 auto conditional
globalvariable property ptgfavorlarge auto conditional
objectreference property ptg08bridgeenableref  auto  conditional
objectreference property ptg08birkngthandlockeddoorref  auto  conditional
faction property ptg08btgfaction  auto  conditional
objectreference property ptg08bkarliahfightmarker  auto  
objectreference property ptg08bbrynjolffightmarker  auto  
scene property ptg08bfloodscene01  auto
objectreference property ptg08bbrynjolfstartermarker  auto  conditional
objectreference property ptg08bkarliahstartermarker  auto  conditional
outfit property ptg08bngaleoutfit  auto  conditional
event onupdate()
endevent
globalvariable property dlc1vampirelorddisallow auto
dlc1playervampirechangescript property vampchangetracker auto
race property vampbeast auto
function vamplock()
endfunction
function vampunlock()
endfunction
spell property tgnightingaleshadowmercer  auto  
bool property ptg08bexittriggeredbrynjolf  auto  conditional
bool property ptg08bexittriggeredkarliah  auto  conditional
bool property ptg08bexittriggeredplayer  auto  conditional
bool property ptg08bstatuedoorreached = false auto  conditional
bool property ptg08bbrynjolfischarmed  auto  conditional
objectreference property tg08bfightcontrollerref  auto  
explosion property tg08bshockwaveexplosion  auto  
scene property tg08bfight  auto  
magiceffect property tg08bsubterfugeexplosioneffect  auto  
;This file was cleaned with PapyrusSourceHeadliner 1