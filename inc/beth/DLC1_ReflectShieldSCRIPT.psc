scriptname dlc1_reflectshieldscript extends activemagiceffect  
spell  property chargespell1 auto
spell  property chargespell2 auto
spell  property chargespell3 auto
sound property chargsound auto
imagespacemodifier property chargeimod auto
imagespacemodifier property blastimod auto
globalvariable property timeshit auto
globalvariable property currentstage auto
int property hitsuntilfirstcharge = 5 auto
int property hitsuntilsecondcharge = 10 auto
int property hitsuntilthirdcharge = 15 auto
event oneffectstart(actor target, actor caster) 
endevent
event onupdate()
endevent
event oneffectfinish(actor target, actor caster) 
endevent
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
event onanimationevent(objectreference aksource, string eventname)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1