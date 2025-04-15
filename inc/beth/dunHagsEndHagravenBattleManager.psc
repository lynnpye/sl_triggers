scriptname dunhagsendhagravenbattlemanager extends actor
objectreference property stage1activatemarker auto
objectreference property stage2activatemarker auto
objectreference property stage3activatemarker auto
objectreference property safepoint auto
objectreference property stage0teleportpoint auto
objectreference property stage1teleportpoint auto
objectreference property stage2teleportpoint auto
objectreference property stage3teleportpoint auto
activator property teleportfx auto
event onhit(objectreference aggressor, form weap, projectile proj, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
event oncombatstatechanged(actor aktarget, int aecombatstate)
endevent
function bypasscombat()
endfunction
function teleporttosafepoint(bool fastfade)
endfunction
event setupcombat()
endevent
event onreset()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1