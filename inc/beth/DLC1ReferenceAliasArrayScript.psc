scriptname dlc1referencealiasarrayscript extends quest  
referencealias[] property aliasarray auto
objectreference[] property refarray auto ;we are using a seperate array to hold references and shuffling refs around in that because it's much less overhead than shuffling refs into and out of aliases - requested by mlipari and jlundin
bool property tracealiasrefs auto
function lockthread()
endfunction
function unlockthread()
endfunction
bool function forcerefinto(objectreference reftoadd)
endfunction
bool function clearreffrom(objectreference reftoclear)
endfunction
referencealias function findref(objectreference reftofind)
endfunction
objectreference function promoterefs()
endfunction
function tracearrayrefs()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1