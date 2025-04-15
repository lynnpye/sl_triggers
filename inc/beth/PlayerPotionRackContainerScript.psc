scriptname playerpotionrackcontainerscript extends objectreference  
form property litembookclutter auto
keyword property bookshelfbook01 auto
keyword property bookshelfbook02 auto
keyword property bookshelfbook03 auto
keyword property bookshelfbook04 auto
keyword property bookshelfbook05 auto
keyword property bookshelfbook06 auto
keyword property bookshelfbook07 auto
keyword property bookshelfbook08 auto
keyword property bookshelfbook09 auto
keyword property bookshelfbook10 auto
keyword property bookshelfbook11 auto
keyword property bookshelfbook12 auto
keyword property bookshelfbook13 auto
keyword property bookshelfbook14 auto
keyword property bookshelfbook15 auto
keyword property bookshelfbook16 auto
keyword property bookshelfbook17 auto
keyword property bookshelfbook18 auto
keyword property bookshelftrigger01 auto
keyword property bookshelftrigger02 auto
keyword property bookshelftrigger03 auto
keyword property bookshelftrigger04 auto
objectreference property bookmarker01 auto hidden
objectreference property bookmarker02 auto hidden
objectreference property bookmarker03 auto hidden
objectreference property bookmarker04 auto hidden
objectreference property bookmarker05 auto hidden
objectreference property bookmarker06 auto hidden
objectreference property bookmarker07 auto hidden
objectreference property bookmarker08 auto hidden
objectreference property bookmarker09 auto hidden
objectreference property bookmarker10 auto hidden
objectreference property bookmarker11 auto hidden
objectreference property bookmarker12 auto hidden
objectreference property bookmarker13 auto hidden
objectreference property bookmarker14 auto hidden
objectreference property bookmarker15 auto hidden
objectreference property bookmarker16 auto hidden
objectreference property bookmarker17 auto hidden
objectreference property bookmarker18 auto hidden
objectreference property bookshelftrigger01ref auto hidden
objectreference property bookshelftrigger02ref auto hidden
objectreference property bookshelftrigger03ref auto hidden
objectreference property bookshelftrigger04ref auto hidden
int property maxbooksallowed auto hidden
int property currentbookamount auto hidden
form property emptyform auto hidden
objectreference property emptyref auto hidden
form property currentbookform auto hidden
objectreference property currentbookref auto hidden
form property placedbook01 auto hidden
form property placedbook02 auto hidden
form property placedbook03 auto hidden
form property placedbook04 auto hidden
form property placedbook05 auto hidden
form property placedbook06 auto hidden
form property placedbook07 auto hidden
form property placedbook08 auto hidden
form property placedbook09 auto hidden
form property placedbook10 auto hidden
form property placedbook11 auto hidden
form property placedbook12 auto hidden
form property placedbook13 auto hidden
form property placedbook14 auto hidden
form property placedbook15 auto hidden
form property placedbook17 auto hidden
form property placedbook16 auto hidden
form property placedbook18 auto hidden
objectreference property placedbook01ref auto hidden
objectreference property placedbook02ref auto hidden
objectreference property placedbook03ref auto hidden
objectreference property placedbook04ref auto hidden
objectreference property placedbook05ref auto hidden
objectreference property placedbook06ref auto hidden
objectreference property placedbook07ref auto hidden
objectreference property placedbook08ref auto hidden
objectreference property placedbook09ref auto hidden
objectreference property placedbook10ref auto hidden
objectreference property placedbook11ref auto hidden
objectreference property placedbook12ref auto hidden
objectreference property placedbook13ref auto hidden
objectreference property placedbook14ref auto hidden
objectreference property placedbook15ref auto hidden
objectreference property placedbook17ref auto hidden
objectreference property placedbook16ref auto hidden
objectreference property placedbook18ref auto hidden
bool property alreadyloaded = false auto hidden
bool property blockbooks = false auto hidden
message property bookshelffirstactivatemessage auto
message property bookshelfnomoreroommessage auto
message property bookshelfnotabookmessage auto
message property bookshelfroomleftmessage auto
globalvariable property bookshelfglobal auto
event onload()
endevent
event onactivate(objectreference akactionref)
endevent
event onitemremoved(form akbaseitem, int aiitemcount, objectreference akitemreference, objectreference akdestcontainer)
endevent
event onitemadded(form akbaseitem, int aiitemcount, objectreference akitemreference, objectreference aksourcecontainer)
endevent
function unblockactivate()
endfunction
function removebooks(form bookbase, int bookamount)
endfunction
function deletebooks()
endfunction
function placebooks()
endfunction
function addbooks(form bookbase, int bookamount)
endfunction
function countmaxbooks()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1