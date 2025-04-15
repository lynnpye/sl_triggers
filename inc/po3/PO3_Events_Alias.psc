scriptname po3_events_alias hidden
function onactorfalllongdistance(actor aktarget, float affalldistance, float affalldamage)
endfunction
function onactorkilled(actor akvictim, actor akkiller)
endfunction
function onactorreanimatestart(actor aktarget, actor akcaster)
endfunction
function onactorreanimatestop(actor aktarget, actor akcaster)
endfunction
function onactorresurrected(actor aktarget, bool abresetinventory)
endfunction
function onbookread(book akbook)
endfunction
function oncellfullyloaded(cell akcell)
endfunction
function oncriticalhit(actor akaggressor, weapon akweapon, bool absneakhit)
endfunction
function ondisarmed(actor aksource, weapon aktarget)
endfunction
function ondragonsoulgained(float afsouls)
endfunction
function onenterfurniture(objectreference akref)
endfunction
function onexitfurniture(objectreference akref)
endfunction
function onfasttravelconfirmed(objectreference asmarkerreference)
endfunction
function onfasttravelprompt(objectreference asmarkerreference)
endfunction
function onhitex(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endfunction
function onitemcrafted(objectreference akbench, location aklocation, form akcreateditem)
endfunction
function onitemharvested(form akproduce)
endfunction
function onlevelincrease(int ailevel)
endfunction
function onlocationdiscovery(string asregionname, string asworldspacename)
endfunction
function onmagiceffectapplyex(objectreference akcaster, magiceffect akeffect, form aksource, bool abapplied)
endfunction
function onmagichit(objectreference aktarget, form aksource, projectile akprojectile)
endfunction
function onobjectgrab(objectreference akobjectref)
endfunction
function onobjectloaded(objectreference akref, int aiformtype)
endfunction
function onobjectpoisoned(form akobject, potion akpoison, int aidose)
endfunction
function onobjectrelease(objectreference akobjectref)
endfunction
function onobjectunloaded(objectreference akref, int aiformtype)
endfunction
event onplayerfasttravelend(float aftravelgametimehours)
endevent
function onprojectilehit(objectreference aktarget, form aksource, projectile akprojectile)
endfunction
function onqueststagechange(quest akquest, int ainewstage)
endfunction
function onqueststart(quest akquest)
endfunction
function onqueststop(quest akquest)
endfunction
function onshoutattack(shout akshout)
endfunction
function onskillincrease(int aiskill)
endfunction
function onsoultrapped(actor akvictim, actor akkiller)
endfunction
function onspelllearned(spell akspell)
endfunction
function onweaponhit(objectreference aktarget, form aksource, projectile akprojectile, int aihitflagmask)
endfunction
function onweatherchange(weather akoldweather, weather aknewweather)
endfunction
function registerforactorfalllongdistance(referencealias akrefalias) global native
function registerforactorkilled(alias akalias) global native
function registerforactorreanimatestart(alias akalias) global native
function registerforactorreanimatestop(alias akalias) global native
function registerforactorresurrected(alias akalias) global native
function registerforbookread(alias akalias) global native
function registerforcellfullyloaded(alias akalias) global native
function registerforcriticalhit(alias akalias) global native
function registerfordisarmed(alias akalias) global native
function registerfordragonsoulgained(alias akalias) global native
function registerforfasttravelconfirmed(alias akalias) global native
function registerforfasttravelprompt(alias akalias) global native
function registerforfurnitureevent(referencealias akrefalias) global native
function registerforhiteventex(referencealias akrefalias, form akaggressorfilter, form aksourcefilter, form akprojectilefilter, int aipowerfilter, int aisneakfilter, int aibashfilter, int aiblockfilter, bool abmatch) global native
function registerforitemcrafted(alias akalias) global native
function registerforitemharvested(alias akalias) global native
function registerforlevelincrease(alias akalias) global native
function registerforlocationdiscovery(alias akalias) global native
function registerformagiceffectapplyex(referencealias akrefalias, form akeffectfilter, bool abmatch) global native
function registerformagichit(referencealias akrefalias) global native
function registerforobjectgrab(alias akalias) global native
function registerforobjectloaded(alias akalias, int formtype) global native
function registerforobjectpoisoned(alias akalias) global native
function registerforonplayerfasttravelend(alias akalias) global native
function registerforprojectilehit(referencealias akrefalias) global native
function registerforquest(alias akalias, quest akquest) global native
function registerforqueststage(alias akalias, quest akquest) global native
function registerforshoutattack(alias akalias) global native
function registerforskillincrease(alias akalias) global native
function registerforsoultrapped(alias akalias) global native
function registerforspelllearned(alias akalias) global native
function registerforweaponhit(referencealias akrefalias) global native
function registerforweatherchange(alias akalias) global native
function unregisterforactorfalllongdistance(referencealias akrefalias) global native
function unregisterforactorkilled(alias akalias) global native
function unregisterforactorreanimatestart(alias akalias) global native
function unregisterforactorreanimatestop(alias akalias) global native
function unregisterforactorresurrected(alias akalias) global native
function unregisterforallhiteventsex(referencealias akrefalias) global native
function unregisterforallmagiceffectapplyex(referencealias akrefalias) global native
function unregisterforallobjectsloaded(alias akalias) global native
function unregisterforallqueststages(alias akalias) global native
function unregisterforallquests(alias akalias) global native
function unregisterforbookread(alias akalias) global native
function unregisterforcellfullyloaded(alias akalias) global native
function unregisterforcriticalhit(alias akalias) global native
function unregisterfordisarmed(alias akalias) global native
function unregisterfordragonsoulgained(alias akalias) global native
function unregisterforfasttravelconfirmed(alias akalias) global native
function unregisterforfasttravelprompt(alias akalias) global native
function unregisterforfurnitureevent(referencealias akrefalias) global native
function unregisterforhiteventex(referencealias akrefalias, form akaggressorfilter, form aksourcefilter, form akprojectilefilter, int aipowerfilter, int aisneakfilter, int aibashfilter, int aiblockfilter, bool abmatch) global native
function unregisterforitemcrafted(alias akalias) global native
function unregisterforitemharvested(alias akalias) global native
function unregisterforlevelincrease(alias akalias) global native
function unregisterforlocationdiscovery(alias akalias) global native
function unregisterformagiceffectapplyex(referencealias akrefalias, form akeffectfilter, bool abmatch) global native
function unregisterformagichit(referencealias akrefalias) global native
function unregisterforobjectgrab(alias akalias) global native
function unregisterforobjectloaded(alias akalias, int formtype) global native
function unregisterforobjectpoisoned(alias akalias) global native
function unregisterforonplayerfasttravelend(alias akalias) global native
function unregisterforprojectilehit(referencealias akrefalias) global native
function unregisterforquest(alias akalias, quest akquest) global native
function unregisterforqueststage(alias akalias, quest akquest) global native
function unregisterforshoutattack(alias akalias) global native
function unregisterforskillincrease(alias akalias) global native
function unregisterforsoultrapped(alias akalias) global native
function unregisterforspelllearned(alias akalias) global native
function unregisterforweaponhit(referencealias akrefalias) global native
function unregisterforweatherchange(alias akalias) global native
event onbeginstate()
endevent
event onendstate()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1