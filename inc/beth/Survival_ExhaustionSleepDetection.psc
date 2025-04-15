scriptname survival_exhaustionsleepdetection extends referencealias
actor property playerref auto
globalvariable property survival_modeenabled auto
globalvariable property survival_exhaustionrestoreperhour auto
formlist property survival_interiorareas auto
event oninit()
endevent
event onsleepstart(float afsleepstarttime, float afdesiredsleependtime)
endevent
event onsleepstop(bool abinterrupted)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1