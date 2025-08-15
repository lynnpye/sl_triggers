scriptname sslthreadcontroller extends sslthreadmodel
message property repositioninfomsg auto
int property kadvanceanimation = 0 autoreadonly
int property kchangeanimation  = 1 autoreadonly
int property kchangepositions  = 2 autoreadonly
int property kadjustchange     = 3 autoreadonly
int property kadjustforward    = 4 autoreadonly
int property kadjustsideways   = 5 autoreadonly
int property kadjustupward     = 6 autoreadonly
int property krealignactors    = 7 autoreadonly
int property krestoreoffsets   = 8 autoreadonly
int property kmovescene        = 9 autoreadonly
int property krotatescene      = 10 autoreadonly
int property kendanimation     = 11 autoreadonly
int property kadjustschlong    = 12 autoreadonly
function enablehotkeys(bool forced = false)
endfunction
function disablehotkeys()
endfunction
event menuevent(string aseventname, string asstringarg, float afnumarg, form aksender)
endevent
function pickrandomscene(string asnewscene)
endfunction
function movescene()
endfunction
function updateannotations(string asstring)
endfunction
int function getoffsetidx(string asoffsettype)
endfunction
function setsceneoffset(float afoffsetvalue, string asoffsettype)
endfunction
function setstageoffset(actor akaffectedactor, float afoffsetvalue, string asoffsettype)
endfunction
event onkeydown(int keycode)
endevent
int function getadjustpos()
endfunction
function advancestage(bool backwards = false)
endfunction
function changeanimation(bool backwards = false)
endfunction
function adjustcoordinate(bool abbackwards, bool abstageonly, float afvalue, int aikeyidx, int aioffsettype)
endfunction
function adjustforward(bool backwards = false, bool adjuststage = false)
endfunction
function adjustsideways(bool backwards = false, bool adjuststage = false)
endfunction
function adjustupward(bool backwards = false, bool adjuststage = false)
endfunction
function rotatescene(bool backwards = false)
endfunction
function adjustchange(bool backwards = false)
endfunction
function restoreoffsets()
endfunction
function changepositions(bool backwards = false)
endfunction
function playhotkeyfx(int i, bool backwards)
endfunction
float function getanimationruntime()
endfunction
function resetpositions()
endfunction
objectreference function getcenterfx()
endfunction
function adjustschlong(bool backwards = false)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1