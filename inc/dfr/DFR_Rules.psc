scriptname dfr_rules extends quest conditional
qf__gift_09000d62 property flow auto
dfr_relationshipmanager property relmanager auto
globalvariable property gamedayspassed auto
float property ruleextensionmin = 1.0 auto hidden
float property ruleextensionmax = 2.0 auto hidden
int property status_accept = 6 autoreadonly hidden
int property status_refuse = 7 autoreadonly hidden
int property numrules auto hidden conditional
string[] property activerules auto hidden
dfr_rules function get() global
endfunction
event oninit()
endevent
function maintenance()
endfunction
function setup()
endfunction
event onmenuclose(string asmenu)
endevent
bool function add(string asrule, int aiterm, int aicontext)
endfunction
bool function startdays(string asrule, int aimindays, int aimaxdays = -1, int aicontext)
endfunction
function remove(string asrule)
endfunction
bool function has(string asrule)
endfunction
function log(string asmsg)
endfunction
function end(string asrule)
endfunction
function delayremoval(string asrule)
endfunction
function handle(string asrule)
endfunction
bool function canaddrule(string asrule)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1