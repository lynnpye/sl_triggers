scriptname cr03questscript extends companionsradiantquest conditional
referencealias property samplepelt auto
referencealias property samplepeltspawnpoint auto
int property updateinterval auto
int property minskins auto
int property maxskins auto
miscobject property bearcave auto
miscobject property bear auto
miscobject property bearsnow auto
miscobject property sabrecat auto
miscobject property sabrecatsnow auto
miscobject property wolfice auto
miscobject property wolf auto
globalvariable property totalneeded auto
globalvariable property peltsgotten auto
int property targetskinsindex auto conditional
function setup()
endfunction
function accepted()
endfunction
function finished(bool _succeeded = true, bool _finished = true) 
endfunction
function cleanup()
endfunction
event onupdate()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1