scriptname ccbgssse001_fishtankcritterscript extends objectreference
float property fishenergy = 3.0 autoreadonly
float property fleetranslationspeed = 70.0 autoreadonly
float property translationspeedmean = 35.0 autoreadonly
float property translationspeedvariance = 5.0 autoreadonly
float property splinecurve = 110.0 autoreadonly
float property maxrotationspeed = 360.0 autoreadonly
float property continuechance = 0.8 autoreadonly
function startpathing(objectreference akstartmarker)
endfunction
event onupdate()
endevent
function onload()
endfunction
function trytomovetonextmarker(bool abfast = false)
endfunction
function stoppathing()
endfunction
event ontranslationalmostcomplete()
endevent
float function getsplinecurve()
endfunction
float function gettranslationspeedmean()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1