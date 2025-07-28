scriptname ofurniture
string function getfurnituretype(objectreference furnitureref) global native
bool function ischildof(string supertype, string subtype) global native
objectreference[] function findfurniture(int actorcount, objectreference centerref, float radius, float samefloor = 0.0) global native
objectreference function findfurnitureoftype(string type, objectreference centerref, float radius, float samefloor = 0.0) global native
float[] function getoffset(objectreference furnitureref) global native
int function getsceneid(objectreference furnitureref) global native
function resetclutter(objectreference centerref, float radius) global native
;This file was cleaned with PapyrusSourceHeadliner 1