scriptname cwmission07stewardscript extends referencealias  
cwscript property cw auto
faction property cwimperialfaction  auto  
faction property cwsonsfaction  auto  
faction property govimperial auto  
faction property govsons  auto  
actor property playerref auto
state busy
event onupdate()
endevent
endstate
event onupdate()
endevent
faction function getmyfaction()
endfunction
function addorremoveplayerfromfaction(bool forceadd = false, bool forceremove = false)
endfunction
function monitorplayerdistance(bool monitor = true)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1