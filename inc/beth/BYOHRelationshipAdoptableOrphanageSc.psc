scriptname byohrelationshipadoptableorphanagesc extends quest conditional
objectreference property constancemichelref auto ;constance
objectreference property francoisref auto   ;standard orphanage children
objectreference property runaref auto
objectreference property samuelref auto
objectreference property hroarref auto
referencealias property orphan01 auto ;newly-orphaned children transferred to the orphanage
referencealias property orphan02 auto
referencealias property orphan03 auto
referencealias property orphan04 auto
referencealias property orphan05 auto
referencealias property orphan06 auto
referencealias property orphan07 auto
objectreference property honorhallorphanageextrabeds_enable auto  ;when we transfer new orphans to the orphanage, swap out these
objectreference property honorhallorphanageextrabeds_disable auto ;  sets of furniture and idle markers.
location property riftenhonorhallorphanagelocation auto ;orphanage's location.
objectreference property byohorphanagemarker auto   ;a marker to move transferred children to.
faction property byohrelationshipadoptablefaction auto ;standard adoptable faction.
faction property byohrelationshipadoptionfaction auto  ;standard adoption faction.
faction property favorjobsbeggarfaction auto    ;beggar faction (which we need to strip from some newly-orphaned children).
int property orphanagefactionrank auto      ;the current faction rank most of the orphanage children are in.
int property orphanagehouseloc auto       ;the current house most of the orphanage children will be directed to.
quest property byohrelationshipadoptable auto    ;main adoptable quest.
quest property db01 auto
function queststarted()
endfunction
bool function acceptingtransfers(actor child)
endfunction
function transferorphan(actor child)
endfunction
function enableorphanageadoptions()
endfunction
function disableorphanageadoptions()
endfunction
function storehouselocation(int loc)
endfunction
function checkadoptorphanagechild(objectreference child, int childnum)
endfunction
function constancekilled()
endfunction
event onupdategametime()
endevent
function enableorphanedorphanageadoptions()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1