scriptname ccbgs_arfloorsmasherscript extends objectreference
actor property playerref auto
bool property bplayeronly = true auto
float property fdelayreturn = 1.5 auto
float property fdelayreset = 5.0 auto
sound property ccbgs_trp_trparfloorsmasherup01sd auto
sound property ccbgs_trp_trparfloorsmasherdown01sd auto
auto state waiting
event ontriggerenter(objectreference akactionref)
endevent
endstate
state busy
endstate
;This file was cleaned with PapyrusSourceHeadliner 1