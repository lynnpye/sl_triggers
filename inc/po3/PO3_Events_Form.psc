scriptname po3_events_form hidden
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
function registerforactorfalllongdistance(form akform) global native
function registerforactorkilled(form akform) global native
function registerforactorreanimatestart(form akform) global native
function registerforactorreanimatestop(form akform) global native
function registerforactorresurrected(form akform) global native
function registerforbookread(form akform) global native
function registerforcellfullyloaded(form akform) global native
function registerforcriticalhit(form akform) global native
function registerfordisarmed(form akform) global native
function registerfordragonsoulgained(form akform) global native
function registerforfasttravelconfirmed(form akform) global native
function registerforfasttravelprompt(form akform) global native
function registerforfurnitureevent(form akform) global native
function registerforhiteventex(form akform, form akaggressorfilter, form aksourcefilter, form akprojectilefilter, int aipowerfilter, int aisneakfilter, int aibashfilter, int aiblockfilter, bool abmatch) global native
function registerforitemcrafted(form akform) global native
function registerforitemharvested(form akform) global native
function registerforlevelincrease(form akform) global native
function registerforlocationdiscovery(form akform) global native
function registerformagiceffectapplyex(form akform, form akeffectfilter, bool abmatch) global native
function registerformagichit(form akform) global native
function registerforobjectgrab(form akform) global native
function registerforobjectloaded(form akform, int formtype) global native
function registerforobjectpoisoned(form akform) global native
function registerforonplayerfasttravelend(form akform) global native
function registerforprojectilehit(form akform) global native
function registerforquest(form akform, quest akquest) global native
function registerforqueststage(form akform, quest akquest) global native
function registerforshoutattack(form akform) global native
function registerforskillincrease(form akform) global native
function registerforsoultrapped(form akform) global native
function registerforspelllearned(form akform) global native
function registerforweaponhit(form akform) global native
function registerforweatherchange(form akform) global native
function unregisterforactorfalllongdistance(form akform) global native
function unregisterforactorkilled(form akform) global native
function unregisterforactorreanimatestart(form akform) global native
function unregisterforactorreanimatestop(form akform) global native
function unregisterforactorresurrected(form akform) global native
function unregisterforallhiteventsex(form akform) global native
function unregisterforallmagiceffectapplyex(form akform) global native
function unregisterforallobjectsloaded(form akform) global native
function unregisterforallqueststages(form akform) global native
function unregisterforallquests(form akform) global native
function unregisterforbookread(form akform) global native
function unregisterforcellfullyloaded(form akform) global native
function unregisterforcriticalhit(form akform) global native
function unregisterfordisarmed(form akform) global native
function unregisterfordragonsoulgained(form akform) global native
function unregisterforfasttravelconfirmed(form akform) global native
function unregisterforfasttravelprompt(form akform) global native
function unregisterforfurnitureevent(form akform) global native
function unregisterforhiteventex(form akform, form akaggressorfilter, form aksourcefilter, form akprojectilefilter, int aipowerfilter, int aisneakfilter, int aibashfilter, int aiblockfilter, bool abmatch) global native
function unregisterforitemcrafted(form akform) global native
function unregisterforitemharvested(form akform) global native
function unregisterforlevelincrease(form akform) global native
function unregisterforlocationdiscovery(form akform) global native
function unregisterformagiceffectapplyex(form akform, form akeffectfilter, bool abmatch) global native
function unregisterformagichit(form akform) global native
function unregisterforobjectgrab(form akform) global native
function unregisterforobjectloaded(form akform, int formtype) global native
function unregisterforobjectpoisoned(form akform) global native
function unregisterforonplayerfasttravelend(form akform) global native
function unregisterforprojectilehit(form akform) global native
function unregisterforquest(form akform, quest akquest) global native
function unregisterforqueststage(form akform, quest akquest) global native
function unregisterforshoutattack(form akform) global native
function unregisterforskillincrease(form akform) global native
function unregisterforsoultrapped(form akform) global native
function unregisterforspelllearned(form akform) global native
function unregisterforweaponhit(form akform) global native
function unregisterforweatherchange(form akform) global native
event onbeginstate()
endevent
event onendstate()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1