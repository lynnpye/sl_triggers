scriptname dlc2dunseekerinvisscript extends actor
spell property myspell auto
bool property startivis = false auto
int property mydistance = 512 auto hidden
int property myspeedmult = 3000 auto hidden
int property myspeednormal = 100 auto hidden
event onupdate()
endevent
auto state waiting
event oncellattach()
endevent
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, \
bool abbashattack, bool abhitblocked)
endevent
event oncombatstatechanged(actor aktarget, int aecombatstate)
endevent
endstate
state returntonormal
event onbeginstate()
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1