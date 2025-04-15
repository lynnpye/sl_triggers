scriptname dunpotemasms06bossfightdummy extends objectreference  
quest property myquest auto
objectreference property potema auto
objectreference property potemaskeleton auto
objectreference property tombdoor auto
objectreference property fxtodisableatend auto
objectreference property defeatsfxmarker auto
spell property magicattack auto
spell property beamattack auto
spell property raise auto
string property phase = "inactive" auto hidden
activator property fxemptyactivator auto
sound property qstms06potemabanishexplosion auto
objectreference property sfxidle01 auto
objectreference property sfxidle02 auto
objectreference property wavea01 auto hidden
objectreference property wavea02 auto hidden
objectreference property waveb01 auto hidden
objectreference property waveb02 auto hidden
objectreference property waveb03 auto hidden
objectreference property wavec01 auto hidden
objectreference property wavec02 auto hidden
objectreference property wavec03 auto hidden
event onload()
endevent
event onanimationevent(objectreference aksource, string aseventname)
endevent
function attackfunc()
endfunction
function setupaliases()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1