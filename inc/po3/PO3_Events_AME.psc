scriptname po3_events_ame hidden
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
function onplayershoutattack(shout akshout)
endfunction
function onprojectilehit(objectreference aktarget, form aksource, projectile akprojectile)
endfunction
function onqueststagechange(quest akquest, int ainewstage)
endfunction
function onqueststart(quest akquest)
endfunction
function onqueststop(quest akquest)
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
function registerforactorfalllongdistance(activemagiceffect akactiveeffect) global native
function registerforactorkilled(activemagiceffect akactiveeffect) global native
function registerforactorreanimatestart(activemagiceffect akactiveeffect) global native
function registerforactorreanimatestop(activemagiceffect akactiveeffect) global native
function registerforactorresurrected(activemagiceffect akactiveeffect) global native
function registerforbookread(activemagiceffect akactiveeffect) global native
function registerforcellfullyloaded(activemagiceffect akactiveeffect) global native
function registerforcriticalhit(activemagiceffect akactiveeffect) global native
function registerfordisarmed(activemagiceffect akactiveeffect) global native
function registerfordragonsoulgained(activemagiceffect akactiveeffect) global native
function registerforfasttravelconfirmed(activemagiceffect akactiveeffect) global native
function registerforfasttravelprompt(activemagiceffect akactiveeffect) global native
function registerforfurnitureevent(activemagiceffect akactiveeffect) global native
function registerforhiteventex(activemagiceffect akactiveeffect, form akaggressorfilter, form aksourcefilter, form akprojectilefilter, int aipowerfilter, int aisneakfilter, int aibashfilter, int aiblockfilter, bool abmatch) global native
function registerforitemcrafted(activemagiceffect akactiveeffect) global native
function registerforitemharvested(activemagiceffect akactiveeffect) global native
function registerforlevelincrease(activemagiceffect akactiveeffect) global native
function registerforlocationdiscovery(activemagiceffect akactiveeffect) global native
function registerformagiceffectapplyex(activemagiceffect akactiveeffect, form akeffectfilter, bool abmatch) global native
function registerformagichit(activemagiceffect akactiveeffect) global native
function registerforobjectgrab(activemagiceffect akactiveeffect) global native
function registerforobjectloaded(activemagiceffect akactiveeffect, int formtype) global native
function registerforobjectpoisoned(activemagiceffect akactiveeffect) global native
function registerforonplayerfasttravelend(activemagiceffect akactiveeffect) global native
function registerforprojectilehit(activemagiceffect akactiveeffect) global native
function registerforquest(activemagiceffect akactiveeffect, quest akquest) global native
function registerforqueststage(activemagiceffect akactiveeffect, quest akquest) global native
function registerforshoutattack(activemagiceffect akactiveeffect) global native
function registerforskillincrease(activemagiceffect akactiveeffect) global native
function registerforsoultrapped(activemagiceffect akactiveeffect) global native
function registerforspelllearned(activemagiceffect akactiveeffect) global native
function registerforweaponhit(activemagiceffect akactiveeffect) global native
function registerforweatherchange(activemagiceffect akactiveeffect) global native
function unregisterforactorfalllongdistance(activemagiceffect akactiveeffect) global native
function unregisterforactorkilled(activemagiceffect akactiveeffect) global native
function unregisterforactorreanimatestart(activemagiceffect akactiveeffect) global native
function unregisterforactorreanimatestop(activemagiceffect akactiveeffect) global native
function unregisterforactorresurrected(activemagiceffect akactiveeffect) global native
function unregisterforallhiteventsex(activemagiceffect akactiveeffect) global native
function unregisterforallmagiceffectapplyex(activemagiceffect akactiveeffect) global native
function unregisterforallobjectsloaded(activemagiceffect akactiveeffect) global native
function unregisterforallqueststages(activemagiceffect akactiveeffect) global native
function unregisterforallquests(activemagiceffect akactiveeffect) global native
function unregisterforbookread(activemagiceffect akactiveeffect) global native
function unregisterforcellfullyloaded(activemagiceffect akactiveeffect) global native
function unregisterforcriticalhit(activemagiceffect akactiveeffect) global native
function unregisterfordisarmed(activemagiceffect akactiveeffect) global native
function unregisterfordragonsoulgained(activemagiceffect akactiveeffect) global native
function unregisterforfasttravelconfirmed(activemagiceffect akactiveeffect) global native
function unregisterforfasttravelprompt(activemagiceffect akactiveeffect) global native
function unregisterforfurnitureevent(activemagiceffect akactiveeffect) global native
function unregisterforhiteventex(activemagiceffect akactiveeffect, form akaggressorfilter, form aksourcefilter, form akprojectilefilter, int aipowerfilter, int aisneakfilter, int aibashfilter, int aiblockfilter, bool abmatch) global native
function unregisterforitemcrafted(activemagiceffect akactiveeffect) global native
function unregisterforitemharvested(activemagiceffect akactiveeffect) global native
function unregisterforlevelincrease(activemagiceffect akactiveeffect) global native
function unregisterforlocationdiscovery(activemagiceffect akactiveeffect) global native
function unregisterformagiceffectapplyex(activemagiceffect akactiveeffect, form akeffectfilter, bool abmatch) global native
function unregisterformagichit(activemagiceffect akactiveeffect) global native
function unregisterforobjectgrab(activemagiceffect akactiveeffect) global native
function unregisterforobjectloaded(activemagiceffect akactiveeffect, int formtype) global native
function unregisterforobjectpoisoned(activemagiceffect akactiveeffect) global native
function unregisterforonplayerfasttravelend(activemagiceffect akactiveeffect) global native
function unregisterforprojectilehit(activemagiceffect akactiveeffect) global native
function unregisterforquest(activemagiceffect akactiveeffect, quest akquest) global native
function unregisterforqueststage(activemagiceffect akactiveeffect, quest akquest) global native
function unregisterforshoutattack(activemagiceffect akactiveeffect) global native
function unregisterforskillincrease(activemagiceffect akactiveeffect) global native
function unregisterforsoultrapped(activemagiceffect akactiveeffect) global native
function unregisterforspelllearned(activemagiceffect akactiveeffect) global native
function unregisterforweaponhit(activemagiceffect akactiveeffect) global native
function unregisterforweatherchange(activemagiceffect akactiveeffect) global native
event onbeginstate()
endevent
event onendstate()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1