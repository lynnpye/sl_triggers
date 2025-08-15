scriptname sslmatchmakermain extends quest
sexlabframework property sexlab auto
sslsystemconfig property config auto
actor property playerref auto
string function getsexstring(int sexindex)
endfunction
string function parse_sex(actor aktarget)
endfunction
string function parse_sexes_and_races(int[] aisexes, actor[] akactors)
endfunction
bool function addactors(actor aktarget)
endfunction
event onupdate()
endevent
function triggersex(actor[] akpassed)
endfunction
event animationstarted(int aithread, bool abhasplayer)
endevent
event animationended(int aithread, bool abhasplayer)
endevent
;This file was cleaned with PapyrusSourceHeadliner 1