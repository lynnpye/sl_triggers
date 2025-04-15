scriptname dlc1summonfromsoulcairnfxscript extends actor
visualeffect property dlc1deaddragonparticleseffect auto
effectshader property summonfxs auto
effectshader property unsummonfxs auto
float property fxstime = 0.1 auto
bool property iamdragon = false auto
event onload()
endevent
event ondying(actor akkiller)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1