scriptname dlc1falmervalleyicedragonscript extends actor
explosion property myexplosionenter auto
explosion property myexplosionexit auto
quest property myquest auto
int property mystage auto
int property mysetstage auto
objectreference property myicecapstart01 auto
objectreference property myicecapstart02 auto
objectreference property myicecapend01 auto
objectreference property myicecapend02 auto
objectreference property myicetrimstart01 auto
objectreference property myicetrimstart02 auto
objectreference property myicetrimend01 auto
objectreference property myicetrimend02 auto
event onload()
endevent
auto state waiting
event onanimationevent(objectreference aksource, string aseventname)
endevent
event ondeath(actor killer)
endevent
endstate
state done
endstate
;This file was cleaned with PapyrusSourceHeadliner 1