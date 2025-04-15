scriptname dlc2onhitactivatecustomlinkedref extends objectreference  
keyword property linkcustom01 auto
bool property doonlyonce = true auto
auto state waiting
event onhit(objectreference akaggressor, form akweapon, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
event onactivate(objectreference akactivator)
endevent
event oncontainerchanged(objectreference aknewcontainer, objectreference akoldcontainer)
endevent
event ongrab()
endevent
endstate
state done
endstate
;This file was cleaned with PapyrusSourceHeadliner 1