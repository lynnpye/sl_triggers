scriptname byohhousebardscript extends actor  
string property sinstrument = "lute" auto  
int property iplayonloadpercent = 50 auto
int property iplayonloadstarthour = 10 auto
int property iplayonloadendhour = 22 auto
globalvariable property gamehour auto
bardsongsscript property bardsongs  auto  
byohhousescript property housequest auto
event oncellattach()
endevent
event onunload()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1