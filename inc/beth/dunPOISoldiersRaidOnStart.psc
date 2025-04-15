scriptname dunpoisoldiersraidonstart extends objectreference
objectreference property firstspawnpoint auto
actorbase property soldierbaseimp auto
actorbase property soldierbasesons auto
quest property cw auto
quest property raidquest auto
referencealias property soldier1alias auto
referencealias property soldier2alias auto
referencealias property forsworn1alias auto
auto state waiting
event onload()
endevent
event onunload()
endevent
endstate
state waitingforunload
event onunload()
endevent
endstate
state alldone
event onload()
endevent
event onupdate()
endevent
event onunload()
endevent
endstate
function updateloop()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1