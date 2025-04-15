scriptname stockadebarricade01activatorscript extends objectreference  
int property oldstage = 3 auto
int property newstage = 4 auto
sound property objcwbarricadedamage auto
sound property objcwbarricadedestroyed auto
event onload()
endevent
event onunload()
endevent
event ondestructionstagechanged(int aioldstage, int aicurrentstage)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1