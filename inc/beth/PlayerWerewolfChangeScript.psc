scriptname playerwerewolfchangescript extends quest  
float property standarddurationseconds auto
float property durationwarningtimeseconds auto
float property feedextensiontimeseconds auto
visualeffect property feedbloodvfx auto
race property werewolfbeastrace auto
objectreference property lycanstash auto
perk property playerwerewolffeed auto
faction property playerwerewolffaction auto
faction property werewolffaction auto
message property playerwerewolfexpirationwarning auto
message property playerwerewolffeedmessage auto
globalvariable property gamedayspassed auto
globalvariable property timescale auto
globalvariable property playerwerewolfshiftbacktime auto
imagespacemodifier property werewolfwarn auto
imagespacemodifier property werewolfchange auto
race property werewolfrace auto
sound property npcwerewolftransformation auto
sound property werewolfimodsound auto
idle property werewolftransformback auto
idle property specialfeeding auto
quest property companionstrackingquest auto
quest property c03rampage auto
shout property currenthowl auto
wordofpower property currenthowlword1 auto
wordofpower property currenthowlword2 auto
wordofpower property currenthowlword3 auto
spell property playerwerewolflvl10andbelowability auto
spell property playerwerewolflvl15andbelowability auto
spell property playerwerewolflvl20andbelowability auto
spell property playerwerewolflvl25andbelowability auto
spell property playerwerewolflvl30andbelowability auto
spell property playerwerewolflvl35andbelowability auto
spell property playerwerewolflvl40andbelowability auto
spell property playerwerewolflvl45andbelowability auto
spell property playerwerewolflvl50andoverability auto
spell property feedboost auto
spell property bleedingfxspell auto
armor property wolfskinfxarmor auto
bool property untimed auto
formlist property crimefactions auto
formlist property werewolfdispellist auto
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
function setuntimed(bool untimedvalue)
endfunction
function feed(actor victim)
endfunction
function warnplayer()
endfunction
function shiftback()
endfunction
event onanimationevent(objectreference aksource, string aseventname)
endevent
function actuallyshiftbackifnecessary()
endfunction
function shutdown()
endfunction
float property dlc1gorgingdurationseconds  auto  
perk property dlc1gorgingperk  auto  
perk property dlc1savagefeedingperk  auto  
keyword property actortypenpc  auto  
perk property dlc1animalvigor  auto  
globalvariable property dlc1werewolftotalperksearned  auto  
globalvariable property dlc1werewolfmaxperks  auto  
;This file was cleaned with PapyrusSourceHeadliner 1