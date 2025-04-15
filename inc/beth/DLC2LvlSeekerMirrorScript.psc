scriptname dlc2lvlseekermirrorscript extends actor  
spell property dlc2seeker01righthandspell  auto  
spell property dlc2seeker02righthandspell  auto  
spell property dlc2seeker03righthandspell  auto  
actorbase property dlc2encseeker01mirror  auto
actorbase property dlc2encseeker02mirror  auto
actorbase property dlc2encseeker03mirror  auto
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
event ondying(actor akkiller)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1