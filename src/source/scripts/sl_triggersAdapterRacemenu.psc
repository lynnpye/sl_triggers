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

bool Function HasNodeOverride(ObjectReference ref, bool isFemale, string node, int _key, int index) global
    return NiOverride.HasNodeOverride(ref, isFemale, node, _key, index)
EndFunction

float Function GetNodeOverrideFloat(ObjectReference ref, bool isFemale, string node, int _key, int index) global
    return NiOverride.GetNodeOverrideFloat(ref, isFemale, node, _key, index)
EndFunction

int Function GetNodeOverrideInt(ObjectReference ref, bool isFemale, string node, int _key, int index) global
    return NiOverride.GetNodeOverrideInt(ref, isFemale, node, _key, index)
EndFunction

bool Function GetNodeOverrideBool(ObjectReference ref, bool isFemale, string node, int _key, int index) global
    return NiOverride.GetNodeOverrideBool(ref, isFemale, node, _key, index)
EndFunction

string Function GetNodeOverrideString(ObjectReference ref, bool isFemale, string node, int _key, int index) global
    return NiOverride.GetNodeOverrideString(ref, isFemale, node, _key, index)
EndFunction

TextureSet Function GetNodeOverrideTextureSet(ObjectReference ref, bool isFemale, string node, int _key, int index) global
    return NiOverride.GetNodeOverrideTextureSet(ref, isFemale, node, _key, index)
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

bool Function HasBodyMorph(ObjectReference ref, string morphName, string keyName) global
    return NiOverride.HasBodyMorph(ref, morphName, keyName)
EndFunction

Function SetBodyMorph(ObjectReference ref, string morphName, string keyName, float value) global
    NiOverride.SetBodyMorph(ref, morphName, keyName, value)
EndFunction

float Function GetBodyMorph(ObjectReference ref, string morphName, string keyName) global
    return NiOverride.GetBodyMorph(ref, morphName, keyName)
EndFunction

Function ClearBodyMorph(ObjectReference ref, string morphName, string keyName) global
    NiOverride.ClearBodyMorph(ref, morphName, keyName)
EndFunction

Function UpdateModelWeight(ObjectReference ref) global
    NiOverride.UpdateModelWeight(ref)
EndFunction

string[] Function GetMorphNames(ObjectReference ref) global
    return NiOverride.GetMorphNames(ref)
EndFunction

string[] Function GetMorphKeys(ObjectReference ref, string morphName) global
    return NiOverride.GetMorphKeys(ref, morphName)
EndFunction