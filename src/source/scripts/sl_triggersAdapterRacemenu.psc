scriptname sl_triggersAdapterRacemenu

int Function GetNumBodyOverlays() global
    return NiOverride.GetNumBodyOverlays()
EndFunction

int Function GetNumHandOverlays() global
    return NiOverride.GetNumHandOverlays()
EndFunction

int Function GetNumFeetOverlays() global
    return NiOverride.GetNumFeetOverlays()
EndFunction

int Function GetNumFaceOverlays() global
    return NiOverride.GetNumFaceOverlays()
EndFunction

string Function GetNodeOverrideString(ObjectReference ref, bool isFemale, string node, int _key, int index) global
    return NiOverride.GetNodeOverrideString(ref, isFemale, node, _key, index)
EndFunction

Function AddNodeOverrideFloat(ObjectReference ref, bool isFemale, string node, int _key, int index, float value, bool persist) global
    NiOverride.AddNodeOverrideFloat(ref, isFemale, node, _key, index, value, persist)
EndFunction

Function AddNodeOverrideInt(ObjectReference ref, bool isFemale, string node, int _key, int index, int value, bool persist) global
    NiOverride.AddNodeOverrideInt(ref, isFemale, node, _key, index, value, persist)
EndFunction

Function AddNodeOverrideBool(ObjectReference ref, bool isFemale, string node, int _key, int index, bool value, bool persist) global
    NiOverride.AddNodeOverrideBool(ref, isFemale, node, _key, index, value, persist)
EndFunction

Function AddNodeOverrideString(ObjectReference ref, bool isFemale, string node, int _key, int index, string value, bool persist) global
    NiOverride.AddNodeOverrideString(ref, isFemale, node, _key, index, value, persist)
EndFunction

Function AddNodeOverrideTextureSet(ObjectReference ref, bool isFemale, string node, int _key, int index, TextureSet value, bool persist) global
    NiOverride.AddNodeOverrideTextureSet(ref, isFemale, node, _key, index, value, persist)
EndFunction

Function ApplyNodeOverrides(ObjectReference ref) global
    NiOverride.ApplyNodeOverrides(ref)
EndFunction

Function RemoveAllNodeNameOverrides(ObjectReference ref, bool isFemale, string node) global
    NiOverride.RemoveAllNodeNameOverrides(ref, isFemale, node)
EndFunction

Function AddOverlays(ObjectReference ref) global
    NiOverride.AddOverlays(ref)
EndFunction