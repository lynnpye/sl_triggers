scriptname rpdefault_carriagesystem extends quest conditional
string property sdriverchattercontrolav = "variable01" autoreadonly
string property scarryweightav = "carryweight" autoreadonly
string property sinventoryweightav = "inventoryweight" autoreadonly
int property itravelresult_failed = 0 autoreadonly
int property itravelresult_success = 1 autoreadonly
int property itravelresult_waitingforsit = 2 autoreadonly
keyword property linkcarriageseat auto
globalvariable property carriagecost auto
miscobject property gold auto
topic property dialoguecarriagechattertopic auto
idle property idlecartdriveridle auto
imagespacemodifier property fadetoblackimod auto
imagespacemodifier property fadetoblackholdimod auto
imagespacemodifier property fadetoblackbackimod auto
bool property bpreventplayertravelingoverencumbered = true auto
bool property bcarriageservicescostgold = true auto
globalvariable property gallowcarriagedriverchattertime auto
referencealias property playercarraigeseat auto
actor property kcurrentdriver auto hidden
objectreference property ktargetdestination auto hidden
event onupdate()
endevent
int function trytotravel(objectreference akdestinationref, actor akdriver)
endfunction
function payforcarriage()
endfunction
function clearwaitingstate()
endfunction
bool function handleplayersat()
endfunction
function skiptodestinationsimple()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1