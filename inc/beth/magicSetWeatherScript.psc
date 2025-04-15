scriptname magicsetweatherscript extends activemagiceffect
weather property weatherform auto
int property localweathera = 0 auto
int property localweatherb = 1 auto
bool property buseendweatherifnooption = true auto
weather property weatherafterform auto
bool property bholdweatheruntilend = true auto
event oneffectstart(actor target, actor caster)
endevent
event oneffectfinish(actor target, actor caster)
endevent
formlist property weatherexceptionlist  auto  
;This file was cleaned with PapyrusSourceHeadliner 1