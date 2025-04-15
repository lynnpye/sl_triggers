scriptname defaultdisablehavokonload extends objectreference
bool property havokonhit = true auto
bool property havokonactivate auto
bool property havokonzkey auto
keyword property linkhavokpartner auto
bool property beensimmed auto hidden
event oncellattach()
endevent
event onload()
endevent
event onactivate(objectreference triggerref)
endevent
event onhit(objectreference var1, form var2, projectile var3, bool var4, bool var5, bool var6, bool var7)
endevent
event ongrab()
endevent
function releasetohavok()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1