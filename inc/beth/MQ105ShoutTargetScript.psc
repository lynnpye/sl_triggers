scriptname mq105shouttargetscript extends referencealias  
magiceffect property pusheffect  auto  
magiceffect property sprinteffect  auto  
actorbase property sprintactor auto  ; the actor that is watching for the sprint "hit" (temp)
event onmagiceffectapply(objectreference akcaster, magiceffect akeffect)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1