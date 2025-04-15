scriptname mfgconsolefuncext hidden
bool function applyexpressionpreset(actor akactor, float[] aaexpression, bool abopenmouth, int exprpower, float exprstrmodifier, float modstrmodifier, float phstrmodifier, float speed) global native
actor function getplayerspeechtarget() global native
bool function resetmfgsmooth(actor akactor, int mode, float speed) global native
bool function setphonememodifiersmooth(actor act, int mode, int id, int value, float speed) global native
event onbeginstate()
endevent
event onendstate()
endevent
bool function setphoneme(actor act, int id, int value, float speed) global
endfunction
bool function setmodifier(actor act, int id, int value, float speed) global
endfunction
bool function setexpression(actor act, int mood, int value, float speed) global
endfunction
bool function applyexpressionpresetsmooth(actor akactor, float[] aaexpression, bool abopenmouth, int exprpower, float exprstrmodifier, float modstrmodifier, float phstrmodifier, float speed) global
endfunction
bool function resetmfg(actor act, float speed) global
endfunction
bool function resetphonemes(actor act, float speed) global
endfunction
bool function resetmodifiers(actor act, float speed) global
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1