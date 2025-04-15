scriptname sl_triggersFile

import sl_triggersStatics

;/
Mirroring JsonUtil functions to provide a slightly more convenient interface.
/;


; Settings wrappers
; Settings - string
bool Function Settings_StringHas(string _settingsFileName, string _theKey) global
	return JsonUtil.HasStringValue(SettingsFolder() + _settingsFileName, _theKey)
EndFunction

string Function Settings_StringGet(string _settingsFileName, string _theKey, string _defaultValue = "") global
	return JsonUtil.GetStringValue(SettingsFolder() + _settingsFileName, _theKey, _defaultValue)
EndFunction

string Function Settings_StringSet(string _settingsFileName, string _theKey, string _value = "") global
	return JsonUtil.SetStringValue(SettingsFolder() + _settingsFileName, _theKey, _value)
EndFunction

bool Function Settings_StringUnset(string _settingsFileName, string _theKey) global
	return JsonUtil.UnsetStringValue(SettingsFolder() + _settingsFileName, _theKey)
EndFunction



; Settings - Form
bool Function Settings_FormHas(string _settingsFileName, string _theKey) global
	return JsonUtil.HasFormValue(SettingsFolder() + _settingsFileName, _theKey)
EndFunction

Form Function Settings_FormGet(string _settingsFileName, string _theKey, Form _defaultValue = None) global
	return JsonUtil.GetFormValue(SettingsFolder() + _settingsFileName, _theKey, _defaultValue)
EndFunction

Form Function Settings_FormSet(string _settingsFileName, string _theKey, Form _value = None) global
	return JsonUtil.SetFormValue(SettingsFolder() + _settingsFileName, _theKey, _value)
EndFunction

bool Function Settings_FormUnset(string _settingsFileName, string _theKey) global
	return JsonUtil.UnsetFormValue(SettingsFolder() + _settingsFileName, _theKey)
EndFunction



; Settings - float
bool Function Settings_FloatHas(string _settingsFileName, string _theKey) global
	return JsonUtil.HasFloatValue(SettingsFolder() + _settingsFileName, _theKey)
EndFunction

float Function Settings_FloatGet(string _settingsFileName, string _theKey, float _defaultValue = 0.0) global
	return JsonUtil.GetFloatValue(SettingsFolder() + _settingsFileName, _theKey, _defaultValue)
EndFunction

float Function Settings_FloatSet(string _settingsFileName, string _theKey, float _value = 0.0) global
	return JsonUtil.SetFloatValue(SettingsFolder() + _settingsFileName, _theKey, _value)
EndFunction

bool Function Settings_FloatUnset(string _settingsFileName, string _theKey) global
	return JsonUtil.UnsetFloatValue(SettingsFolder() + _settingsFileName, _theKey)
EndFunction

float Function Settings_FloatAdjust(string _settingsFileName, string _theKey, float _amount) global
	return JsonUtil.AdjustFloatValue(SettingsFolder() + _settingsFileName, _theKey, _amount)
EndFunction


; Settings - int
bool Function Settings_IntHas(string _settingsFileName, string _theKey) global
	return JsonUtil.HasIntValue(SettingsFolder() + _settingsFileName, _theKey)
EndFunction

int Function Settings_IntGet(string _settingsFileName, string _theKey, int _defaultValue = 0) global
	return JsonUtil.GetIntValue(SettingsFolder() + _settingsFileName, _theKey, _defaultValue)
EndFunction

int Function Settings_IntSet(string _settingsFileName, string _theKey, int _value = 0) global
	return JsonUtil.SetIntValue(SettingsFolder() + _settingsFileName, _theKey, _value)
EndFunction

bool Function Settings_IntUnset(string _settingsFileName, string _theKey) global
	return JsonUtil.UnsetIntValue(SettingsFolder() + _settingsFileName, _theKey)
EndFunction

int Function Settings_IntAdjust(string _settingsFileName, string _theKey, int _amount) global
	return JsonUtil.AdjustIntValue(SettingsFolder() + _settingsFileName, _theKey, _amount)
EndFunction



; Settings - string[]
int Function Settings_StringListAdd(string _settingsFileName, string _theKey, string _theValue, bool _allowDuplicate = true) global
	return JsonUtil.StringListAdd(SettingsFolder() + _settingsFileName, _theKey, _theValue, _allowDuplicate)
EndFunction

string Function Settings_StringListGet(string _settingsFileName, string _theKey, int _theIndex) global
	return JsonUtil.StringListGet(SettingsFolder() + _settingsFileName, _theKey, _theIndex)
EndFunction

string Function Settings_StringListSet(string _settingsFileName, string _theKey, int _theIndex, string _theValue) global
	return JsonUtil.StringListSet(SettingsFolder() + _settingsFileName, _theKey, _theIndex, _theValue)
EndFunction

int Function Settings_StringListRemove(string _settingsFileName, string _theKey, string _theValue, bool _allInstaces = true) global
	return JsonUtil.StringListRemove(SettingsFolder() + _settingsFileName, _theKey, _theValue, _allInstaces)
EndFunction

bool Function Settings_StringListInsertAt(string _settingsFileName, string _theKey, int _theIndex, string _theValue) global
	return JsonUtil.StringListInsertAt(SettingsFolder() + _settingsFileName, _theKey, _theIndex, _theValue)
EndFunction

bool Function Settings_StringListRemoveAt(string _settingsFileName, string _theKey, int _theIndex) global
	return JsonUtil.StringListRemoveAt(SettingsFolder() + _settingsFileName, _theKey, _theIndex)
EndFunction

int Function Settings_StringListClear(string _settingsFileName, string _theKey) global
	return JsonUtil.StringListClear(SettingsFolder() + _settingsFileName, _theKey)
EndFunction

int Function Settings_StringListCount(string _settingsFileName, string _theKey) global
	return JsonUtil.StringListCount(SettingsFolder() + _settingsFileName, _theKey)
EndFunction

int Function Settings_StringListCountValue(string _settingsFileName, string _theKey, string _theValue, bool _exclude = false) global
	return JsonUtil.StringListCountValue(SettingsFolder() + _settingsFileName, _theKey, _theValue, _exclude)
EndFunction

int Function Settings_StringListFind(string _settingsFileName, string _theKey, string _theValue) global
	return JsonUtil.StringListFind(SettingsFolder() + _settingsFileName, _theKey, _theValue)
EndFunction

bool Function Settings_StringListHas(string _settingsFileName, string _theKey, string _theValue) global
	return JsonUtil.StringListHas(SettingsFolder() + _settingsFileName, _theKey, _theValue)
EndFunction

Function Settings_StringListSlice(string _settingsFileName, string _theKey, string[] slice, int startIndex = 0) global
	JsonUtil.StringListSlice(SettingsFolder() + _settingsFileName, _theKey, slice, startIndex)
EndFunction

int Function Settings_StringListResize(string _settingsFileName, string _theKey, int toLength, string filler = "") global
	return JsonUtil.StringListResize(SettingsFolder() + _settingsFileName, _theKey, toLength, filler)
EndFunction

bool Function Settings_StringListCopy(string _settingsFileName, string _theKey, string[] copy) global
	return JsonUtil.StringListCopy(SettingsFolder() + _settingsFileName, _theKey, copy)
EndFunction

string[] Function Settings_StringListToArray(string _settingsFileName, string _theKey) global
	return JsonUtil.StringListToArray(SettingsFolder() + _settingsFileName, _theKey)
EndFunction

int function Settings_StringCountPrefix(string _settingsFileName, string _theKeyPrefix) global
	return JsonUtil.CountStringListPrefix(SettingsFolder() + _settingsFileName, _theKeyPrefix)
EndFunction




; Settings - Form[]
int Function Settings_FormListAdd(string _settingsFileName, string _theKey, Form _theValue, bool _allowDuplicate = true) global
	return JsonUtil.FormListAdd(SettingsFolder() + _settingsFileName, _theKey, _theValue, _allowDuplicate)
EndFunction

Form Function Settings_FormListGet(string _settingsFileName, string _theKey, int _theIndex) global
	return JsonUtil.FormListGet(SettingsFolder() + _settingsFileName, _theKey, _theIndex)
EndFunction

Form Function Settings_FormListSet(string _settingsFileName, string _theKey, int _theIndex, Form _theValue) global
	return JsonUtil.FormListSet(SettingsFolder() + _settingsFileName, _theKey, _theIndex, _theValue)
EndFunction

int Function Settings_FormListRemove(string _settingsFileName, string _theKey, Form _theValue, bool _allInstaces = true) global
	return JsonUtil.FormListRemove(SettingsFolder() + _settingsFileName, _theKey, _theValue, _allInstaces)
EndFunction

bool Function Settings_FormListInsertAt(string _settingsFileName, string _theKey, int _theIndex, Form _theValue) global
	return JsonUtil.FormListInsertAt(SettingsFolder() + _settingsFileName, _theKey, _theIndex, _theValue)
EndFunction

bool Function Settings_FormListRemoveAt(string _settingsFileName, string _theKey, int _theIndex) global
	return JsonUtil.FormListRemoveAt(SettingsFolder() + _settingsFileName, _theKey, _theIndex)
EndFunction

int Function Settings_FormListClear(string _settingsFileName, string _theKey) global
	return JsonUtil.FormListClear(SettingsFolder() + _settingsFileName, _theKey)
EndFunction

int Function Settings_FormListCount(string _settingsFileName, string _theKey) global
	return JsonUtil.FormListCount(SettingsFolder() + _settingsFileName, _theKey)
EndFunction

int Function Settings_FormListCountValue(string _settingsFileName, string _theKey, Form _theValue, bool _exclude = false) global
	return JsonUtil.FormListCountValue(SettingsFolder() + _settingsFileName, _theKey, _theValue, _exclude)
EndFunction

int Function Settings_FormListFind(string _settingsFileName, string _theKey, Form _theValue) global
	return JsonUtil.FormListFind(SettingsFolder() + _settingsFileName, _theKey, _theValue)
EndFunction

bool Function Settings_FormListHas(string _settingsFileName, string _theKey, Form _theValue) global
	return JsonUtil.FormListHas(SettingsFolder() + _settingsFileName, _theKey, _theValue)
EndFunction

Function Settings_FormListSlice(string _settingsFileName, string _theKey, Form[] slice, int startIndex = 0) global
	JsonUtil.FormListSlice(SettingsFolder() + _settingsFileName, _theKey, slice, startIndex)
EndFunction

int Function Settings_FormListResize(string _settingsFileName, string _theKey, int toLength, Form filler = None) global
	return JsonUtil.FormListResize(SettingsFolder() + _settingsFileName, _theKey, toLength, filler)
EndFunction

bool Function Settings_FormListCopy(string _settingsFileName, string _theKey, Form[] copy) global
	return JsonUtil.FormListCopy(SettingsFolder() + _settingsFileName, _theKey, copy)
EndFunction

Form[] Function Settings_FormListToArray(string _settingsFileName, string _theKey) global
	return JsonUtil.FormListToArray(SettingsFolder() + _settingsFileName, _theKey)
EndFunction

int function Settings_FormCountPrefix(string _settingsFileName, string _theKeyPrefix) global
	return JsonUtil.CountFormListPrefix(SettingsFolder() + _settingsFileName, _theKeyPrefix)
EndFunction




; Settings - float[]
int Function Settings_FloatListAdd(string _settingsFileName, string _theKey, float _theValue, bool _allowDuplicate = true) global
	return JsonUtil.FloatListAdd(SettingsFolder() + _settingsFileName, _theKey, _theValue, _allowDuplicate)
EndFunction

float Function Settings_FloatListGet(string _settingsFileName, string _theKey, int _theIndex) global
	return JsonUtil.FloatListGet(SettingsFolder() + _settingsFileName, _theKey, _theIndex)
EndFunction

float Function Settings_FloatListSet(string _settingsFileName, string _theKey, int _theIndex, float _theValue) global
	return JsonUtil.FloatListSet(SettingsFolder() + _settingsFileName, _theKey, _theIndex, _theValue)
EndFunction

int Function Settings_FloatListRemove(string _settingsFileName, string _theKey, float _theValue, bool _allInstaces = true) global
	return JsonUtil.FloatListRemove(SettingsFolder() + _settingsFileName, _theKey, _theValue, _allInstaces)
EndFunction

bool Function Settings_FloatListInsertAt(string _settingsFileName, string _theKey, int _theIndex, float _theValue) global
	return JsonUtil.FloatListInsertAt(SettingsFolder() + _settingsFileName, _theKey, _theIndex, _theValue)
EndFunction

bool Function Settings_FloatListRemoveAt(string _settingsFileName, string _theKey, int _theIndex) global
	return JsonUtil.FloatListRemoveAt(SettingsFolder() + _settingsFileName, _theKey, _theIndex)
EndFunction

int Function Settings_FloatListClear(string _settingsFileName, string _theKey) global
	return JsonUtil.FloatListClear(SettingsFolder() + _settingsFileName, _theKey)
EndFunction

int Function Settings_FloatListCount(string _settingsFileName, string _theKey) global
	return JsonUtil.FloatListCount(SettingsFolder() + _settingsFileName, _theKey)
EndFunction

int Function Settings_FloatListCountValue(string _settingsFileName, string _theKey, float _theValue, bool _exclude = false) global
	return JsonUtil.FloatListCountValue(SettingsFolder() + _settingsFileName, _theKey, _theValue, _exclude)
EndFunction

int Function Settings_FloatListFind(string _settingsFileName, string _theKey, float _theValue) global
	return JsonUtil.FloatListFind(SettingsFolder() + _settingsFileName, _theKey, _theValue)
EndFunction

bool Function Settings_FloatListHas(string _settingsFileName, string _theKey, float _theValue) global
	return JsonUtil.FloatListHas(SettingsFolder() + _settingsFileName, _theKey, _theValue)
EndFunction

Function Settings_FloatListSlice(string _settingsFileName, string _theKey, float[] slice, int startIndex = 0) global
	JsonUtil.FloatListSlice(SettingsFolder() + _settingsFileName, _theKey, slice, startIndex)
EndFunction

int Function Settings_FloatListResize(string _settingsFileName, string _theKey, int toLength, float filler = 0.0) global
	return JsonUtil.FloatListResize(SettingsFolder() + _settingsFileName, _theKey, toLength, filler)
EndFunction

bool Function Settings_FloatListCopy(string _settingsFileName, string _theKey, float[] copy) global
	return JsonUtil.FloatListCopy(SettingsFolder() + _settingsFileName, _theKey, copy)
EndFunction

float[] Function Settings_FloatListToArray(string _settingsFileName, string _theKey) global
	return JsonUtil.FloatListToArray(SettingsFolder() + _settingsFileName, _theKey)
EndFunction

int function Settings_FloatCountPrefix(string _settingsFileName, string _theKeyPrefix) global
	return JsonUtil.CountFloatListPrefix(SettingsFolder() + _settingsFileName, _theKeyPrefix)
EndFunction

float Function Settings_FloatListAdjust(string _settingsFileName, string _theKey, int _theIndex, float _amount) global
	return JsonUtil.FloatListAdjust(SettingsFolder() + _settingsFileName, _theKey, _theIndex, _amount)
EndFunction



; Settings - int[]
int Function Settings_IntListAdd(string _settingsFileName, string _theKey, int _theValue, bool _allowDuplicate = true) global
	return JsonUtil.IntListAdd(SettingsFolder() + _settingsFileName, _theKey, _theValue, _allowDuplicate)
EndFunction

int Function Settings_IntListGet(string _settingsFileName, string _theKey, int _theIndex) global
	return JsonUtil.IntListGet(SettingsFolder() + _settingsFileName, _theKey, _theIndex)
EndFunction

int Function Settings_IntListSet(string _settingsFileName, string _theKey, int _theIndex, int _theValue) global
	return JsonUtil.IntListSet(SettingsFolder() + _settingsFileName, _theKey, _theIndex, _theValue)
EndFunction

int Function Settings_IntListRemove(string _settingsFileName, string _theKey, int _theValue, bool _allInstaces = true) global
	return JsonUtil.IntListRemove(SettingsFolder() + _settingsFileName, _theKey, _theValue, _allInstaces)
EndFunction

bool Function Settings_IntListInsertAt(string _settingsFileName, string _theKey, int _theIndex, int _theValue) global
	return JsonUtil.IntListInsertAt(SettingsFolder() + _settingsFileName, _theKey, _theIndex, _theValue)
EndFunction

bool Function Settings_IntListRemoveAt(string _settingsFileName, string _theKey, int _theIndex) global
	return JsonUtil.IntListRemoveAt(SettingsFolder() + _settingsFileName, _theKey, _theIndex)
EndFunction

int Function Settings_IntListClear(string _settingsFileName, string _theKey) global
	return JsonUtil.IntListClear(SettingsFolder() + _settingsFileName, _theKey)
EndFunction

int Function Settings_IntListCount(string _settingsFileName, string _theKey) global
	return JsonUtil.IntListCount(SettingsFolder() + _settingsFileName, _theKey)
EndFunction

int Function Settings_IntListCountValue(string _settingsFileName, string _theKey, int _theValue, bool _exclude = false) global
	return JsonUtil.IntListCountValue(SettingsFolder() + _settingsFileName, _theKey, _theValue, _exclude)
EndFunction

int Function Settings_IntListFind(string _settingsFileName, string _theKey, int _theValue) global
	return JsonUtil.IntListFind(SettingsFolder() + _settingsFileName, _theKey, _theValue)
EndFunction

bool Function Settings_IntListHas(string _settingsFileName, string _theKey, int _theValue) global
	return JsonUtil.IntListHas(SettingsFolder() + _settingsFileName, _theKey, _theValue)
EndFunction

Function Settings_IntListSlice(string _settingsFileName, string _theKey, int[] slice, int startIndex = 0) global
	JsonUtil.IntListSlice(SettingsFolder() + _settingsFileName, _theKey, slice, startIndex)
EndFunction

int Function Settings_IntListResize(string _settingsFileName, string _theKey, int toLength, int filler = 0) global
	return JsonUtil.IntListResize(SettingsFolder() + _settingsFileName, _theKey, toLength, filler)
EndFunction

bool Function Settings_IntListCopy(string _settingsFileName, string _theKey, int[] copy) global
	return JsonUtil.IntListCopy(SettingsFolder() + _settingsFileName, _theKey, copy)
EndFunction

int[] Function Settings_IntListToArray(string _settingsFileName, string _theKey) global
	return JsonUtil.IntListToArray(SettingsFolder() + _settingsFileName, _theKey)
EndFunction

int function Settings_IntCountPrefix(string _settingsFileName, string _theKeyPrefix) global
	return JsonUtil.CountIntListPrefix(SettingsFolder() + _settingsFileName, _theKeyPrefix)
EndFunction

int Function Settings_IntListAdjust(string _settingsFileName, string _theKey, int _theIndex, int _amount) global
	return JsonUtil.IntListAdjust(SettingsFolder() + _settingsFileName, _theKey, _theIndex, _amount)
EndFunction


