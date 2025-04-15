scriptname cwmissiongeneratortriggerscript extends objectreference  
cwscript property cw auto
actor property rikkeref auto
actor property galmarref auto
keyword property cwcampimperial auto
keyword property cwcampsons auto
keyword property cwlinkfieldcoenable auto ;keyword on linked ref to generate field co so we can enable disable him as appropriate when rikke/galmar is present or not
objectreference property myenablemarker auto
event oncellattach()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1