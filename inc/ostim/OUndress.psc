scriptname oundress
bool function usepapyrusundressing() global
endfunction
function animateredress(actor act, bool isfemale, armor[] armors, form[] weapons) global
endfunction
function playredressanimation(actor act, string animation, float animationlength, float dresspoint, armor[] armors, int slotmask) global
endfunction
armor[] function undress(int threadid, actor act) global
endfunction
armor[] function redress(int threadid, actor act, armor[] undresseditems) global
endfunction
armor[] function undresspartial(int threadid, actor act, int slotmask) global
endfunction
armor[] function redresspartial(int threadid, actor act, armor[] undresseditems, int slotmask) global
endfunction
bool function canundress(form item) global native
bool function iswig(actor act, armor item) global native
armor[] function getwornitems(actor act) global native
armor[] function trimarmorarray(armor[] items) global native
;This file was cleaned with PapyrusSourceHeadliner 1