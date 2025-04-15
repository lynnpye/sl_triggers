scriptname da04questscript extends quest conditional
referencealias property septimus auto
referencealias property septimusessential auto
referencealias property oghmainfinium auto
objectreference property hermaeusmorata auto
objectreference property hermaeusmorafx auto
objectreference property hermaeusmoraactivator auto
objectreference property hermaeusmoracollision auto
objectreference property hermaeusmoraendspot auto
objectreference property hermaeusmorafxalt auto
objectreference property hermaeusmoraactivatoralt auto
objectreference property hermaeusmoracollisionalt auto
spell property disappear auto
bool property astrolabeopened auto conditional
bool property readcrazybook auto conditional
bool property septimusmentionedblackreach auto conditional
bool property septimusreadscroll auto conditional
bool property defiedhermaeusmora auto conditional
bool property boxopened auto conditional
bool property septimussentforplayer auto conditional
bool property septimusstartascension auto conditional
miscobject property extractor auto
race property altmer auto
race property bosmer auto
race property dunmer auto
race property falmer auto
race property orsimer auto
bool property gotaltmerblood auto conditional
bool property gotbosmerblood auto conditional 
bool property gotdunmerblood auto conditional 
bool property gotfalmerblood auto conditional 
bool property gotorsimerblood auto conditional 
bool property septimusvanished auto conditional
function gotblood(objectreference deadthing)
endfunction
function enablehm(bool enabling)
endfunction
function movehm()
endfunction
function waitforcallback()
endfunction
event onanimationevent(objectreference aksource, string aseventname)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1