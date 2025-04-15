scriptname dlc1vq08batsswapeffectscript extends activemagiceffect  
idle property batsprintstart  auto  
globalvariable property dlc1vampirelevitatestateglobal auto
activator property dlc1vamplordbatsfxactivator auto
spell property dlc1vq08swapbats auto
float property freformdelay = 0.0 auto
float property fspellenddelay = 0.0 auto
effectshader property dlc1vampirebatsreformfxs auto
effectshader property dlc1vampirebatsreformbatsfxs auto
sound property magpowersbatsmarker auto
dlc1dunharkonbatteleport property bat auto
referencealias property dlc1vq08harkonalias auto
dlc1playervampirechangescript property dlc1playervampirequest auto
event oneffectstart(actor aknewharkon, actor akoldharkon)
endevent
event onupdate()
endevent
event oneffectfinish(actor aktarget, actor akcaster)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1