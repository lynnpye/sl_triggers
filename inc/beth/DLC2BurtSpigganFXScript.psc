scriptname dlc2burtspigganfxscript extends actor
visualeffect property dlc2burntsprigganparticlese auto
float property baseglow = 0.25 auto
auto  state alive
event onload()
endevent
event ongetup(objectreference akfurniture);ambush wake up
endevent
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack,  bool abbashattack, bool abhitblocked)
endevent
event onanimationevent(objectreference aksource, string aseventname)
endevent
event ondying(actor mykiller)
endevent
endstate
state dead
endstate
;This file was cleaned with PapyrusSourceHeadliner 1