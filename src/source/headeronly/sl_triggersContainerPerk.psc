scriptname sl_triggerscontainerperk extends perk hidden
function fragment_18(objectreference aktargetref, actor akactor)
endfunction
function fragment_3(objectreference aktargetref, actor akactor)
endfunction
actor property                          playerref auto
sl_triggersmain property                sltrmain auto
sl_triggersextensioncore property       sltrcore auto
objectreference property                containerref auto
int property is_corpse = 1 autoreadonly hidden
int property is_container = 2 autoreadonly hidden
function signalcontaineractivation(actor _akactor, objectreference _containerref, bool is_origin_corpse, bool is_target_empty)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1