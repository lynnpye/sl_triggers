scriptname sl_triggers hidden
sl_triggersmain function main() global
endfunction
form function       getform(string someformofformidentification) global native
string[] function   getscriptslist() global native
int function        getsessionid() global native
string function     gettranslatedstring(string _translationkey) global native
int function        normalizescriptfilename(string scriptfilename) global native
bool function       smartequals(string a, string b) global native
string[] function   splitscriptcontents(string _scriptfilename) global native
string[] function   splitscriptcontentsandtokenize(string _scriptfilename) global native
string[] function   tokenize(string _tokenstring) global native
string[] function   tokenizev2(string _tokenstring) global native
string[] function   tokenizeforvariablesubstitution(string _tokenstring) global native
string function     trim(string str) global native
;This file was cleaned with PapyrusSourceHeadliner 1