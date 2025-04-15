scriptname defaultfireweaponscript extends objectreference  
int property timesfired auto hidden
bool property looping auto hidden
float property waittimer auto hidden
int property timestofire = -1 auto
float property maxwaittime = 6.0 auto
float property minwaittime = 4.0 auto
weapon property weapontype auto
ammo property ammotype auto
quest property myquest auto
int property stagetostartfire = -1 auto
int property stagetostopfire = -1 auto
event onload()
endevent
event onunload()
endevent
auto state waiting
endstate
state fireloop
event onbeginstate()
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1