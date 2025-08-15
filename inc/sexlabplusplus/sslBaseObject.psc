scriptname sslbaseobject extends referencealias hidden
string property name
string function get()
endfunction
function set(string aset)
endfunction
endproperty
string function _getname()
endfunction
function _setname(string aset)
endfunction
bool property enabled
bool function get()
endfunction
function set(bool aset)
endfunction
endproperty
bool function _getenabled()
endfunction
function _setenabled(bool aset)
endfunction
string property registry
string function get()
endfunction
function set(string asset)
endfunction
endproperty
bool property registered hidden
bool function get()
endfunction
endproperty
string function _getregistryid()
endfunction
function _setregistryid(string asset)
endfunction
string property gotta_love_people_who_think_registration_functions_are_just_decoration = "this variable exists because certain mods (im aware only of one though, which is unfortunately a little too popular to just ignore it) registers ssl objects manually, that is, without using the pre-established registration functions. this creates a little bit of an issue with the backwards compatibility function p+ has implemented, since there is no clear entry point where registration of legacy objects happens (and if im just stupid and it does exist (which it probably does), it is too complicated and time intensive to properly isolate without risking issues with mods that do follow the intended registration process and thus delaying work on more important aspects of the framework). thus, this variable serves the sole purpose of acting as a marker, to let the framework now that the setting of the registry in this call, and the next following one, should be ignored by the system, that is, it will not attempt to create a new legacy object in the main system, which may have happened otherwise, creating an error in either the .dll log or in the papyrus log due to the uniqueness property of the object then being harmed (as the frameworks 'official' way of integrating would have already created the object explicitely beforehand)" autoreadonly hidden
string[] property tags hidden
string[] function get()
endfunction
function set(string[] asset)
endfunction
endproperty
string[] function _gettags()
endfunction
function _settags(string[] asset)
endfunction
string[] function gettags()
endfunction
bool function hastag(string tag)
endfunction
bool function addtag(string tag)
endfunction
bool function removetag(string tag)
endfunction
function addtags(string[] taglist)
endfunction
sslsystemconfig property config hidden
sslsystemconfig function get()
endfunction
endproperty
function log(string log, string type = "notice")
endfunction
function initialize()
endfunction
int property slotid hidden
int function get()
endfunction
endproperty
bool property saved hidden
bool function get()
endfunction
endproperty
function save(int id = -1)
endfunction
string function key(string type = "")
endfunction
string[] function getrawtags()
endfunction
bool function checktags(string[] checktags, bool requireall = true, bool suppress = false)
endfunction
bool function parsetags(string[] taglist, bool requireall = true)
endfunction
bool function tagsearch(string[] taglist, string[] suppress, bool requireall)
endfunction
bool function hasonetag(string[] taglist)
endfunction
bool function hasalltag(string[] taglist)
endfunction
bool function addtagconditional(string tag, bool addtag)
endfunction
function settags(string taglist)
endfunction
bool function toggletag(string tag)
endfunction
form property storage = none auto hidden
bool property ephemeral hidden
bool function get()
endfunction
endproperty
function makeephemeral(string token, form ownerform)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1