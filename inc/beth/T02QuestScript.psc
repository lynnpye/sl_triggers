scriptname t02questscript extends quest conditional
bool property dinyareadytooffer auto conditional
bool property gotpitchfromjofthor auto conditional
bool property gotpitchfromboti auto conditional
bool property persuadedbassianus auto conditional
bool property persuadedklimmek auto conditional
bool property yngvarofferedpoem auto conditional
bool property fastredmovetoriften auto conditional
bool property bassianusmovetoriften auto conditional
bool property talkingtofastredsparents auto conditional
bool property talkingtofastredsboys auto conditional
bool property talkedtofaleen auto conditional
bool property playertoldyngvaraboutcalcelmo auto conditional
bool property seekingruki auto conditional
bool property seekingfenrig auto conditional
referencealias property boti auto
referencealias property jofthor auto
referencealias property fenrig auto
referencealias property ruki auto
int property yngvarpoemcostamount auto  
miscobject property yngvarpoemcostitem auto  
referencealias property loveletter  auto  
referencealias property lovepoem  auto  
message property rukimessage auto
message property ascensionmessage auto
bool property checkforfastredscene auto
bool property checkforcalcelmoscene auto
bool property checkfordeadloversscene auto
scene property fastredscene auto
scene property fastredscene2 auto
scene property calcelmoscene auto
scene property deadloversscene auto
location property ivarstead auto
location property markarth auto
event onupdate()
endevent
function gotparentpitch(objectreference parentinquestion)
endfunction
function listenforanimevents()
endfunction
event onanimationevent(objectreference aksource, string aseventname)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1