scriptname clearskieseffectscript extends activemagiceffect  
globalvariable property magprojectilestormvar auto
spell property mqclearskyfogspell auto
event oneffectstart(actor aktarget, actor akcaster)
endevent
event oneffectfinish(actor aktarget, actor akcaster)
endevent
int property newweathertype = 0  auto  
formlist property weatherexceptionlist  auto  
;This file was cleaned with PapyrusSourceHeadliner 1