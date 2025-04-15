scriptname ccbgssse001_radiantitemplayerscript extends referencealias  
ccbgssse001_radiantitemquest property myquest auto
function setplayerinventoryeventfilter(form akformtofilter)
endfunction
event onitemadded(form akbaseitem, int aiitemcount, objectreference akitemreference, objectreference aksourcecontainer)
endevent
event onitemremoved(form akbaseitem, int aiitemcount, objectreference akitemreference, objectreference akdestcontainer)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1