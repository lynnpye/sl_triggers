scriptname dlc2seekermirrorscript extends actor  
actorbase property dlc2encseekermirror  auto
int property mirrorcount  auto  
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
event ondying(actor akkiller)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1