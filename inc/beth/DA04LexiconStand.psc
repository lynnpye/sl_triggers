scriptname da04lexiconstand extends referencealias  
referencealias property blanklexicon auto
referencealias property inscribedlexicon auto
objectreference property lens auto
objectreference property inscribedversion auto
objectreference property storagechest auto
objectreference property button1 auto
objectreference property button2 auto
objectreference property button3 auto
objectreference property button4 auto
auto state empty
event onactivate(objectreference akactionref)
endevent
event onbeginstate()
endevent
endstate
state loadedclosed
event onbeginstate()
endevent
event onactivate(objectreference akactionref)
endevent
function openup()
endfunction
endstate
state loadedopened
function closedown()
endfunction
event onanimationevent(objectreference aksource, string aseventname)
endevent
function inscribe()
endfunction
endstate
state loadedinscribed
event onactivate(objectreference akactionref)
endevent
endstate
state emptydone
endstate
state busy
endstate
function inscribe()
endfunction
function openup()
endfunction
function closedown()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1