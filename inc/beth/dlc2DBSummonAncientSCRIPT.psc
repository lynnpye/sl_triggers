scriptname dlc2dbsummonancientscript extends activemagiceffect  
objectreference property ancientdb auto
objectreference property ancientdbmarker auto
float property waittimer auto
float property healthpct auto
event oneffectstart(actor target, actor caster) 
endevent
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, \
bool abbashattack, bool abhitblocked)  
endevent
;This file was cleaned with PapyrusSourceHeadliner 1