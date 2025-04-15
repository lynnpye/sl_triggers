scriptname mq203questscript extends quest  conditional
function esberndelphinewait(bool bwaitingflag)
endfunction
event onanimationeventunregistered(objectreference aksource, string aseventname)
endevent
event onanimationevent(objectreference aksource, string aseventname)
endevent
location property riverwood  auto  
location property innlocation  auto  
location property skyhaventemple auto
location property karthspirelocation auto
referencealias property alias_esbern auto
referencealias property alias_delphine auto
bool property besbernescortratway  auto  conditional
bool property bmeetatkarthspire  auto  conditional
objectreference property skyhavenmarker  auto  
event onupdate()
endevent
int property imaxdistancetofollow = 180000  auto  
topic property mq203meetatkarthspiretopic  auto  
keyword property loctypedungeon  auto  
worldspace property tamriel  auto  
;This file was cleaned with PapyrusSourceHeadliner 1