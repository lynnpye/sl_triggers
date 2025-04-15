scriptname dlc2wescript extends wescript  conditional
referencealias[] property aggressionsetaliasarray auto
int property aggressionsetinitialvalue = 0 auto
bool property aggressionsetaddtoplayerenemyfaction = true auto
event onstoryscript(keyword akkeyword, location aklocation, objectreference akref1, objectreference akref2, int aivalue1, int aivalue2)
endevent
function initializeaggressionsetaliases()
endfunction
function makealiasesaggressive(int newaggression = 1)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1