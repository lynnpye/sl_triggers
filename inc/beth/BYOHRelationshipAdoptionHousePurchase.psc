scriptname byohrelationshipadoptionhousepurchase extends quest
objectreference property solitudeplayerhousedecoratelivingroomsupplemental auto
objectreference property solitudeplayerhousedecoratelivingroomsupplementaldisable auto
objectreference property solitudeplayerhousedecoratechildroom auto
objectreference property solitudeplayerhousedecoratechilddisable auto
objectreference property windhelmplayerhousedecoratechildroom auto
objectreference property windhelmplayerhousedecoratechildroomspecialdisable auto
objectreference property markarthplayerhousedecoratealchemy auto
objectreference property markarthplayerhousedecoratechildroom auto
objectreference property markarthplayerhousedecoratechildroomspecialdisable auto
objectreference property riftenplayerhousedecorateenchanting auto
objectreference property riftenplayerhousedecoratechildroom auto
objectreference property whiterunplayerhousealchemylaboratory auto
objectreference property whiterunplayerhousechildbedroom auto
quest property relationshipadoptable auto ;pre-adoption quest quest.
objectreference property solitudeplayerhousedecoratelivingroom auto   ;markers whose state we need to test against.
objectreference property markarthplayerhousedecoratealchemydisable auto
objectreference property riftenplayerhousedecorateenchantingdisable auto
objectreference property whiterunplayerhousealchemylaboratorystart auto
globalvariable property hdsolitudechildroom auto ;cost of the childrens' bedrooms in each house.
globalvariable property hdwindhelmchildroom auto
globalvariable property hdmarkarthchildroom auto
globalvariable property hdriftenchildroom auto
globalvariable property hdwhiterunchildroom auto
function byohrelationshipadoptionhousepurchasestartup()
endfunction
function solitude_enablelivingroom()
endfunction
function solitude_enablechildbedroom()
endfunction
function windhelm_enablechildbedroom()
endfunction
function markarth_enablechildbedroom()
endfunction
function markarth_enablechildbedroomalternative()
endfunction
function riften_enablechildbedroom()
endfunction
function riften_enablechildbedroomalternative()
endfunction
function whiterun_enablechildbedroom()
endfunction
function whiterun_enablechildbedroomalternative()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1