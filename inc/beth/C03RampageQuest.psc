scriptname c03rampagequest extends quest  
objectreference property rampagestartmarker auto
faction property playerwerewolffaction auto
faction property werewolffaction auto
formlist property crimefactions auto
objectreference property lycanstash auto
race property werewolfrace auto
race property nordrace auto
visualeffect property feedbloodvfx auto
referencealias property aela auto ; on c03
objectreference property aelalycanstash auto
outfit property aelaoutfit auto
referencealias property kodlak auto
referencealias property farkas auto
referencealias property vilkas auto
referencealias property athis auto
referencealias property njada auto
referencealias property ria auto
referencealias property torvar auto
float property rampageminutesgametime auto
float property fadeseconds auto
idle property bleedoutidle auto
scene property postrampagescene auto
spell property immunity auto
spell property werewolfcuredisease auto
quest property playervampirequest auto
quest property playerwerewolfcurequest auto
keyword property vampirekeyword auto
imagespacemodifier property werewolfchange auto
imagespacemodifier property fadetoblack auto
imagespacemodifier property holdblack auto
imagespacemodifier property fadefromblack auto
shout property currenthowl auto
wordofpower property currenthowlword1 auto
wordofpower property currenthowlword2 auto
wordofpower property currenthowlword3 auto
spell property feedboost auto
spell property beastform auto
idle property specialfeeding auto
musictype property combatmusic auto
function startrampage()
endfunction
event onupdategametime()
endevent
function turnback()
endfunction
function restoreplayerrace()
endfunction
function feed(actor victim)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1