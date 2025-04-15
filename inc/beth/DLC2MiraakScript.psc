scriptname dlc2miraakscript extends actor  
bool property appearonload auto
objectreference property appearatref auto
objectreference property disappeartoref auto
explosion property dlc2miraakteleportexp auto
explosion property dlc2miraakteleportreturnexp auto
effectshader property dlc2miraakteleportstartfxs auto
effectshader property dlc2miraakteleportreturnfxs auto
imagespacemodifier property dlc2miraakteleportimodstatic auto
event onupdate()
endevent
function crossfadeonupdate()
endfunction
function onload()
endfunction
function appear(bool movetoappearatref = true, bool useimod = true)
endfunction
function delayedappear()
endfunction
function disappear()
endfunction
function delayeddisappear()
endfunction
function handlereturnteleportexplodeexp()
endfunction
function startmiraakfadeout()
endfunction
function aftermiraakfadeout()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1