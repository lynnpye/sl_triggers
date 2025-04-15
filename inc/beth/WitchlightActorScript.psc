scriptname witchlightactorscript extends actor conditional
objectreference property mywisp auto conditional hidden
keyword property wispkeyword auto
keyword property wispchild01 auto
keyword property wispchild02 auto
keyword property wispchild03 auto
spell property wispbuff01 auto
spell property wispbuff02 auto
spell property wispbuff03 auto
explosion property explosionillusionlight01 auto
activator property ingredientdrop auto
event oninit()
endevent
event oncellload()
endevent
event oncombatstatechanged(actor attacker, int aecombatstate)
endevent
event ondying(actor mykiller)
endevent
function childsetup()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1