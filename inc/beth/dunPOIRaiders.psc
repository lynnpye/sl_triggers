scriptname dunpoiraiders extends objectreference
actorbase property raider1base auto
actorbase property raider2base auto
actorbase property raider3base auto
int property raider1count = 1 auto
int property raider2count = 1 auto
int property raider3count = 1 auto
encounterzone property zone auto
int property raider1difficulty = 0 auto
int property raider2difficulty = 0 auto
int property raider3difficulty = 0 auto
int property distancetospawn = 3000 auto
objectreference property firstspawnpoint auto
auto state waiting
event onload()
endevent
event onunload()
endevent
endstate
state alldone
event onload()
endevent
event onunload()
endevent
endstate
function updateloop()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1