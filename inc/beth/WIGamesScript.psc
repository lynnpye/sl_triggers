scriptname wigamesscript extends quest
referencealias property playera auto
referencealias property playerb auto
referencealias property playerc auto
referencealias property playerd auto
referencealias property playere auto
referencealias property playerisit auto  ;alias to the tag player who is it
int property numplayers auto conditional hidden
int property isplayerinvolved auto conditional hidden ;is the player involved?
int property objectiveplayerit = 20 auto hidden   ;number of the objective to display if the player is it (as in game.getplayer() is it)
int property objectiveplayernotit = 10 auto hidden ;number of objective to display if the player is not it
int property defaulttimetorungame = 90 auto hidden ;if the event that starts the quest doesn't come in with a value1 use this as the number of seconds to run before stopping
scene property scenetoplayaftertagged = none auto
event onstoryscript(keyword akkeyword, location aklocation, objectreference akref1, objectreference akref2, int aivalue1, int aivalue2)
endevent
event onupdate()
endevent
function setnumplayers()
endfunction
function setisplayerinvolved()
endfunction
function tag(actor whotagged, actor whogottagged, form callingform)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1