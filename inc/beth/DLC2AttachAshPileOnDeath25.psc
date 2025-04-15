scriptname dlc2attachashpileondeath25 extends activemagiceffect  
float property fdelay = 0.75 auto
float property fdelayend = 1.65 auto
float property shaderduration = 0.00 auto
activator property ashpileobject auto
effectshader property magiceffectshader auto
bool property bsetalphazero = true auto
formlist property immunitylist auto
bool property bsetalphatozeroearly = false auto
event oneffectstart(actor target, actor caster)
endevent
event ondying(actor killer)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1