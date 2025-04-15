scriptname defaultsetstageonattackedrefalias extends referencealias
quest property myqst auto
int property prereqstage = -1 auto
int property minnumberhits = 1 auto
int property stagetoset auto
bool property playeronly auto
auto state waiting
event onhit(objectreference aggressor, form weap, projectile proj, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
endstate
state inactive
endstate
;This file was cleaned with PapyrusSourceHeadliner 1