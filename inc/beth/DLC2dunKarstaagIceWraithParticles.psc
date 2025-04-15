scriptname dlc2dunkarstaagicewraithparticles extends activemagiceffect  
visualeffect property icewraithparticles01 auto
armor property skinicewraithsmokefins  auto   
visualeffect property fxicewraith2ndformeffect auto
string property grounddiveicehazard auto 
string property changeforms auto 
spell property walloffrosticewraith auto
float property scalerangemax = 1.1auto 
float property scalerangemin = 0.9 auto 
explosion property deathexplosion auto
activator property ashpileobject auto
event oneffectstart(actor target, actor caster) 
endevent
event oneffectfinish(actor aktarget, actor akcaster)
endevent
event onanimationevent(objectreference aksource, string aseventname)
endevent
event ondying(actor mykiller)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1