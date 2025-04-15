scriptname rpdefault_castspellonactivate extends objectreference
bool property bplayeronly = true auto
spell property spelltocast auto
bool property buseactivatorassource = false auto
bool property bblameactivatorforcast = false auto
objectreference property spelltarget auto
bool property bdoonce = false auto
event onactivate(objectreference akactivatedby)
endevent
state hasbeentriggered
event onactivate(objectreference triggerref)
endevent
endstate
;This file was cleaned with PapyrusSourceHeadliner 1