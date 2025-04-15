scriptname fxfakecritterscript extends objectreference  
container property mycontainer auto
flora property myflora auto
ingredient property myingredient auto
potion property myfood auto
string property mylocationoffset auto
string property myfakeforceexplosionoffset auto
explosion property myexplosion auto
explosion property myfakeforceexplosion auto
int property numberofingredientsoncatch auto
int property hoursbeforereset = 72 auto
event onactivate(objectreference akactionref)
endevent
event onhit(objectreference akaggressor, form aksource, projectile akprojectile, bool abpowerattack, bool absneakattack, bool abbashattack, bool abhitblocked)
endevent
event oncellattach()
endevent
;This file was cleaned with PapyrusSourceHeadliner 1