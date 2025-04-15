scriptname mq201thalmorembassydisguisescript extends actor  
formlist property mq201thalmordisguiseheaditems auto
formlist property mq201thalmordisguisebodyitems auto
race property highelfrace auto
race property nordrace auto
race property woodelfrace auto
race property darkelfrace auto
race property orcrace auto
race property khajiitrace auto
race property argonianrace auto
race property bretonrace auto
race property redguardrace auto
race property imperialrace auto
bool property issolarguard = false auto
float property frangeelf = 512.0 auto
float property frangehuman = 1280.0 auto
float property frangebeast = 1600.0 auto
faction property mq201thalmorfooledfaction auto
faction property mq201thalmorenemyfaction auto
bool property bdebug = true auto
event oninit()
endevent
state inactive
event onupdate()
endevent
event onload()
endevent
endstate
state active
event onupdate()
endevent
event onactivate(objectreference actronaut)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1