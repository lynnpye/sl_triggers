scriptname survival_playerhitinfo extends referencealias
actor property playerref auto
spell property survival_diseasegreenspore auto
spell property survival_diseasebrownrot auto
spell property survival_diseasegutworm auto
formlist property survival_brownrotcarryingraces auto
formlist property survival_greensporecarryingraces auto
formlist property survival_gutwormcarryingraces auto
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
function onhitimpl(objectreference akaggressor)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1