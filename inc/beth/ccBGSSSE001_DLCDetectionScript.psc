scriptname ccbgssse001_dlcdetectionscript extends referencealias  
actor property playerref auto
actorbase property ccbgssse001_swimsindeepwaters auto
actorbase property ccbgssse001_viriya auto
globalvariable property ccbgssse001_versioncurrent auto ; constant
globalvariable property ccbgssse001_versionlastknown auto
armor property ccbgssse001_clothesfishingboots auto
armor property ccbgssse001_clothesfishingclothes auto
armor property ccbgssse001_clothesfishinghat auto
armor property ccbgssse001_clothescollegebootsvagrant auto
armor property ccbgssse001_clothescollegehoodvagrant auto
armor property ccbgssse001_clothescollegerobesvagrant auto
armor property ccbgssse001_clothescollegerobesvagrantconjuration01 auto
armor property ccbgssse001_clothescollegerobesvagrantconjuration02 auto
armor property ccbgssse001_clothescollegerobesvagrantconjuration03 auto
armor property ccbgssse001_clothescollegerobesvagrantconjuration04 auto
armor property ccbgssse001_clothescollegerobesvagrantconjuration05 auto
armor property ccbgssse001_mudcrabamuletunenchanted auto
book property ccbgssse001_lineandlure auto
formlist property byohhousefishcontainerlist auto
formlist property riftenfisherylocklist auto
formlist property helpmanualpc auto
formlist property helpmanualxbox auto
ingredient[] property hatcheryfishingredient auto
leveleditem property ccbgssse001_litemfoodfishbucketfish25 auto
leveleditem property ccbgssse001_litemfoodfishcarp25 auto
leveleditem property ccbgssse001_fishingmapsall auto
leveleditem property deathitemmudcrab01 auto
leveleditem property deathitemmudcrab02 auto
leveleditem property deathitemmudcrab03 auto
leveleditem property litemfoodfishlist auto
leveleditem property litemdraugr02weapon1h auto
leveleditem property litemdraugr02weapon2h auto
leveleditem property litemclotheswork auto
leveleditem property litemclothesall auto
leveleditem property loottoolrandom05 auto
leveleditem property litemmiscvendormiscitems75 auto
leveleditem property litembook0all auto
leveleditem property litembookclutter auto
leveleditem property litemrobesconjuration auto
leveleditem property byohlitemkhajiitcaravans auto
leveleditem property litemfoodinncommon auto
leveleditem property litemfoodinncommon10 auto
potion property ccbgssse001_foodcrabmeat auto
potion property ccbgssse001_foodbucketfishcooked auto
potion property ccbgssse001_foodtunasalmoncooked auto
potion property ccbgssse001_foodcuckoocatfishcooked auto
potion[] property hatcheryfishfood auto
potion[] property rawfish auto
globalvariable property ccbgssse001_showedreelpromptthissession auto
globalvariable property ccbgssse001_showedcatchpromptthissession auto
message property ccbgssse001_helpfishinglong auto
message property ccbgssse001_helpfishinglongxbox auto
weapon property ccbgssse001_fishingrodimperialweap auto
weapon property ccbgssse001_draugrdagger auto
weapon property ccbgssse001_draugrdaggerhoned auto
weapon property ccbgssse001_draugrmace auto
weapon property ccbgssse001_draugrmacehoned auto
weapon property ccbgssse001_draugrwarhammer auto
weapon property ccbgssse001_draugrwarhammerhoned auto
miscobject property byohhouseinteriorpart021wallshelvesx2_02 auto
miscobject property byohhouseinteriorpart185vampirecoffin01 auto
location property byohhouse1locationinterior auto
location property byohhouse2locationinterior auto
location property byohhouse3locationinterior auto
location property solitudeproudspiremanorlocation auto
objectreference property byohhouse1holdingchestroom12 auto
objectreference property byohhouse2holdingchestroom12 auto
objectreference property byohhouse3holdingchestroom12 auto
formlist property ccbgssse001_byohmiscobjectlist auto
formlist property ccbgssse001_byohhouse1upgradelist auto
formlist property ccbgssse001_byohhouse2upgradelist auto
formlist property ccbgssse001_byohhouse3upgradelist auto
formlist property byohhousebuildingroom12masterlist auto
formlist property ccbgssse001_byohallfishingspecificupgrademiscitems auto
ccbgssse001_fishplaquescript[] property house01fishplaques auto
ccbgssse001_fishplaquescript[] property house02fishplaques auto
ccbgssse001_fishplaquescript[] property house03fishplaques auto
ccbgssse001_fishplaquescript[] property proudspiremanorfishplaques auto
ccbgssse001_fishplaquealiasscript[] property fishathouse01plaques auto
ccbgssse001_fishplaquealiasscript[] property fishathouse02plaques auto
ccbgssse001_fishplaquealiasscript[] property fishathouse03plaques auto
ccbgssse001_fishplaquealiasscript[] property fishatproudspiremanorplaques auto
event oninit()
endevent
event onplayerloadgame()
endevent
function runupdates()
endfunction
function checkforversionupdates(int ailastknownversion)
endfunction
function runsetupbasegame()
endfunction
function addhelparticles()
endfunction
function rundetectdlc()
endfunction
objectreference function getcellarholdingchestforlocation(location aklocation)
endfunction
objectreference function getobjectforlocationanditem(location aklocation, form akobjecttobuild)
endfunction
function buildbyohobject(location akcurrentplayerlocation, location akhouselocationtobuild, form akobjecttobuild)
endfunction
function checkandapplyfishingplaquepatch()
endfunction
function fishingplaquepatchreassignaliases(ccbgssse001_fishplaquescript[] akfishplaques, ccbgssse001_fishplaquealiasscript[] akfishathouseplaquealiases)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1