scriptname _dflowfollowercontroller extends quest  
quest property pdialoguefollower auto
sethirelingrehire property hirelingrehirescript auto
qf__gift_09000d62 property q auto
_dfsold property sold auto
_dflicensing property _dflicenses auto
faction property currenthireling  auto
faction property pdismissedfollower auto
faction property potentialhireling auto
faction property _dfdisable auto ; no longer used, though the same value is passed in from outside. use q.isignore() instead.
globalvariable property pplayerfollowercount auto
weapon property followerhuntingbow auto
ammo property followerironarrow auto
referencealias property alias__dmaster auto ; main _dflow master alias
miscobject property gold  auto
actorbase property belrand  auto
actorbase property erik  auto
actorbase property jenassa  auto
actorbase property marcurio  auto
actorbase property stenvar  auto
actorbase property vorstag  auto
globalvariable property _dffollowercount auto
globalvariable property hirelinggold  auto
globalvariable property hirelingrecognizestenvar  auto  ; hirelingrecognizestenvar.value=1
globalvariable property hirelingrecognizejenassa  auto
globalvariable property hirelingrecognizebelrand  auto
globalvariable property hirelingrecognizeerik  auto
globalvariable property hirelingrecognizemarcurio  auto
globalvariable property hirelingrecognizevorstag  auto
globalvariable property gamedayspassed  auto
globalvariable property canrehirebelrand  auto
globalvariable property canrehireerik  auto
globalvariable property canrehirejenassa  auto
globalvariable property canrehiremarcurio  auto
globalvariable property canrehirestenvar  auto
globalvariable property canrehirevorstag  auto
function resethirelingflags()
endfunction
bool function frameworkcanaddfollower()
endfunction
function addfollowertoframework(actor who)
endfunction
function addfollower(objectreference followerref)
endfunction
function dismisshireling (actorbase thishireling)
endfunction
function addfollowerdflow(objectreference followerref)
endfunction
function addfollowerlend(objectreference followerref)
endfunction
function dialogdismissfollower(actor follower)
endfunction
function dflowremovefollower()
endfunction
function dismissfromframework(actor who)
endfunction
function internalremovefollower(actor who)
endfunction
function removefollower(actor who)
endfunction
function reducefollowercount()
endfunction
actor[] function getframeworkfollowers(faction ignorefaction)
endfunction
function commondismissaltasks(actor who)
endfunction
function revokelicensesfromfollower()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1