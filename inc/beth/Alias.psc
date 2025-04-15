scriptname alias hidden
quest function getowningquest() native
bool function registerforanimationevent(objectreference aksender, string aseventname) native
function registerforlos(actor akviewer, objectreference aktarget) native
function registerforsinglelosgain(actor akviewer, objectreference aktarget) native
function registerforsingleloslost(actor akviewer, objectreference aktarget) native
function registerforsingleupdate(float afinterval) native
function registerforupdate(float afinterval) native
function registerforupdategametime(float afinterval) native
function registerforsingleupdategametime(float afinterval) native
function registerforsleep() native
function registerfortrackedstatsevent() native
function startobjectprofiling() native
function stopobjectprofiling() native
function unregisterforlos(actor akviewer, objectreference aktarget) native
function unregisterforanimationevent(objectreference aksender, string aseventname) native
function unregisterforsleep() native
function unregisterfortrackedstatsevent() native
function unregisterforupdate() native
function unregisterforupdategametime() native
event onanimationevent(objectreference aksource, string aseventname)
endevent
event onanimationeventunregistered(objectreference aksource, string aseventname)
endevent
event ongainlos(actor akviewer, objectreference aktarget)
endevent
event onlostlos(actor akviewer, objectreference aktarget)
endevent
event onsleepstart(float afsleepstarttime, float afdesiredsleependtime)
endevent
event onsleepstop(bool abinterrupted)
endevent
event ontrackedstatsevent(string arstatname, int aistatvalue)
endevent
event onupdate()
endevent
event onupdategametime()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1