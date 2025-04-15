scriptname ccbgssse001_catchdata extends activator hidden
globalvariable property ccbgssse001_catchtypesmallfish auto ; constant
globalvariable property ccbgssse001_catchtypelargefish auto ; constant
globalvariable property ccbgssse001_catchtypeobject auto ; constant
globalvariable property ccbgssse001_catchtypequestevent auto ; constant
bool property isonetimecatch = false auto
string property successnodename = "successnodefish" auto
form function getcaughtobject()
endfunction
float[] function getcatchsequence()
endfunction
int function getcatchtype()
endfunction
weapon function getrequiredrod()
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1