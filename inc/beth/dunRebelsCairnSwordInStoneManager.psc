scriptname dunrebelscairnswordinstonemanager extends objectreference
weapon property rebelscairnbasesword auto
weapon property rebelscairnupgradedsword auto
message property noswordmessage auto
objectreference property rebelscairninvisibleactivator auto
objectreference property rebelscairnbaseswordactivator auto
objectreference property rebelscairnupgradedswordactivator auto
objectreference property secretdoor auto
objectreference property glowvfx auto
objectreference property doorcollision auto
sound property rumblesfx auto
quest property dunrebelscairnqst auto
auto state active
event onactivate(objectreference triggerref)
endevent
endstate
state busy
event onactivate(objectreference triggerref)
endevent
endstate
function activatebox()
endfunction
function activatesword(objectreference triggerref)
endfunction
function upgradesword()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1