scriptname magicprojectilestormscript extends activemagiceffect
float property fstartdelayrand = 0.0 auto
float property fheight = 3584.0 auto
float property fxybaserandom = 1500.0 auto
float property fposrandom = 512.0 auto
float property fdelay = 2.0 auto
float property frecast = 1.0 auto
float property frecastrand = 0.0 auto
activator property placedactivator auto
activator property placedtargetactivator auto
spell property spellref auto
hazard property skyartspell auto
bool property bdonthitcaster = true auto
bool property bmissonpurpose = false auto
bool property bworksondead = false auto
bool property deletatend = true auto
imagespacemodifier property castingimod auto
float property fimodfadedistance = 3072.0 auto
bool property bcastfromcenter = false auto
sound property soundfx auto ; create a sound property we'll point to in the editor
globalvariable property magprojectilestormvar auto
bool property bsupermiss = false auto
event oninit()
endevent
event oneffectstart(actor target, actor caster)
endevent
event onupdate()
endevent
event oneffectfinish(actor target, actor caster)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1