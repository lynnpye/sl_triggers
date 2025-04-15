scriptname survival_diseasecontractmessagescript extends activemagiceffect
message property diseasemessage auto
spell property diseasespell auto
bool property progressibledisease auto
bool property affectsattribute auto
survival_attributeeffectwatchscript property needalias auto
spell property diseasetoprogressinto auto
globalvariable property survival_diseaseprogressionspeed auto
event oneffectstart(actor aktarget, actor akcaster)
endevent
event onupdategametime()
endevent
event oneffectfinish(actor aktarget, actor akcaster)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1