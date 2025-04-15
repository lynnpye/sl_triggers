scriptname defaultteleportability extends activemagiceffect
activator property summonfx auto
activator property teleportbase auto
float property fsearchradius = 1600.0 auto
int property imintoteleport = 2 auto
int property imaxtoteleport = 4 auto
effectshader property fadeoutfx auto
effectshader property fadeinfx auto
visualeffect property trailfx auto
event oneffectstart(actor aktarget, actor akcaster)
endevent
event onhit(objectreference akaggressor, form weap, projectile proj, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
event teleport()
endevent
event onenterbleedout()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1