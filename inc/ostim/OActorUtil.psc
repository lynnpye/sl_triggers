scriptname oactorutil
bool function hasschlong(actor act) global native
bool function fulfillscondition(actor act, perk condition) global native
bool function fulfillsanycondition(actor act, perk[] conditions) global native
bool function fulfillsallconditions(actor act, perk[] conditions) global native
function sayto(actor act, actor target, topic dialogue) global native
function sayas(actor act, actor target, topic dialogue, voicetype voice) global native
actor[] function emptyarray() global native
actor[] function createarray(int size, actor filler = none) global native
actor[] function toarray(actor one = none, actor two = none, actor three = none, actor four = none, actor five = none, actor six = none, actor seven = none, actor eight = none, actor nine = none, actor ten = none) global native
actor[] function sort(actor[] actors, actor[] dominantactors, int playerindex = -1) global native
actor[] function selectindexandsort(actor[] actors, actor[] dominantactors) global
endfunction
actor[] function getactorsinrangev2(objectreference center, float range, bool includecenter = false, bool includeplayer = true, bool ostimactorsonly = false, perk condition = none) global native
string[] function actorstonames(actor[] actors) global native
actor[] function getactorsinrange(objectreference center, float range, bool includecenter = false, bool includeplayer = true, perk condition = none) global
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1