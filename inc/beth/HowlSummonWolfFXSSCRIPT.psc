scriptname howlsummonwolffxsscript extends actor  
effectshader property ghosteffect auto
float property ghostalpha=0.1 auto
event onload()
endevent
event onupdate()
endevent
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
event onanimationevent(objectreference aksource, string eventname)
endevent
event ondying(actor killer)
endevent
function turnoff()
endfunction
function ghostflash()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1