scriptname ms12postquestscript extends quest  
miscobject property emptyphial auto
potion property replicated auto
potion property healpotion auto
potion property resistmagicpotion auto
potion property resistdamagepotion auto
potion property improvemagicpotion auto
potion property improvedamagepotion auto
potion property improvesneakpotion auto
message property ms12refillmessage auto
referencealias property phialalias auto
function setreward(string rewardtype)
endfunction
event onupdategametime()
endevent
function rewardcheck(bool quiet = false)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1