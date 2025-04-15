scriptname dunarcherpressureplatescript extends objectreference
formlist property flarrows auto
int property targetnumber auto
objectreference property lefttarget auto
objectreference property middletarget auto
objectreference property righttarget auto
objectreference property fartarget auto
objectreference property myactortarget auto
actor property myactor auto
quest property dunarcherqst auto
event onload()
endevent
auto state waiting
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
endstate
state donothing
endstate
;This file was cleaned with PapyrusSourceHeadliner 1