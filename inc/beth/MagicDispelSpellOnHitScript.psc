scriptname magicdispelspellonhitscript extends activemagiceffect  
spell property spell01 auto
spell property spell02 auto
spell property spell03 auto
event oneffectstart(actor target, actor caster)
endevent
event onhit(objectreference akaggressor, form akweapon, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1