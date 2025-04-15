scriptname tgrshellscript extends quest  conditional
globalvariable property ptgstatuscount  auto  conditional
int property ptgrgfrun auto conditional            ;1= "gone fishing" radiant has been taken
int property ptgrberun auto conditional             ;1= "breaking and entering" radiant has been taken
int property ptgrforun auto conditional            ;1= "forgery" radiant has been taken
int property ptgrhcrun auto conditional            ;1= "housecleaning" radiant has been taken
int property ptgrntrun auto conditional            ;1= "night on the town" radiant has been taken
int property ptgrdurun auto conditional            ;1= "duplicity" radiant has been taken
int property ptgrslrun auto conditional             ;1= "shoplifter" radiant has been taken
int property ptgrdelvindone auto conditional           ;1= delvin's radiant has been completed, but not turned in
int property ptgrvexdone auto conditional            ;1= vex's radiant has been has been completed, but not turned in
int property ptgrdelvinrunning auto conditional           ;1= delvin mallory has given the player a radiant quest
int property ptgrvexrunning auto conditional           ;1= vex has given the player a radiant quest
int property ptgrwhiteruncount auto conditional
int property ptgrwindhelmcount auto conditional
int property ptgrriftencount auto conditional
int property ptgrmarkarthcount auto conditional
int property ptgrsolitudecount auto conditional
int property ptgrfirstcap auto conditional
int property ptgrcapcount  auto  conditional
int property ptgrwrsaid auto conditional
int property ptgrslsaid auto conditional
int property ptgrwhsaid auto conditional
int property ptgrmksaid auto conditional
location property ptgrwhiterun auto conditional
location property ptgrwindhelm auto conditional
location property ptgrriften auto conditional
location property ptgrmarkarth auto conditional
location property ptgrsolitude auto conditional
keyword property ptgradiantstartbe auto conditional
keyword property ptgradiantstartdu auto conditional
keyword property ptgradiantstartfo auto conditional
keyword property ptgradiantstartgf auto conditional
keyword property ptgradiantstarthc auto conditional
keyword property ptgradiantstartnt auto conditional
keyword property ptgradiantstartsl auto conditional
quest property ptgrbequest auto conditional
quest property ptgrduquest auto conditional
quest property ptgrfoquest auto conditional
quest property ptgrgfquest auto conditional
quest property ptgrhcquest auto conditional
quest property ptgrntquest auto conditional
quest property ptgrslquest auto conditional
quest property ptgtq01quest auto conditional
quest property ptgtq02quest auto conditional
quest property ptgtq03quest auto conditional
quest property ptgtq04quest auto conditional
quest property ptgstatusquest auto conditional
quest property ptg09quest auto conditional
quest property ptglead auto conditional
tgrshellscript property ptgrshellscript  auto  conditional
globalvariable property pwhiterun  auto  
globalvariable property pwindhelm  auto  
globalvariable property psolitude  auto  
globalvariable property pmarkarth  auto
globalvariable property ptgrarrestdelvin auto
globalvariable property ptgrarrestvex auto
globalvariable property ptgrquitvex auto conditional
globalvariable property ptgrquitdelvin auto conditional
function tgradiantcount(location tgradiantcity)
endfunction
function bequit()
endfunction
function tgstatuscheck()
endfunction
function tgleadercheck()
endfunction
function tgarrestedcheck()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1