scriptname werewolftransformvisual extends activemagiceffect  
armor property wolfskinfxarmor auto
race property werewolfrace auto
visualeffect property feedbloodvfx auto
idle property idlewerewolftransformation auto
sound property npcwerewolftransformation auto
sound property npcwerewolftransformationb2d auto
sound property npcwerewolftransformationb3d auto
quest property playerwerewolfquest auto
event oneffectstart(actor target, actor caster)
endevent
event onanimationevent(objectreference aksource, string aseventname)
endevent
function transformifnecessary(actor target)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1