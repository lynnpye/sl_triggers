scriptname tg01bersidwemerurnscript extends objectreference  conditional
message property ptg01urnshattersmessage  auto  conditional
quest property ptg01quest auto conditional
scene property ptg01urnsmashscene auto conditional
tg01questscript property ptg01qs auto conditional
event ondestructionstagechanged (int aioldstage, int aicurrentstage)
endevent
event onhit(objectreference akaggressor, form akweapon, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1