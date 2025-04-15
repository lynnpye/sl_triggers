scriptname dunvolskyggepuzzlebuttoncontrol extends objectreference
bool property puzzlesolved = false auto hidden
int property numpuzzlebuttonssolved = 0 auto hidden
int property refactonfailurecounter = 0 auto hidden
int property numofpuzzlebuttons auto
objectreference property mymusicmarker auto
objectreference property mylightmarker auto
objectreference property mysoundmarker01 auto
sound property mysuccesssound auto
sound property myfailsound auto
sound property myfailsoundnolight auto
message property mymessage auto
objectreference property refactonfailure01 auto
objectreference property refactonfailure02 auto
objectreference property refactonfailure03 auto
objectreference property refactonfailure04 auto
objectreference property mydoor01 auto
objectreference property mydoor02 auto
event onreset()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1