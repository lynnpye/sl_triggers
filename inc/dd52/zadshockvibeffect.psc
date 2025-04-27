scriptname zadshockvibeffect extends activemagiceffect
zadlibs property libs auto
sexlabframework property sexlab auto
actor property target auto
bool property terminate auto
function maintenance()
endfunction
function onvibratestop(string eventname, string argstring, float argnum, form sender)
endfunction
event oneffectstart(actor aktarget, actor akcaster)
endevent
event oneffectfinish(actor aktarget, actor akcaster)
endevent
event oncellattach()
endevent
event onload()
endevent
event onunload()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1