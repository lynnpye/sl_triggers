scriptname wealiasscript extends referencealias  
bool property registerloadingandunloading = true auto
int property stopregisteringunloadingifstagehasbeenset = -1 auto
bool property pacifyonload = false auto
bool property makeaggressiveandattackplayerifattacked = false auto
bool property makeaggressiveongainlostoplayer = false auto
float property makeaggressiveondistancetoplayer = 0.0 auto
bool property initiallydisabled = false auto
bool property disableonunload = false auto
bool property killonload = false auto
bool property disintegrateonload = false auto
faction property putinthisfactiononload auto
activator property defaultashpile1 auto
event onupdate()
endevent
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
event ongainlos(actor akviewer, objectreference aktarget)
endevent
event oncellattach()
endevent
event onattachedtocell()
endevent
event oncelldetach()
endevent
event ondetachedfromcell()
endevent
event onload()
endevent
event ondying(actor akkiller)
endevent
event onunload()
endevent
function trytoattach()
endfunction
function trytodetach()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1