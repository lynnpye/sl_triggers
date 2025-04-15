scriptname dwesteamtrigger01script extends objectreference hidden 
keyword property linkcustom01 auto
float property fdelaybeforelooping = 5.0 auto
float property fdelaybeforeloopingback = 3.0 auto
event oncellattach()
endevent
auto state swaitingforhit
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
endstate
state sbeenhit
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
endstate
function startlooping()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1