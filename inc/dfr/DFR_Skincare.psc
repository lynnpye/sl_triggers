scriptname dfr_skincare extends quest conditional
qf__gift_09000d62 property flow auto
actor property playerref auto
sexlabframework property sl auto
dfr_relationshipmanager property relmanager auto
potion property regularlotion auto
potion property speciallotion auto
globalvariable property gamedayspassed auto
float property lastappliedtimer auto hidden conditional
float property lastgiventimer auto hidden conditional
float property lotionapplyduration = 24.0 auto hidden
bool property gavespeciallotion = false auto hidden conditional
bool property fakeranout = false auto hidden conditional
bool property washedoff = false auto hidden conditional
bool property gavedirect = false auto hidden conditional
function maintenance()
endfunction
function setup()    
endfunction
function givelotion(bool abforcespecial = false)
endfunction
function onapplylotion(form akitem)
endfunction
event onbis_batheevent(form aktarget)
endevent
function resettimer(bool abpunish = false)
endfunction
function givedirect()
endfunction
function log(string asmsg)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1