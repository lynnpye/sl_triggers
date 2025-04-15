scriptname da13playerscript extends referencealias
quest property da13 auto
ingredient property vampiredust auto
ingredient property deathbell auto
miscobject property ingotsilver auto
miscobject property gemrubyflawless auto
event oninit()
endevent
event onitemadded(form itemadded, int itemcount, objectreference itemref, objectreference sourceref)
endevent
event onitemremoved(form itemadded, int itemcount, objectreference itemref, objectreference sourceref)
endevent
function da13itemscheck()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1