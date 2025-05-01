scriptname zadleasheffect extends activemagiceffect
float property effectinterval = 5.0 auto
zadlibs property libs auto
objectreference property master auto
referencealias property masteralias auto
int property maxdistancefrommaster = 350 auto
sexlabframework property sexlab auto
actor property target auto hidden
bool property terminate auto hidden
int property zonelength = 200 auto
event onupdate()
endevent
function setactorvaluemodifier(string avname, float newmod)
endfunction
function doregister()
endfunction
event oneffectstart(actor aktarget, actor akcaster)
endevent
event oneffectfinish(actor aktarget, actor akcaster)
endevent
event onplayerloadgame()
endevent
event onunload()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1