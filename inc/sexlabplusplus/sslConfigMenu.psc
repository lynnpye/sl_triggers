scriptname sslconfigmenu extends ski_configbase
actor property playerref auto
sslsystemconfig property config auto
sslsystemalias property systemalias auto
sslactorlibrary property actorlib auto
sslthreadslots property threadslots auto
int function getversion()
endfunction
string function getstringver()
endfunction
event onversionupdate(int version)
endevent
event ongamereload()
endevent
event onconfiginit()
endevent
event onconfigopen()
endevent
event onconfigclose()
endevent
event onpagereset(string page)
endevent
string function getsexualitytitle(actor actorref) global
endfunction
string[] function stattitles() global
endfunction
function sexdiary()
endfunction
state statselectingmenu
event onmenuopenst()
endevent
event onmenuacceptst(int aiindex)
endevent
event ondefaultst()
endevent
event onhighlightst()
endevent
endstate
state resettargetstats
event onselectst()
endevent
event onhighlightst()
endevent
endstate
state statchangesexuality
event onselectst()
endevent
event onhighlightst()
endevent
endstate
function animationsettings()
endfunction
state disablescale
event onselectst()
endevent
event ondefaultst()
endevent
event onhighlightst()
endevent
endstate
function matchmaker()
endfunction
state togglematchmaker
event onselectst()
endevent
event ondefaultst()
endevent
event onhighlightst()
endevent
endstate
string function getsavedvoice(actor akactor) global
endfunction
function soundsettings()
endfunction
state selectvoicecache
event onmenuopenst()
endevent
event onmenuacceptst(int aiindex)
endevent
event ondefaultst()
endevent
event onhighlightst()
endevent
endstate
state selectvoicecachev
event onmenuopenst()
endevent
event onmenuacceptst(int aiindex)
endevent
event onhighlightst()
endevent
endstate
function timersstripping()
endfunction
string function getstripstate(form itemref)
endfunction
string function getitemname(form itemref, string altname = "$ssl_unknown")
endfunction
int[] function getallmaskslots(int mask)
endfunction
function stripeditor()
endfunction
int property anims_per_page = 120 autoreadonly hidden
function toggleanimations()
endfunction
function expressioneditor()
endfunction
function testapply(actor actorref)
endfunction
function rebuildclean()
endfunction
function installmenu()
endfunction
function systemcheckoptions()
endfunction
state resetstripoverrides
event onselectst()
endevent
endstate
state cleansystem
event onselectst()
endevent
endstate
state rebuildstraponlist
event onselectst()
endevent
endstate
event onselectst()
endevent
event onslideropenst()
endevent
event onslideracceptst(float value)
endevent
event onmenuopenst()
endevent
event onmenuacceptst(int aiindex)
endevent
event oninputopenst()
endevent
event oninputacceptst(string inputstring)
endevent
event onhighlightst()
endevent
function playerhotkeys()
endfunction
event onkeymapchangest(int newkeycode, string conflictcontrol, string conflictname)
endevent
bool function keyconflict(int newkeycode, string conflictcontrol, string conflictname)
endfunction
state adjuststage
event onkeymapchangest(int newkeycode, string conflictcontrol, string conflictname)
endevent
event ondefaultst()
endevent
event onhighlightst()
endevent
endstate
state adjustchange
event onkeymapchangest(int newkeycode, string conflictcontrol, string conflictname)
endevent
event ondefaultst()
endevent
event onhighlightst()
endevent
endstate
state adjustforward
event onkeymapchangest(int newkeycode, string conflictcontrol, string conflictname)
endevent
event ondefaultst()
endevent
event onhighlightst()
endevent
endstate
state adjustupward
event onkeymapchangest(int newkeycode, string conflictcontrol, string conflictname)
endevent
event ondefaultst()
endevent
event onhighlightst()
endevent
endstate
state adjustsideways
event onkeymapchangest(int newkeycode, string conflictcontrol, string conflictname)
endevent
event ondefaultst()
endevent
event onhighlightst()
endevent
endstate
state adjustschlong
event onkeymapchangest(int newkeycode, string conflictcontrol, string conflictname)
endevent
event ondefaultst()
endevent
event onhighlightst()
endevent
endstate
state rotatescene
event onkeymapchangest(int newkeycode, string conflictcontrol, string conflictname)
endevent
event ondefaultst()
endevent
event onhighlightst()
endevent
endstate
state restoreoffsets
event onkeymapchangest(int newkeycode, string conflictcontrol, string conflictname)
endevent
event ondefaultst()
endevent
event onhighlightst()
endevent
endstate
state realignactors
event onkeymapchangest(int newkeycode, string conflictcontrol, string conflictname)
endevent
event ondefaultst()
endevent
event onhighlightst()
endevent
endstate
state advanceanimation
event onkeymapchangest(int newkeycode, string conflictcontrol, string conflictname)
endevent
event ondefaultst()
endevent
event onhighlightst()
endevent
endstate
state changeanimation
event onkeymapchangest(int newkeycode, string conflictcontrol, string conflictname)
endevent
event ondefaultst()
endevent
event onhighlightst()
endevent
endstate
state changepositions
event onkeymapchangest(int newkeycode, string conflictcontrol, string conflictname)
endevent
event ondefaultst()
endevent
event onhighlightst()
endevent
endstate
state movescenelocation
event onkeymapchangest(int newkeycode, string conflictcontrol, string conflictname)
endevent
event ondefaultst()
endevent
event onhighlightst()
endevent
endstate
state backwardsmodifier
event onkeymapchangest(int newkeycode, string conflictcontrol, string conflictname)
endevent
event ondefaultst()
endevent
event onhighlightst()
endevent
endstate
state endanimation
event onkeymapchangest(int newkeycode, string conflictcontrol, string conflictname)
endevent
event ondefaultst()
endevent
event onhighlightst()
endevent
endstate
state targetactor
event onkeymapchangest(int newkeycode, string conflictcontrol, string conflictname)
endevent
event ondefaultst()
endevent
event onhighlightst()
endevent
endstate
state togglefreecamera
event onkeymapchangest(int newkeycode, string conflictcontrol, string conflictname)
endevent
event ondefaultst()
endevent
event onhighlightst()
endevent
endstate
state adjusttargetstage
event onselectst()
endevent
event ondefaultst()
endevent
event onhighlightst()
endevent
endstate
state forceregistervoices
event onselectst()
endevent
event onhighlightst()
endevent
endstate
int function dodisable(bool check)
endfunction
sslactorstats property stats hidden
sslactorstats function get()
endfunction
endproperty
sslexpressionslots property expressionslots hidden
sslexpressionslots function get()
endfunction
endproperty
sslvoiceslots property voiceslots hidden
sslvoiceslots function get()
endfunction
endproperty
sslanimationslots property animslots hidden
sslanimationslots function get()
endfunction
endproperty
sslcreatureanimationslots property creatureslots hidden
sslcreatureanimationslots function get()
endfunction
endproperty
sslthreadlibrary property threadlib hidden
sslthreadlibrary function get()
endfunction
endproperty
function log(string log, string type = "notice")
endfunction
string[] function mapoptions()
endfunction
function troubleshoot()
endfunction
int function additemtoggles(form[] items, int id, int max)
endfunction
function toggleexpressions()
endfunction
string[] function paginationmenu(string beforepages = "", string afterpages = "", int currentpage)
endfunction
string function genderlabel(string id)
endfunction
form[] function getitems(actor actorref, bool fullinventory = false)
endfunction
form[] function getequippeditems(actor actorref)
endfunction
form[] function getfullinventory(actor actorref)
endfunction
bool function istoggleable(form itemref)
endfunction
bool[] function getstripping(int type)
endfunction
float function getdefaulttime(int idx)
endfunction
float[] function gettimers()
endfunction
float[] function gettimersdef()
endfunction
function addanimationstag(string tag)
endfunction
function removeanimationstag(string tag)
endfunction
function toggleanimationstag(string tag)
endfunction
bool function gettoggle(sslbaseanimation anim)
endfunction
function resetallquests()
endfunction
function resetquest(quest questref)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1