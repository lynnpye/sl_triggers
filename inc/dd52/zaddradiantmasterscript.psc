scriptname zaddradiantmasterscript extends quest hidden
referencealias property alias_player auto
referencealias property alias_master auto
slautilscr property aroused auto
bool property backtalkedmaster auto
zadbq00 property beltquest auto
message property capture01msg auto
message property capture02msg auto
message property capture03msg auto
message property capture04msg auto
message property capturebelted01msg auto
message property capturebelted02msg auto
message property capturebelted03msg auto
zadconfig property config auto
armor property currentbelt auto
armor property currentcollar auto
armor property currentplug auto
zaddradiantmasterbasequest property currenttask auto
float property disposition auto
bool property failedtask auto
scene property initiationresumedialoguescene01 auto
scene property initiationresumedialoguescene02 auto
scene property initiationstartscene auto
faction property jobapothecaryfaction auto
faction property jobbardfaction auto
faction property jobblacksmithfaction auto
faction property jobcourtwizardfaction auto
faction property jobmerchantfaction auto
zaddradiantmasterbasequest property lasttask auto
int property lasttaskindex auto
locationreftype property loctypeinn auto
float property nextsummontime auto
float property obedience auto
scene property rudetomasterscene auto
sexlabframework property sexlab auto
spell property shocksummon auto
message property shocksummonmsg auto
int property summontype auto
locationreftype property tgrslstrongbox auto
locationreftype property tgrwealthyhomechest auto
zaddradiantmasterbasequest[] property taskpool auto
zaddradiantmastertasks property tasks auto
float property timesummonissued auto
float property timetaskassigned auto
message property trappedchest01msg auto
scene property trappedchest01scene auto
message property trappedchest02msg auto
scene property trappedchest02scene auto
message property trappedsleepmsg auto
idle property zazapc056 auto
idle property zazapc057 auto
idle property zazapcao051 auto
idle property zazapcao052 auto
idle property zazapcao053 auto
idle property zazapcao054 auto
idle property zazapcao055 auto
zaddreliableforcegreet property fg auto
zadlibs property libs auto
zaddradiantmasterstats property rm auto
faction property zaddrmmasterfaction auto
function fragment_1()
endfunction
function fragment_3()
endfunction
function fragment_2()
endfunction
function maintenance()
endfunction
event onupdategametime()
endevent
function modobedience(int x)
endfunction
bool function sanitycheck()
endfunction
string function getmastername()
endfunction
function setupquest()
endfunction
function startupsleepcapture()
endfunction
function startuptrapcapture()
endfunction
function initiationstart()
endfunction
function scenecapturebelted00()
endfunction
function scenecapturebelted01()
endfunction
function scenecapturebelted02()
endfunction
function queueheartbeat(float offset)
endfunction
function issuesummon()
endfunction
function beginsummoncountdown()
endfunction
function summonplayerevent()
endfunction
function playerrespondedtosummon()
endfunction
function rudetomaster()
endfunction
zaddradiantmasterbasequest function gettask()
endfunction
function begintask(zaddradiantmasterbasequest task)
endfunction
function giverandomtask()
endfunction
function taskcompleted()
endfunction
function taskfailed()
endfunction
function taskdonenopostscene()
endfunction
function posttask()
endfunction
function posttaskreturned()
endfunction
function beginposttaskscene()
endfunction
function posttaskscenecomplete()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1