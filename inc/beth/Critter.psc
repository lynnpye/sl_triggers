scriptname critter extends objectreference
float property fpositionvariancex = 20.0 auto
float property fpositionvariancey = 20.0 auto
float property fpositionvariancezmin = 50.0 auto
float property fpositionvariancezmax = 100.0 auto
float property fanglevariancez = 90.0 auto
float property fanglevariancex = 20.0 auto
float property fpathcurvemean = 100.0 auto
float property fpathcurvevariance = 200.0 auto
float property fbellshapedwaypointpercent = 0.2 auto
string property pathstartgraphevent = "" auto
float property fpathstartanimdelay = 1.0 auto
string property pathendgraphevent = "" auto
float property fpathendanimdelay = 1.0 auto
ingredient property lootable auto
formlist property noningredientlootable auto
formlist  property fakecorpse auto
bool property bpushondeath = false auto
explosion property deathpush auto
int property lootablecount = 1 auto
bool property bincrementswingpluckstat = false auto
static property landingmarkerform auto
float property flandingspeedratio = 0.33 auto
string property approachnodename = "approachsmall01" auto
bool property reserved auto hidden
objectreference property hunter auto hidden
float property fleashlength auto hidden
float property fmaxplayerdistance auto hidden
float property fheight auto hidden
float property fdepth auto hidden
critterspawn property spawner auto hidden
bool property bcritterdebug = false auto hidden
function die()
endfunction
event onactivate(objectreference actronaut)
endevent
event onhit(objectreference akaggressor, form akweapon, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
event onmagiceffectapply(objectreference akcaster, magiceffect akeffect)
endevent
event onstart()
endevent
event oncrittergoalalmostreached()
endevent
event oncrittergoalreached()
endevent
event oncrittergoalfailed()
endevent
event oninit()
endevent
function setinitialspawnerproperties(float afradius, float afheight, float afdepth, float afmaxplayerdistance, critterspawn arspawner)
endfunction
function setspawnerproperties()
endfunction
function checkstateandstart()
endfunction
state kickoffonstart
function onupdate()
endfunction
endstate
function disableanddelete(bool abfadeout = true)
endfunction 
function placelandingmarker(objectreference artarget, string astargetnode)
endfunction
function placedummymarker(objectreference artarget, string astargetnode)
endfunction
function splinetranslatetorefatspeed(objectreference artarget, float afspeed, float afmaxrotationspeed)
endfunction
function splinetranslatetorefnodeatspeed(objectreference artarget, string arnode, float afspeed, float afmaxrotationspeed)
endfunction
function splinetranslatetorefatspeedandgotostate(objectreference artarget, float afspeed, float afmaxrotationspeed, string artargetstate)
endfunction
function splinetranslatetorefnodeatspeedandgotostate(objectreference artarget, string arnode, float afspeed, float afmaxrotationspeed, string artargetstate)
endfunction
function translatetorefatspeed(objectreference artarget, float afspeed, float afmaxrotationspeed)
endfunction
function translatetorefnodeatspeed(objectreference artarget, string arnode, float afspeed, float afmaxrotationspeed)
endfunction
function translatetorefatspeedandgotostate(objectreference artarget, float afspeed, float afmaxrotationspeed, string artargetstate)
endfunction
function translatetorefnodeatspeedandgotostate(objectreference artarget, string arnode, float afspeed, float afmaxrotationspeed, string artargetstate)
endfunction
function bellshapetranslatetorefatspeed(objectreference artarget, float afbellheight, float afspeed, float afmaxrotationspeed)
endfunction
function bellshapetranslatetorefnodeatspeed(objectreference artarget, string arnode, float afbellheight, float afspeed, float afmaxrotationspeed)
endfunction
function bellshapetranslatetorefatspeedandgotostate(objectreference artarget, float afbellheight, float afspeed, float afmaxrotationspeed, string artargetstate)
endfunction
function bellshapetranslatetorefnodeatspeedandgotostate(objectreference artarget, string arnode, float afbellheight, float afspeed, float afmaxrotationspeed, string artargetstate)
endfunction
function warptorefandgotostate(objectreference artarget, string asstate)
endfunction
function warptorefnodeandgotostate(objectreference artarget, string asnode, string asstate)
endfunction
event ontranslationcomplete()
endevent
event ontranslationalmostcomplete()
endevent
event ontranslationfailed()
endevent
function printinitialproperties()
endfunction
function dopathstartstuff()
endfunction
function dopathendstuff()
endfunction
function flyaroundspawner(float fmintravel, float fmaxtravel, float fspeed, float afmaxrotationspeed, bool bflybelowspawner = false)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1