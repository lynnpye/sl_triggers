scriptname dlc1ld_forgemasterbossbattle extends referencealias conditional
objectreference property dlc1ld_forgemasterspawn1 auto
objectreference property dlc1ld_forgemasterspawn2 auto
spell property dlc1ld_forgemasterfirebreath01 auto
spell property dlc1ld_forgemasterfirebreath02 auto
spell property dlc1ld_forgemasterfirebreath03 auto
spell property dlc1ld_forgemasterfireball01 auto
spell property dlc1ld_forgemasterfireball02 auto
spell property dlc1ld_forgemasterfireball03 auto
shout property dlc1ld_forgemasterfirebreathshout01 auto
shout property dlc1ld_forgemasterfirebreathshout02 auto
shout property dlc1ld_forgemasterfirebreathshout03 auto
shout property dlc1ld_forgemasterfireballshout01 auto
shout property dlc1ld_forgemasterfireballshout02 auto
shout property dlc1ld_forgemasterfireballshout03 auto
quest property dlc1ld_bthalft auto
function startforgemaster()
endfunction
event onactivate(objectreference obj)
endevent
function runupdateloop()
endfunction
event onhit(objectreference aggressor, form weap, projectile proj, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
event onspellcast(form akspell)
endevent
function addfirebreathshout()
endfunction
function addfireballshout()
endfunction
function removefirebreathshout()
endfunction
function removefireballshout()
endfunction
shout function pickshout(shout s1, shout s2, shout s3)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1