scriptname rpdefault_ferrysystem extends quest conditional
string property sdriverchattercontrolav = "variable01" autoreadonly
string property scarryweightav = "carryweight" autoreadonly
string property sinventoryweightav = "inventoryweight" autoreadonly
int property itravelresult_failed = 0 autoreadonly
int property itravelresult_success = 1 autoreadonly
int property itravelresult_waitingforsit = 2 autoreadonly
miscobject property gold auto
topic property dialoguecarriagechattertopic auto
idle property idlecartdriveridle auto
imagespacemodifier property fadetoblackimod auto
imagespacemodifier property fadetoblackholdimod auto
imagespacemodifier property fadetoblackbackimod auto
bool property bwaitforplayertosit = true auto conditional
bool property bpreventplayertravelingoverencumbered = true auto
bool property btravelservicescostgold = true auto
globalvariable property gallowcarriagedriverchattertime auto
referencealias property playerseat auto
referencealias property playerseat2 auto
keyword property dlc1linkferryseat1 auto
keyword property dlc1linkferryseat2 auto
globalvariable property ferrycost auto
actor property kcurrentdriver auto hidden
objectreference property ktargetdestination auto hidden
event oninit()
endevent
event onupdate()
endevent
int function trytotravel(objectreference akdestinationref, actor akdriver)
endfunction
function payfortravel()
endfunction
function clearwaitingstate()
endfunction
bool function handleplayersat()
endfunction
function skiptodestinationsimple()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1