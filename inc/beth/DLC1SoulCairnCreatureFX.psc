scriptname dlc1soulcairncreaturefx extends activemagiceffect 
visualeffect property fxsccreaturemultieffect auto
visualeffect property fxsccreatureeyegloweffect auto
effectshader property sccreaturedeathfxs auto
activator property ashpileobject auto
leveleditem property dlc01deathitemmistman auto
bool property issummonable = false auto
event oneffectstart(actor target, actor caster) 
endevent
event oneffectfinish(actor aktarget, actor akcaster)  
endevent
event ongetup(objectreference akfurniture)
endevent
event ondying(actor mykiller)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1