scriptname ssleffectdebug extends activemagiceffect
sexlabframework property sexlab auto
sslsystemconfig property config auto
actor property playerref auto
sslbenchmark function benchmark(int tests = 1, int iterations = 5000, int loops = 10, bool usebaseloop = false)
endfunction
event oneffectstart(actor targetref, actor casterref)
endevent
event oneffectfinish(actor targetref, actor casterref)
endevent
function log(string log)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1