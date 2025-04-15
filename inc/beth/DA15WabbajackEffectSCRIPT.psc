scriptname da15wabbajackeffectscript extends activemagiceffect  
miscobject property gold auto
potion property sweetroll auto
miscobject property plate auto
spell property healspell auto
spell property invis auto
explosion property firespell auto
explosion property frostspell auto
explosion property stormspell auto
actorbase property skeever auto
actorbase property wolf auto
actorbase property bandit auto
actorbase property draugr auto
actorbase property falmer auto
actorbase property dragonpriest auto
actorbase property atronach auto
faction property playerfaction auto
explosion property forceexplosion auto
explosion property visualexplosion auto
objectreference property explosionmarker auto
effectshader property wabbahiteffect auto
spell property ghostspell auto
keyword property keywabbajackexcluded auto
keyword property keygiant auto
keyword property keydragon auto
actorbase property chicken auto
actorbase property mudcrab auto
actorbase property rabbit auto
actorbase property dremora auto
actorbase property madwoman auto
float property fdelay = 0.75 auto
float property fdelayend = 1.65 auto
float property shaderduration = 0.00 auto
activator property pdefaultashpileghost auto
bool property bsetalphazero = true auto
formlist property pdisintegrationmainimmunitylist auto
effectshader property pghostdeathfxshader auto
event oneffectstart(actor aktarget, actor akcaster)
endevent
function basicdamage(actor targ)
endfunction
function randomcreaturechicken(actor targ)
endfunction
function randomcreaturemudcrab(actor targ)
endfunction
function randomcreaturerabbit(actor targ)
endfunction
function randomcreaturedremora(actor targ)
endfunction
function spawnghostfriend(actor targ)
endfunction
function elementaleffect(actor targ)
endfunction
function castinvis(actor targ)
endfunction
function hsmtransfer(actor targ)
endfunction
function spawngold(actor targ)
endfunction
function spawnsweetroll(actor targ)
endfunction
function createashpile()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1