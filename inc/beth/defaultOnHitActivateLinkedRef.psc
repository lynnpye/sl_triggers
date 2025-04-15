scriptname defaultonhitactivatelinkedref extends actor
bool property doonce = false  auto
keyword property linkkeyword auto
auto state waiting
event onhit(objectreference akaggressor, form akweapon, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
endstate
state alldone
endstate
;This file was cleaned with PapyrusSourceHeadliner 1