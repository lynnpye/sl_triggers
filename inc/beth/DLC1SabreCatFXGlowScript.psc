scriptname dlc1sabrecatfxglowscript extends activemagiceffect
event oneffectstart(actor aktarget, actor akactor)
endevent
event onupdate()
endevent
auto state waiting
event ondeath(actor akkiller)
endevent
event oncombatstatechanged(actor aktarget, int aecombatstate)
endevent
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
event ongainlos(actor akviewer, objectreference aktarget)
endevent
event onlostlos(actor akviewer, objectreference aktarget)
endevent
endstate
state donothing
event onbeginstate()
endevent
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
event ongainlos(actor akviewer, objectreference aktarget)
endevent
event onlostlos(actor akviewer, objectreference aktarget)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1