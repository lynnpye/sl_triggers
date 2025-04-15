scriptname dlc1batseffectscript extends activemagiceffect  
spell property amuletspell auto
globalvariable property batamulet auto
idle property batsprintstart  auto  
globalvariable property dlc1vampirelevitatestateglobal auto
activator property dlc1vamplordbatsfxactivator auto
spell property dlc1vampirebats auto
float property freformdelay = 0.0 auto
float property fspellenddelay = 0.0 auto
effectshader property dlc1vampirebatsreformfxs auto
effectshader property dlc1vampirebatsreformbatsfxs auto
dlc1playervampirechangescript property dlc1playervampirequest auto
imagespacemodifier property castingimod auto
event oneffectstart(actor aktarget, actor akcaster)
endevent
function battyloops()
endfunction
event onanimationevent(objectreference aksource, string aseventname)
endevent
event oneffectfinish(actor aktarget, actor akcaster)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1