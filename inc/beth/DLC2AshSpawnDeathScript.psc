scriptname dlc2ashspawndeathscript extends actor  
float property fdelay = 0.75 auto
float property fdelayend = 1.65 auto
float property shaderduration = 0.00 auto
activator property ashpileobject auto
effectshader property magiceffectshader auto
bool property bsetalphazero = true auto
event ondying(actor akkiller)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1