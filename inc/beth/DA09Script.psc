scriptname da09script extends quest  conditional
objectreference property da09statuegemreference auto
objectreference property da09statuegemmarker auto
objectreference property da09statuegemreturnmarker auto
objectreference property da09statuebeamtarget auto
objectreference property da09statuebeamtarget2 auto
objectreference property da09meridiastatuefxref auto
spell property beamspell auto 
objectreference property da09floatmarker1 auto
objectreference property da09floatmarker2 auto
objectreference property da09fxbeamskyref auto
objectreference property da09skybeam2 auto
objectreference property qstbeammeridiastatuelpref auto
imagespacemodifier property da09skyfadeinout auto  ;old version
imagespacemodifier property da09whiteimod auto  
imagespacemodifier property da09bloomimod auto  
objectreference property da09meridiastartmarker auto
objectreference property da09skymarker auto
objectreference property da09skymarkerb auto
objectreference property da09statuemarker auto
objectreference property da09skyplanecollision auto
objectreference property dungeonblockertoggle auto
leveleditem property da09dawnbreakerlist auto
scene property da09skyscene auto
scene property da09gemscene auto
scene property da09caveinscene auto
int property questhook auto hidden conditional   ;0 = unset, 1 = player got quest hook from meridia
int property gemscenestage auto hidden conditional   ;0 = unset, n = which line of dialogue to say in da09gemscene
referencealias property xmarkervoice auto
globalvariable property da09changelocchance auto
visualeffect property da09vision auto 
int property playerinqthelpertrigger auto hidden conditional  ;see da09questtargethelpertriggerscript attached to questtargethelpertrigger alias
actor property da09meridiaref auto
objectreference property da09pedestalref auto
objectreference property da09pedestalemptyref auto
objectreference property fxnecrotendrilringref auto
faction property da09temporarydragonfriendfaction auto
globalvariable property gamedayspassed auto
globalvariable property winextdragon auto
function forcecameraanddisablecontrols()
endfunction
function safeguardagainstdragons(bool preventdragonattacks = true)
endfunction
function moveplayertosky()
endfunction
function moveplayertoearth()
endfunction
function teleportplayertosky()
endfunction
function startcavein()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1