scriptname survival_needexhaustion extends survival_needbase
message property survival_helpexhaustionhigh auto
globalvariable property survival_helpshown_exhaustion auto
referencealias property playeralias auto
formlist property survival_exhaustionresistracesmajor auto
formlist property survival_exhaustionresistracesminor auto
globalvariable property survival_racialbonusmajor auto
globalvariable property survival_racialbonusminor auto
globalvariable property survival_afflictionexhaustionchance auto
spell property survival_afflictionaddled auto
spell property survival_diseasebrownrot auto
spell property survival_diseasebrownrot2 auto
spell property survival_diseasebrownrot3 auto
spell property vampirevampirism auto
spell property werewolfimmunity auto
message property survival_afflictionaddledmsg auto
quest property playersleepquest auto
quest property relationshipmarriagefin auto
quest property byohrelationshipadoption auto
spell property rested auto
spell property wellrested auto
spell property marriagesleepability auto
spell property byohadoptionsleepabilitymale auto
spell property byohadoptionsleepabilityfemale auto
spell property pdoomloverability auto
keyword property loctypeinn auto
keyword property loctypeplayerhouse auto
referencealias property loveinterest auto
locationalias property currenthomelocation auto
message property beastbloodmessage auto
message property marriagerestedmessage auto
message property wellrestedmessage auto
message property restedmessage auto
message property byohadoptionrestedmessagemale auto
message property byohadoptionrestedmessagefemale auto
companionshousekeepingscript property chscript auto
spell[] property needspellsnodisease auto
bool property playersleeping = false auto hidden
function startneed()
endfunction
function setneedstagevalues()
endfunction
function stopneed()
endfunction
function needupdategametime()
endfunction
function increaseexhaustion(float amount)
endfunction
function decreaseexhaustion(float amount, bool qualitysleep = false)
endfunction
function applyexhaustionstage(float newexhaustionvalue, float oldexhaustionvalue, bool cangetrestedbonus)
endfunction
float function incrementneedbytick(float ratereductionmultiplier = 0.0)
endfunction
bool function cangetrestedbonus(bool showmessages = false)
endfunction
bool function playerisvampireorwerewolf()
endfunction
function selectcorrecteffects()
endfunction
function switchtonodiseaseeffects()
endfunction
function switchtodiseaseeffects()
endfunction
float function getbrownroteffectmult()
endfunction
function removeallneedspells()
endfunction
function applynormalrestedbonus()
endfunction
function applyadoptionbonus()
endfunction
function removeadoptionrested()
endfunction
function updateattributepenalty(float afneedvalue, string asattributeav = "", string aspenaltyav = "")
endfunction
function clearattributepenalty(string aspenaltyav = "")
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1