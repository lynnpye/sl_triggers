scriptname testphildwarvenforgeinputboxscript extends objectreference  
objectreference property controllerscript auto
event onload()
endevent
event onitemadded(form akbaseitem, int aiitemcount, objectreference akitemreference, objectreference aksourcecontainer)
endevent 
event onitemremoved(form akbaseitem, int aiitemcount, objectreference akitemreference, objectreference aksourcecontainer)
endevent 
int function weaparmorcounter(bool addingots, form item, keyword armorkword, keyword weapkword, int counter)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1