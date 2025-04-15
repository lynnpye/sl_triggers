scriptname defaultactivatelinkedrefonattacked extends actor
keyword property linkkeyword auto
bool property onlyonce = true auto
bool property onlyplayer = false auto
int property minnumberhits = 1 auto
auto state waiting
event onhit(objectreference aggressor, form weap, projectile proj, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
endstate
state inactive
endstate
;This file was cleaned with PapyrusSourceHeadliner 1