scriptname tg08bfloodpipecontroller extends objectreference
objectreference property waterstream auto
objectreference property sourcepipe auto
objectreference property intactpipe auto
objectreference property splash auto
objectreference property leaks auto
objectreference property submergedeffect auto
bool property waterstreamon = false auto hidden
bool property sourcepipeon  = false auto hidden
bool property intactpipeon  = true auto hidden
bool property splashon = false auto hidden
bool property leakson = false auto hidden
bool property submergedeffecton = false auto hidden
explosion property tg08pipeexplosion auto
string property statestring = "leaky" auto hidden
objectreference property waterplane auto hidden
objectreference property heighttarget auto hidden
float property afspeed = 0.5 auto hidden
float property afmaxrotationspeed = 0.0 auto hidden
bool property pipebig = true auto
float property waterstreamzoffset = 0.0 auto ;= 1000.0 auto
float property waterstreamzoffsetbig = 0.0 auto ;= 1450.0 auto
float property splashzoffset = 0.0 auto
float property splashzoffsetbig = 0.0 auto
float property waterstreamstartingheightoffset = 0.0 auto
float property waterfallspeed = 1000.0 auto hidden
auto state intact
event onbeginstate()
endevent
endstate
state leaky
event onbeginstate()
endevent
endstate
state broken
event onbeginstate()
endevent
endstate
state submerged
event onbeginstate()
endevent
endstate
bool property initialtranslationcomplete = false auto hidden
event onactivate(objectreference akactivator)
endevent
function localgotostate (string mystate)
endfunction
float property tg08enablelinkchaintimer auto hidden
function tg08enablelinkchain(objectreference currentlink)
endfunction
function tg08disablelinkchain(objectreference currentlink)
endfunction
float property tg08matchtranslatelinkchaintimer auto hidden
function tg08matchtranslatelinkchain(objectreference currentlink)
endfunction
float property tg08matchwaterstreamtimer auto hidden
function tg08matchwaterstream(objectreference currentlink) 
endfunction
float property tg08enablewaterstreamtimer auto hidden
function tg08enablewaterstream(objectreference currentlink)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1