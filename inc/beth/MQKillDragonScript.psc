scriptname mqkilldragonscript extends quest  conditional
bool function trymiraakmakehisintroduction(actor dragonref)
endfunction
bool function shouldmiraakappear(actor dragonref)
endfunction
function deathsequence(actor dragonref, actor absorbactor = none, bool miraakappears = false)
endfunction
wifunctionsscript property wi auto
globalvariable property dragonsabsorbed  auto  
armor property dragonunderskin  auto   
faction property mqkilldragonfaction  auto  
int property voicepointsreward = 1 auto  
visualeffect property dragonabsorbeffect auto
visualeffect property dragonabsorbmaneffect auto
visualeffect property fxdragondeathlhandbits auto
visualeffect property fxdragondeathlhandfire auto
visualeffect property fxdragondeathrhandbits auto
visualeffect property fxdragondeathrhandfire auto
effectshader property dragonholesfxs auto
effectshader property dragonholesbitsfxs auto
effectshader property dragonholesbitslitefxs auto
effectshader property dragonpowerabsorbfxs auto
effectshader property dragonholessmokefxs auto
effectshader property dragonholesmagicfxs auto
effectshader property dragonholeslightfxs auto
imagespacemodifier property dragonpowerabsorbism auto
sound property npcdragondeathsequencefirelpm auto
sound property npcdragondeathsequencewind auto
sound property npcdragondeathsequenceexplosion auto
sound property npcdragondeathsequencesmolderlpm auto
armor property dragonbloodheadfxarmor  auto  
armor property dragonbloodtailfxarmor  auto  
armor property dragonbloodwinglfxarmor  auto  
armor property dragonbloodwingrfxarmor  auto  
armor property skindragonhider auto
explosion property magdragonpowerabsorbexplosion auto
faction property nodragonabsorb  auto  
bool property bisabsorbing  auto  conditional
quest property mq104  auto  
dlc2soulstealscript property dlc2soulsteal  auto  
actor property dlc2miraakmq06ref auto
location property dlc2apocryphalocation auto
worldspace property dlc2apocryphaworld auto
referencealias property dlc2mq06miraakalias auto
dlc2mq06miraakbossbattle property dlc2bossbattlescript auto hidden
function mq06deathsequence(actor dragonref, actor absorbactor = none, bool miraakappears = false)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1