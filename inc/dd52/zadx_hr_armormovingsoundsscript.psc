scriptname zadx_hr_armormovingsoundsscript extends activemagiceffect
actor property wearer auto
float property delay auto
sound[] property soundeffectsmoving auto
event oneffectstart(actor aktarget, actor akcaster)
endevent
event onanimationevent(objectreference aksource, string aseventname)
endevent
function playdelayedsoundeffects()
endfunction
function playsoundeffects()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1