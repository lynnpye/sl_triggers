scriptname dlc1vampiretransformvisual extends activemagiceffect  
race property dlc1vampirelordrace auto
visualeffect property feedbloodvfx auto
idle property idlevampiretransformation auto
sound property npcvampiretransformation auto
sound property npcvampiretransformationb2d auto
sound property npcvampiretransformationb3d auto
explosion property fxvampchangeexplosion auto
quest property dlc1playervampirequest auto
quest property dlc1trackingquest auto
event oneffectstart(actor target, actor caster)
endevent
event onanimationevent(objectreference aksource, string aseventname)
endevent
function transformifnecessary(actor target)
endfunction
spell property dlc1vampirechangestagger  auto  
;This file was cleaned with PapyrusSourceHeadliner 1