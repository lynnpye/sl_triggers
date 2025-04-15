scriptname dlc1magiccastfromsunscript extends activemagiceffect  
float property fheightfudge = 80.0 auto
float property fsunvectorscale = 18.0 auto
float property fbeamdurationdelay = 1.0 auto
float property fwaitdelay = 1.1 auto
static property placedxmarker auto
float property fexplosionvectorscale = 7.0 auto
spell property spellref auto
activator property activatorref auto
explosion property explosionref auto
float property factivatordeletedelay = 15.0 auto
weather property weatherform auto
bool property bholdweatheruntilend = false auto
bool property buselocalniceweather = false auto
float property fxybaserandom = 1024.0 auto
float property frecast = 1.0 auto
float property frecastrand = 0.0 auto
musictype property mymusic auto
event oninit()
endevent
event oneffectstart(actor target, actor caster)
endevent
event onupdate()
endevent
event onupdategametime()
endevent
event oneffectfinish(actor target, actor caster)
endevent
function castspellfromsun(bool bwewanttomiss)
endfunction
function placeexplosionandrotate()
endfunction
float[] function findsunartlocation(float fvscale = 1.0)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1