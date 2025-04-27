scriptname _dtickplayeralias extends referencealias
keyword property loctypedungeon auto
keyword property loctypecity auto
keyword property loctypetown auto
keyword property loctypedwelling auto
qf__gift_09000d62 property flow auto
_dflowmcm property mcm auto
_dfgoldconqscript property goldcont auto
_dtick property q auto
dfr_outfits property outfits auto
dfr_relationshipmanager property relmanager auto
dfr_jobs property jobs auto
objectreference property crosshairtarget auto
dfr_collar property collar auto
globalvariable property currentlocationtype auto
event onplayerloadgame()
endevent
function addeventregistrations()
endfunction
event oncrosshairrefchange(objectreference ref)
endevent
event onlocationchange(location oldlocation, location newlocation)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1