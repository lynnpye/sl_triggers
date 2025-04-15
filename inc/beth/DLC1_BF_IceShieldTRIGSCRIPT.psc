scriptname dlc1_bf_iceshieldtrigscript extends objectreference hidden 
float property maxblend = 0.7 auto
float property hitblendrate = 0.3 auto
float property cooldownblendrate = 0.03 auto
int property cooldowncount = 0 auto
int property cooldowncountmax = 2 auto
event onupdate()
endevent
auto state waitingforhit
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
endstate
state currentlyhit
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1