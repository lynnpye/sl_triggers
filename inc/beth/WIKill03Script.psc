scriptname wikill03script extends worldinteractionsscript  conditional
int property prank auto
int property pbaseinheritance auto
int property pinheritance auto
float property ptax = 0.10 auto
int property ptaxedamount auto
int property paward auto
int property pdelivered auto
keyword property ptraitrich  auto  
miscobject property pgold001  auto  
book property pletter  auto  
quest property pwicourier  auto  
globalvariable property wikill03inheritance auto
globalvariable property wikill03tax auto
event onstorykillactor(objectreference akvictim, objectreference akkiller, location aklocation, int aicrimestatus, int airelationshiprank)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1