scriptname cwmission06script extends cwmissionscript  conditional
scene property cwmission06scene  auto  
int property killloyalists  auto hidden conditional
referencealias property turncoatleader auto
keyword property loctypehabitation auto
int property turncoatalivecount auto conditional hidden ;set in stage 0
int property loyalistalivecount auto conditional hidden ;set in stage 0 by calling getloyalistalivecount() function
actorbase property cwmission06loyalistleaderimperial auto
actorbase property cwmission06dissaffectsoldierimperial1 auto
actorbase property cwmission06dissaffectsoldierimperial2 auto
actorbase property cwmission06dissaffectsoldierimperial3 auto
actorbase property cwmission06loyalistleadersons auto
actorbase property cwmission06dissaffectsoldiersons1 auto
actorbase property cwmission06dissaffectsoldiersons2 auto
actorbase property cwmission06dissaffectsoldiersons3 auto
event onupdate()
endevent
function setinitialloyalistalivecount( \
referencealias loyalistleader, \
endfunction
function decrementloyalistalivecount()
endfunction
function decrementturncoatalivecount()
endfunction
function processprerevoltfactions(referencealias aliastoprocess)
endfunction
function processpostrevoltfactions(referencealias aliastoprocess)
endfunction
function givenewoutfit(actor actorref)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1