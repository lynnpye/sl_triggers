scriptname dlc2ashspawndisintegratedeathfx extends activemagiceffect  
float property fdelay = 0.75 auto
float property fdelayalpha = 1.65 auto
float property fdelayend = 1.65 auto
float property shaderduration = 0.00 auto
activator property dlc2ashspawnashpile auto
effectshader property dlc2ashspawndisintegratefxs auto
effectshader property dlc2ashspawndisintegratefxs02 auto
bool property bsetalphazero = true auto
bool property bsetalphatozeroearly = false auto
event oneffectstart(actor target, actor caster)
endevent
event ondying(actor killer)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1