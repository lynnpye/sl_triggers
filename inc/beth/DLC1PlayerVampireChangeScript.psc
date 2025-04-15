scriptname dlc1playervampirechangescript extends quest  
float property standarddurationseconds auto
float property durationwarningtimeseconds auto
float property unearthlywillextensiontimeseconds auto
visualeffect property feedbloodvfx auto
race property vampirelordrace auto
faction property playervampirefaction auto
message property playervampireexpirationwarning auto
message property playervampirefeedmessage auto
globalvariable property gamedayspassed auto
globalvariable property timescale auto
globalvariable property playervampireshiftbacktime auto
globalvariable property dcl1vampirelevitatestateglobal auto
imagespacemodifier property vampirewarn auto
imagespacemodifier property vampirechange auto
sound property npcvampiretransformation auto
sound property vampireimodsound auto
idle property specialfeeding auto
spell property feedboost auto
spell property bleedingfxspell auto
quest property vampiretrackingquest auto
bool property untimed auto
formlist property crimefactions auto
formlist property vampiredispellist auto
armor property beastring auto
globalvariable property pdlc1nvampireringbeast auto
armor property eruditering auto
globalvariable property pdlc1nvampireringerudite auto
armor property batnecklace auto
globalvariable property pdlc1nvampirenecklacebats auto
armor property gargnecklace auto
globalvariable property pdlc1nvampirenecklacegargoyle auto
float function realtimesecondstogametimedays(float realtime)
endfunction
float function gametimedaystorealtimeseconds(float gametime)
endfunction
function prepshift()
endfunction
function initialshift()
endfunction
function starttracking()
endfunction
event onupdate()
endevent
function revert()
endfunction
function setuntimed(bool untimedvalue)
endfunction
function feed(actor victim)
endfunction
function warnplayer()
endfunction
function shiftback()
endfunction
event onanimationevent(objectreference akactor, string akeventname)
endevent
function actuallyshiftbackifnecessary()
endfunction
function shutdown()
endfunction
string property ground = "groundstart" auto  
string property levitate = "levitatestart" auto  
string property bitestart = "bitestart" auto  
string property liftoffstart = "liftoffstart" auto
string property landstart = "landstart" auto  
string property transformtohuman = "transformtohuman" auto
event onanimationeventunregistered(objectreference aksource, string aseventname)
endevent
function registerforevents()
endfunction
function unregisterforevents()
endfunction
function establishleveledspells()
endfunction
function checkperkspells()
endfunction
function handleplayerloadgame()
endfunction
function preloadspells()
endfunction
function unloadspells()
endfunction
spell property leveledability auto
spell property dlc1playervampirelvl10andbelowability  auto  
spell property dlc1playervampirelvl15andbelowability  auto  
spell property dlc1playervampirelvl20andbelowability  auto  
spell property dlc1playervampirelvl25andbelowability  auto  
spell property dlc1playervampirelvl30andbelowability  auto  
spell property dlc1playervampirelvl35andbelowability  auto  
spell property dlc1playervampirelvl40andbelowability  auto  
spell property dlc1playervampirelvl45andbelowability  auto  
spell property dlc1playervampirelvl50andoverability  auto  
spell property leveleddrainspell auto
spell property dlc1vampiredrain05  auto  
spell property dlc1vampiredrain06  auto  
spell property dlc1vampiredrain07  auto  
spell property dlc1vampiredrain08  auto  
spell property dlc1vampiredrain09  auto  
spell property dlc1vampireraisedeadlefthand01  auto  
spell property dlc1vampireraisedeadlefthand02  auto  
spell property dlc1vampireraisedeadlefthand03  auto  
spell property dlc1vampireraisedeadlefthand04  auto  
spell property dlc1vampireraisedeadlefthand05  auto  
spell property dlc1vampiresgrip  auto  
spell property dlc1conjuregargoylelefthand  auto  
spell property dlc1corpsecurse  auto  
spell property dlc1vampiredetectlife  auto  
spell property dlc1vampiremistform  auto  
spell property dlc1vampirebats  auto  
spell property dlc1supernaturalreflexes  auto  
globalvariable property dlc1bloodmagic  auto  
globalvariable property dlc1nightpower  auto  
globalvariable property dlc1vampirebloodpoints  auto  
globalvariable property dlc1vampireperkpoints  auto  
globalvariable property dlc1vampirenextperk  auto  
message property dlc1bloodpointsmsg  auto  
perk property dlc1vampireactivationblocker  auto  
float property dlc1bitehealthrecover  auto 
playervampirequestscript property playervampirequest auto
spell property abvampire01  auto  
spell property abvampire02  auto  
spell property abvampire03  auto  
spell property abvampire04  auto  
spell property abvampire01b  auto  
spell property abvampire02b  auto  
spell property abvampire03b  auto  
spell property abvampire04b  auto  
spell property vampiresundamage01  auto  
spell property vampiresundamage02  auto  
spell property vampiresundamage03  auto  
spell property vampiresundamage04  auto  
globalvariable property vampirefeedready  auto  
spell property vampiredrain01  auto  
spell property vampiredrain02  auto  
spell property vampiredrain03  auto  
spell property vampiredrain04  auto  
spell property vampireraisethrall01  auto  
spell property vampireraisethrall02  auto  
spell property vampireraisethrall03  auto  
spell property vampireraisethrall04  auto  
spell property vampireinvisibilitypc  auto  
spell property vampirecharm  auto  
spell property vampirehunterssight  auto  
spell property dlc1abvampirefloatbodyfx  auto
armor property dlc1vampirelordarmor  auto  
message property dlc1vampireperkearned  auto  
globalvariable property dlc1vampiremaxperks  auto  
spell property dlc1vampirechange  auto  
perk property dlc1unearthlywill  auto  
perk property dlc1vampirebite  auto  
perk property dlc1detectlifeperk  auto  
perk property dlc1mistformperk  auto  
perk property dlc1supernaturalreflexesperk  auto  
perk property dlc1corpsecurseperk  auto  
perk property dlc1gargoyleperk  auto  
perk property dlc1vampiricgrip  auto  
spell property currentequippedleftspell  auto  
spell property dlc1revert  auto
magiceffect property dlc1reverteffect auto
globalvariable property dlc1vampiretotalperksearned  auto  
effectshader property dlc1vampirechangebackfxs auto
effectshader property dlc1vampirechangeback02fxs auto
perk property lightfoot  auto  
bool property dlc1haslightfoot  auto  
faction property hunterfaction  auto  
faction property dlc1playervampirelordfaction  auto  
quest property dialoguegenericvampire  auto  
spell property dlc1nightcloak  auto  
perk property dlc1nightcloakperk  auto  
spell property dlc1vampirelordsundamage  auto  
spell property leveledraisedeadspell  auto  
;This file was cleaned with PapyrusSourceHeadliner 1