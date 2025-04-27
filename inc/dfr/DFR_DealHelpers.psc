scriptname dfr_dealhelpers hidden 
string function getallkey() global
endfunction
string function getkey(string asname) global
endfunction
string function gettimerkey(string asname) global
endfunction
string function getcostkey(string asname) global
endfunction
float function gettimer(string asname) global
endfunction
function settimer(string asname, float aftimer) global
endfunction
int function getnum() global
endfunction
int function getnumrules(string asdeal) global
endfunction
int function getnumallrules(string asdeal) global
endfunction
string[] function getdeals() global
endfunction
string function getdealat(int aiindex) global
endfunction
string function getdealbyrule(string asrule) global
endfunction
string function getruleat(string asdeal, int aiindex) global
endfunction
string[] function getrules(string asdeal) global
endfunction
int function getcost(string asdeal) global 
endfunction
int function setcost(string asdeal, int aicost) global 
endfunction
function create(string asdeal) global
endfunction
function remove(string asdeal) global
endfunction
function removerule(string asdeal, string asrule) global
endfunction
bool function addrule(string asdeal, string asrule) global
endfunction
string[] function splitid(string asdeal) global
endfunction
function initdeals(string[] asdeals) global
endfunction
int function getdealindex(string asdeal) global
endfunction
string function getdealpath(string asname) global
endfunction
function setpath(string asname, string aspath) global
endfunction
function clearpath(string asname) global
endfunction
bool function ispathused(string asname) global
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1