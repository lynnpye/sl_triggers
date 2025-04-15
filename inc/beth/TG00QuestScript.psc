scriptname tg00questscript extends quest  conditional
referencealias property ptg00brynjolfalias  auto  conditional
potion property ptg00blood auto conditional
miscobject property ptg00gold auto conditional
armor property ptg00mdesiring auto conditional
int property ptg00mover  auto  conditional
int property ptg00sceneboot  auto  conditional
int property ptg00help auto conditional
int property ptg00fgdone01 auto conditional
int property ptg00havering auto conditional
int property ptg00reward = 100 auto  conditional
int property ptg00dialogue01 auto conditional
int property ptg00killer auto conditional
int property ptg00gateguardkilled auto conditional
int property ptg00brynpass auto conditional
int property ptg00arreststopper auto conditional
float property ptg00toomuchtime auto conditional
quest property ptg01  auto
quest property ptg00sp  auto
quest property ptg00sparrest auto
quest property ptg00 auto
globalvariable property ptgfailure  auto  conditional
globalvariable property gamedayspassed auto
keyword property ptg00cwowner auto conditional
objectreference property ptg00guardimperial auto conditional
objectreference property ptg00guardstormcloak auto conditional
quest property ptg00mischandler  auto  conditional
event onupdate()
endevent
function setuptimer()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1