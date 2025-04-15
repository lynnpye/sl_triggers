scriptname tg02questscript extends quest  conditional
int property ptg02scenestart auto conditional
int property ptg02brynjolfmove auto conditional           ;1= triggers brynjolf's escort (temp travel for now)
int property ptg02brynjolfreaction auto conditional          ;x= a variable to measure brynjolf's post-discussion reaction
int property ptg02hivedestroy auto conditional           ;x= the number of bee hives destroyed
int property ptg02jobdone auto  conditional            ;2= player completed both tasks
int property ptg02safecracked auto conditional           ;1= player got the safe loot
int property ptg02mavendialogue auto conditional
int property ptg02questfailure auto conditional
int property ptg02forcegreet auto conditional
int property ptg02introdone auto conditional
int property ptg02dia auto conditional
int property ptg02dia01 auto conditional
int property ptg02dia02 auto conditional
int property ptg02housetriggerdone auto conditional
int property ptg02tunneltriggerdone auto conditional
int property ptg02aringothdone auto conditional
int property ptg02brynpathdone auto conditional
int property ptg02playerpathdone auto conditional
globalvariable property ptg02failure auto conditional
globalvariable property ptg02hivecount  auto  conditional 
quest property ptg03quest  auto conditional
quest property ptg02bquest auto conditional
alias property ptg02safecontentsalias  auto conditional
referencealias property ptg02billofsale auto conditional
scene property ptg02introscene  auto  conditional
scene property ptg02introscene02  auto  conditional
objectreference property ptg02guilddoor  auto  conditional
faction property ptg02tgfaction auto conditional
objectreference property ptg02hivemercs auto conditional
globalvariable property priften  auto
leveleditem property preward auto
event onupdate()
endevent
function hivegone()          ;when a bee hive is destoyed, do a bunch of housekeeping
endfunction
function removebillofsale()
endfunction
function rewarded()
endfunction
function sceneplay()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1