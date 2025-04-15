scriptname ccbgssse001_radiantitemquest extends quest hidden conditional
int property currentobjective auto conditional hidden
int property allcollectedobjective auto
int property bountyletterobjectivebase auto
int property minitemstocollect auto
int property maxitemstocollect auto
globalvariable property itemcountglobal auto
globalvariable property itemtotalglobal auto
globalvariable property radiantquestrunning auto
referencealias property mapmarker auto
actor property playerref auto
miscobject property gold001 auto
book[] property bountyletters auto
referencealias property bountyletteralias auto
int property goldrewardamount01 = 100 autoreadonly
int property goldrewardamount02 = 175 autoreadonly
int property goldrewardamount03 = 250 autoreadonly
int property goldrewardamount04 = 325 autoreadonly
int property goldrewardamount05 = 400 autoreadonly
function startupquest()
endfunction
function giveplayerbountyletter()
endfunction
function showquest()
endfunction
function finishquest(bool abcompleted = true)
endfunction
function radiantitemadded(int aicount)
endfunction
function radiantitemremoved(int aicount)
endfunction
int function getrewardamount()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1