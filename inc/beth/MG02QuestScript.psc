scriptname mg02questscript extends quest conditional
quest property pmg03 auto
objectreference property pmg02tolfdirstage40marker auto
referencealias property pmg02tolfdiralias auto
referencealias property mg02nerienalias auto
message property pmg02testscenemessage auto
scene property pmg02visionscene auto
int property mg02instructscenedone auto conditional
int property mg02item1found auto conditional
int property mg02item2found auto conditional
int property mg02item3found auto conditional
location property winterholdlocation auto
location property winterholdcollegelocation auto
referencealias property mg02tolfdirstartmarker auto
int property walltrigger auto conditional ;flag set when player picks up amulet
int property tolfdirupdate auto conditional   ;flag incremented as we step through the quest
int property orbfound auto conditional  ;flag set when orb is found
function vcount()
endfunction
event onupdate()
endevent
function triggervision()
endfunction
objectreference property mg02visioncollisionplane  auto  
objectreference property mg02visionlight  auto  
int property brelynatravelupdate  auto  conditional
int property onmundtravelupdate  auto  conditional
int property jzargotravelupdate  auto  conditional
int property mg02tolfdirlecture  auto  conditional
int property mg02stage20fg  auto  conditional
int property mg02transitiondoorvar  auto  conditional
int property mg02tolfdirtunnelscenevar  auto  conditional
globalvariable property mg02itemstotal  auto  
globalvariable property mg02itemsfound  auto  
objectreference property mg02visionplayertrigger  auto  
int property tolfdirfollow = 0 auto  conditional
globalvariable property favorrewardmedium  auto  
objectreference property collisionwall01  auto  
int property trapcollisiontoggle  auto  conditional
int property amuletinfo  auto  conditional
int property mg02saarthal01levercount  auto  conditional
int property cell02tolfdirmove  auto  conditional
int property mg02draugrtolfdircount  auto  conditional
int property stage60targetflag  auto  conditional
quest property mg02monkscenequest  auto  
spell property teleportinspell  auto  
spell property teleportoutspell  auto  
visualeffect property mgteleportineffect  auto  
float property fdelay  auto  
imagespacemodifier property introfx  auto  
imagespacemodifier property loopfx  auto  
imagespacemodifier property outrofx  auto  
float property fadeintime  auto  
shaderparticlegeometry property psgd  auto  
int property playervisionready  auto  
;This file was cleaned with PapyrusSourceHeadliner 1