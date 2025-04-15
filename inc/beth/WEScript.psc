scriptname wescript extends quest  conditional
weparentscript property weparents auto
scene property scenea auto
scene property sceneb auto
bool property stopquestwhenaliasesunload = true auto
float property stopquestpollingfrequencey = 1.0 auto
float property num1 auto conditional
float property num2 auto conditional
float property num3 auto conditional
int property scenestage auto hidden conditional ;can be used on scene action conditions (like conditionalizing a stack of repeating infos)
event onupdategametime()
endevent
function aliasloadingorunloading(bool isloading)
endfunction
function registerforstopquest() ;called above, and in the rare/impossible scenario of a wealiasscript reference trying to detach before it has ever attached
endfunction
function pacifyalias(referencealias aliastopacify)
endfunction
function makealiasaggressiveandattackplayer(referencealias aliastoanger)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1