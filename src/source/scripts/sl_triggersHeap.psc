scriptname sl_triggersHeap

import sl_triggersStatics

;/
Mirroring StorageUtil functions to provide a slightly more convenient
interface. Although direct use is of course an option, you may want
to create your own convenience wrappers, either around these functions
or directly around StorageUtil. Just bear in mind the use of the key
strategy here.

	sl_triggers:<instance_key>:<keyname>

where <instance_key> and <keyname> are strings.

IT IS HEAVILY IMPLIED BY THE NAMING SCHEME THAT THIS FRAMEWORK IS
ASSUMING HEAP IS INTERACTING WITH Actor FORMS. WHILE THIS IS NOT
ENFORCED, AND THERE IS NOTHING ABOUT THIS THAT WOULD NOT WORK IN
THAT EVENT, KEEP IN MIND THAT THE FRAMEWORK IS GOING TO ASSUME
THAT Actor OBJECTS ARE WHERE THINGS ARE BEING STORED. OTHERWISE
FEEL FREE TO USE THIS. IT REALLY JUST IS A BIG DUMB WRAPPER AROUND
StorageUtil.

An <instance_key> might be an Extension's <extension_key> for
Extension wide Heap storage, or it may be the constructed
<instance_key> for an ActiveMagicEffect representing a single
trigger-file pair attached to the Actor. It's just an additional
layer of taxonomy.
/;

; Utility and Functional

int Function Heap_ClearPrefixF(Form _theActor, string extensionPrefix) global
	return StorageUtil.ClearAllObjPrefix(_theActor, extensionPrefix)
EndFunction

Function Heap_CompleteScript(Form _theActor, string _instanceId) global
	string instanceIdKey = MakeInstanceKey("slt_heap", "instanceidlist")
	string sessionIdKey = MakeInstanceKey("slt_heap", "sessionidlist")

	int instanceIndex = StorageUtil.StringListFind(_theActor, instanceIdKey, _instanceId)
	if instanceIndex > -1
		StorageUtil.StringListRemoveAt(_theActor, instanceIdKey, instanceIndex)
		StorageUtil.IntListRemoveAt(_theActor, sessionIdKey, instanceIndex)
	endif
EndFunction

string Function _slt_Actual_Heap_DequeueInstanceIdF(Form _theActor) global
	string instanceIdKey = MakeInstanceKey("slt_heap", "instanceidlist")
	string sessionIdKey = MakeInstanceKey("slt_heap", "sessionidlist")

	int currentSessionId = sl_triggers_internal.SafeGetSessionId()
	int sessionIdCount = StorageUtil.IntListCount(_theActor, sessionIdKey)
	int instanceIdCount = StorageUtil.StringListCount(_theActor, instanceIdKey)

	if sessionIdCount != instanceIdCount
		; probably a problem, possibly an edge case
		return ""
	endif

	int i = 0
	while i < sessionIdCount
		int actorsession_I = StorageUtil.IntListGet(_theActor, sessionIdKey, i)
		if currentSessionId != StorageUtil.IntListGet(_theActor, sessionIdKey, i)
			; found our spot, get to it
			StorageUtil.IntListSet(_theActor, sessionIdKey, i, currentSessionId)
			return StorageUtil.StringListGet(_theActor, instanceIdKey, i)
		endif
		i += 1
	endwhile

	; all requests are accounted for, we can just go away
	Debug.Trace("Heap_DequeueInstanceIdF: dequeue requested for Form(" + _theActor.GetName() + ") but no sessions are pending")
	return ""
EndFunction

string Function Heap_DequeueInstanceIdF(Form _theActor) global
	string syncKey = "slt_synchronizationCounterForActor"

	int kval = StorageUtil.AdjustIntValue(_theActor, syncKey, 1)
	
	while kval > 1
		StorageUtil.AdjustIntValue(_theActor, syncKey, -1)
		
		int retries = 0
		while retries < 100 && kval != 1
			Utility.Wait(0.1)
			kval = StorageUtil.AdjustIntValue(_theActor, syncKey, 1)
			if kval != 1
				StorageUtil.AdjustIntValue(_theActor, syncKey, -1)
			endif
			retries += 1
		endwhile

		if retries >= 100
			Debug.Trace("Heap_DequeueInstanceIdF: synchronization timeout for actor " + _theActor.GetName())
			return ""
		endif
	endwhile

	;; past synchronization point
	string result = _slt_Actual_Heap_DequeueInstanceIdF(_theActor)

	StorageUtil.AdjustIntValue(_theActor, syncKey, -1)

	return result
EndFunction

Function Heap_EnqueueInstanceIdF(Form _theActor, string instanceId) global
	StorageUtil.StringListAdd(_theActor, MakeInstanceKey("slt_heap", "instanceidlist"), instanceId)
	StorageUtil.IntListAdd(_theActor, MakeInstanceKey("slt_heap", "sessionidlist"), 0)
EndFunction


; With instanceId and keyName
; string
bool Function Heap_StringHasX(Form _theActor, string _instanceId, string _theKeyName) global
	return Heap_StringHasFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName))
EndFunction

string Function Heap_StringGetX(Form _theActor, string _instanceId, string _theKeyName, string _defaultValue = "") global
	return Heap_StringGetFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _defaultValue)
EndFunction

string Function Heap_StringSetX(Form _theActor, string _instanceId, string _theKeyName, string _value = "") global
	return Heap_StringSetFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _value)
EndFunction

bool Function Heap_StringUnsetX(Form _theActor, string _instanceId, string _theKeyName) global
	return Heap_StringUnsetFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName))
EndFunction

string Function Heap_StringPluckX(Form _theActor, string _instanceId, string _theKeyName, string _defaultValue = "") global
	return Heap_StringPluckFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _defaultValue)
EndFunction



; string[]
int function Heap_StringListAddX(Form _theActor, string _instanceId, string _theKeyName, string _value, bool _allowDuplicate = true) global
	return Heap_StringListAddFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _value, _allowDuplicate)
EndFunction

string function Heap_StringListGetX(Form _theActor, string _instanceId, string _theKeyName, int _index) global
	return Heap_StringListGetFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _index)
EndFunction

string function Heap_StringListSetX(Form _theActor, string _instanceId, string _theKeyName, int _index, string _value) global
	return Heap_StringListSetFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _index, _value)
EndFunction

string function Heap_StringListPluckX(Form _theActor, string _instanceId, string _theKeyName, int _index, string _missing) global
	return Heap_StringListPluckFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _index, _missing)
EndFunction

string function Heap_StringListShiftX(Form _theActor, string _instanceId, string _theKeyName) global
	return Heap_StringListShiftFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName))
EndFunction

string function Heap_StringListPopX(Form _theActor, string _instanceId, string _theKeyName) global
	return Heap_StringListPopFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName))
EndFunction

bool function Heap_StringListInsertX(Form _theActor, string _instanceId, string _theKeyName, int _index, string _value) global
	return Heap_StringListInsertFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _index, _value)
EndFunction

int function Heap_StringListRemoveX(Form _theActor, string _instanceId, string _theKeyName, string _value, bool allInstances = false) global
	return Heap_StringListRemoveFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _value, allInstances)
EndFunction

int function Heap_StringListClearX(Form _theActor, string _instanceId, string _theKeyName) global
	return Heap_StringListClearFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName))
EndFunction

bool function Heap_StringListRemoveAtX(Form _theActor, string _instanceId, string _theKeyName, int _index) global
	return Heap_StringListRemoveAtFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _index)
EndFunction

int function Heap_StringListCountX(Form _theActor, string _instanceId, string _theKeyName) global
	return Heap_StringListCountFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName))
EndFunction

int function Heap_StringListCountValueX(Form _theActor, string _instanceId, string _theKeyName, string _value, bool _exclude = false) global
	return Heap_StringListCountValueFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _value, _exclude)
EndFunction

int function Heap_StringListFindX(Form _theActor, string _instanceId, string _theKeyName, string _value) global
	return Heap_StringListFindFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _value)
EndFunction

bool function Heap_StringListHasX(Form _theActor, string _instanceId, string _theKeyName, string _value) global
	return Heap_StringListHasFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _value)
EndFunction

function Heap_StringListSortX(Form _theActor, string _instanceId, string _theKeyName) global
	Heap_StringListSortFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName))
EndFunction

function Heap_StringListSliceX(Form _theActor, string _instanceId, string _theKeyName, string[] _slice, int _startIndex = 0) global
	Heap_StringListSliceFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _slice, _startIndex)
EndFunction

int function Heap_StringListResizeX(Form _theActor, string _instanceId, string _theKeyName, int _toLength, string _filler = "") global
	return Heap_StringListResizeFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _toLength, _filler)
EndFunction

bool function Heap_StringListCopyX(Form _theActor, string _instanceId, string _theKeyName, string[] _copy) global
	return Heap_StringListCopyFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _copy)
EndFunction

string[] function Heap_StringListToArrayX(Form _theActor, string _instanceId, string _theKeyName) global
	return Heap_StringListToArrayFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName))
EndFunction

int function Heap_StringListClearPrefixX(Form _theActor, string _prefixKey) global
	return Heap_StringListClearPrefixFK(_theActor, _prefixKey)
EndFunction





; Form
bool Function Heap_FormHasX(Form _theActor, string _instanceId, string _theKeyName) global
	return Heap_FormHasFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName))
EndFunction

Form Function Heap_FormGetX(Form _theActor, string _instanceId, string _theKeyName, Form _defaultValue = None) global
	return Heap_FormGetFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _defaultValue)
EndFunction

Form Function Heap_FormSetX(Form _theActor, string _instanceId, string _theKeyName, Form _value = None) global
	return Heap_FormSetFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _value)
EndFunction

bool Function Heap_FormUnsetX(Form _theActor, string _instanceId, string _theKeyName) global
	return Heap_FormUnsetFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName))
EndFunction

Form Function Heap_FormPluckX(Form _theActor, string _instanceId, string _theKeyName, Form _defaultValue = None) global
	return Heap_FormPluckFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _defaultValue)
EndFunction



; Form[]
int function Heap_FormListAddX(Form _theActor, string _instanceId, string _theKeyName, Form _value, bool _allowDuplicate = true) global
	return Heap_FormListAddFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _value, _allowDuplicate)
EndFunction

Form function Heap_FormListGetX(Form _theActor, string _instanceId, string _theKeyName, int _index) global
	return Heap_FormListGetFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _index)
EndFunction

Form function Heap_FormListSetX(Form _theActor, string _instanceId, string _theKeyName, int _index, Form _value) global
	return Heap_FormListSetFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _index, _value)
EndFunction

Form function Heap_FormListPluckX(Form _theActor, string _instanceId, string _theKeyName, int _index, Form _missing) global
	return Heap_FormListPluckFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _index, _missing)
EndFunction

Form function Heap_FormListShiftX(Form _theActor, string _instanceId, string _theKeyName) global
	return Heap_FormListShiftFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName))
EndFunction

Form function Heap_FormListPopX(Form _theActor, string _instanceId, string _theKeyName) global
	return Heap_FormListPopFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName))
EndFunction

bool function Heap_FormListInsertX(Form _theActor, string _instanceId, string _theKeyName, int _index, Form _value) global
	return Heap_FormListInsertFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _index, _value)
EndFunction

int function Heap_FormListRemoveX(Form _theActor, string _instanceId, string _theKeyName, Form _value, bool allInstances = false) global
	return Heap_FormListRemoveFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _value, allInstances)
EndFunction

int function Heap_FormListClearX(Form _theActor, string _instanceId, string _theKeyName) global
	return Heap_FormListClearFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName))
EndFunction

bool function Heap_FormListRemoveAtX(Form _theActor, string _instanceId, string _theKeyName, int _index) global
	return Heap_FormListRemoveAtFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _index)
EndFunction

int function Heap_FormListCountX(Form _theActor, string _instanceId, string _theKeyName) global
	return Heap_FormListCountFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName))
EndFunction

int function Heap_FormListCountValueX(Form _theActor, string _instanceId, string _theKeyName, Form _value, bool _exclude = false) global
	return Heap_FormListCountValueFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _value, _exclude)
EndFunction

int function Heap_FormListFindX(Form _theActor, string _instanceId, string _theKeyName, Form _value) global
	return Heap_FormListFindFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _value)
EndFunction

bool function Heap_FormListHasX(Form _theActor, string _instanceId, string _theKeyName, Form _value) global
	return Heap_FormListHasFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _value)
EndFunction

function Heap_FormListSortX(Form _theActor, string _instanceId, string _theKeyName) global
	Heap_FormListSortFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName))
EndFunction

function Heap_FormListSliceX(Form _theActor, string _instanceId, string _theKeyName, Form[] _slice, int _startIndex = 0) global
	Heap_FormListSliceFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _slice, _startIndex)
EndFunction

int function Heap_FormListResizeX(Form _theActor, string _instanceId, string _theKeyName, int _toLength, Form _filler = None) global
	return Heap_FormListResizeFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _toLength, _filler)
EndFunction

bool function Heap_FormListCopyX(Form _theActor, string _instanceId, string _theKeyName, Form[] _copy) global
	return Heap_FormListCopyFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _copy)
EndFunction

Form[] function Heap_FormListToArrayX(Form _theActor, string _instanceId, string _theKeyName) global
	return Heap_FormListToArrayFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName))
EndFunction

int function Heap_FormListClearPrefixX(Form _theActor, string _prefixKey) global
	return Heap_FormListClearPrefixFK(_theActor, _prefixKey)
EndFunction





; float
bool Function Heap_FloatHasX(Form _theActor, string _instanceId, string _theKeyName) global
	return Heap_FloatHasFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName))
EndFunction

float Function Heap_FloatGetX(Form _theActor, string _instanceId, string _theKeyName, float _defaultValue = 0.0) global
	return Heap_FloatGetFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _defaultValue)
EndFunction

float Function Heap_FloatSetX(Form _theActor, string _instanceId, string _theKeyName, float _value = 0.0) global
	return Heap_FloatSetFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _value)
EndFunction

bool Function Heap_FloatUnsetX(Form _theActor, string _instanceId, string _theKeyName) global
	return Heap_FloatUnsetFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName))
EndFunction

float Function Heap_FloatPluckX(Form _theActor, string _instanceId, string _theKeyName, float _defaultValue = 0.0) global
	return Heap_FloatPluckFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _defaultValue)
EndFunction

float Function Heap_FloatAdjustX(Form _theActor, string _instanceId, string _theKeyName, float _amount) global
	return Heap_FloatAdjustFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _amount)
EndFunction


; float[]
int function Heap_FloatListAddX(Form _theActor, string _instanceId, string _theKeyName, float _value, bool _allowDuplicate = true) global
	return Heap_FloatListAddFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _value, _allowDuplicate)
EndFunction

float function Heap_FloatListGetX(Form _theActor, string _instanceId, string _theKeyName, int _index) global
	return Heap_FloatListGetFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _index)
EndFunction

float function Heap_FloatListSetX(Form _theActor, string _instanceId, string _theKeyName, int _index, float _value) global
	return Heap_FloatListSetFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _index, _value)
EndFunction

float function Heap_FloatListPluckX(Form _theActor, string _instanceId, string _theKeyName, int _index, float _missing) global
	return Heap_FloatListPluckFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _index, _missing)
EndFunction

float function Heap_FloatListShiftX(Form _theActor, string _instanceId, string _theKeyName) global
	return Heap_FloatListShiftFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName))
EndFunction

float function Heap_FloatListPopX(Form _theActor, string _instanceId, string _theKeyName) global
	return Heap_FloatListPopFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName))
EndFunction

bool function Heap_FloatListInsertX(Form _theActor, string _instanceId, string _theKeyName, int _index, float _value) global
	return Heap_FloatListInsertFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _index, _value)
EndFunction

int function Heap_FloatListRemoveX(Form _theActor, string _instanceId, string _theKeyName, float _value, bool allInstances = false) global
	return Heap_FloatListRemoveFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _value, allInstances)
EndFunction

int function Heap_FloatListClearX(Form _theActor, string _instanceId, string _theKeyName) global
	return Heap_FloatListClearFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName))
EndFunction

bool function Heap_FloatListRemoveAtX(Form _theActor, string _instanceId, string _theKeyName, int _index) global
	return Heap_FloatListRemoveAtFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _index)
EndFunction

int function Heap_FloatListCountX(Form _theActor, string _instanceId, string _theKeyName) global
	return Heap_FloatListCountFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName))
EndFunction

int function Heap_FloatListCountValueX(Form _theActor, string _instanceId, string _theKeyName, float _value, bool _exclude = false) global
	return Heap_FloatListCountValueFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _value, _exclude)
EndFunction

int function Heap_FloatListFindX(Form _theActor, string _instanceId, string _theKeyName, float _value) global
	return Heap_FloatListFindFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _value)
EndFunction

bool function Heap_FloatListHasX(Form _theActor, string _instanceId, string _theKeyName, float _value) global
	return Heap_FloatListHasFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _value)
EndFunction

function Heap_FloatListSortX(Form _theActor, string _instanceId, string _theKeyName) global
	Heap_FloatListSortFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName))
EndFunction

function Heap_FloatListSliceX(Form _theActor, string _instanceId, string _theKeyName, float[] _slice, int _startIndex = 0) global
	Heap_FloatListSliceFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _slice, _startIndex)
EndFunction

int function Heap_FloatListResizeX(Form _theActor, string _instanceId, string _theKeyName, int _toLength, float _filler = 0.0) global
	return Heap_FloatListResizeFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _toLength, _filler)
EndFunction

bool function Heap_FloatListCopyX(Form _theActor, string _instanceId, string _theKeyName, float[] _copy) global
	return Heap_FloatListCopyFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _copy)
EndFunction

float[] function Heap_FloatListToArrayX(Form _theActor, string _instanceId, string _theKeyName) global
	return Heap_FloatListToArrayFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName))
EndFunction

int function Heap_FloatListClearPrefixX(Form _theActor, string _prefixKey) global
	return Heap_FloatListClearPrefixFK(_theActor, _prefixKey)
EndFunction


float Function Heap_FloatListAdjustX(Form _theActor, string _instanceId, string _theKeyName, int _theIndex, float _amount) global
	return Heap_FloatListAdjustFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _theIndex, _amount)
EndFunction



; int
bool Function Heap_IntHasX(Form _theActor, string _instanceId, string _theKeyName) global
	return Heap_IntHasFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName))
EndFunction

int Function Heap_IntGetX(Form _theActor, string _instanceId, string _theKeyName, int _defaultValue = 0) global
	return Heap_IntGetFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _defaultValue)
EndFunction

int Function Heap_IntSetX(Form _theActor, string _instanceId, string _theKeyName, int _value = 0) global
	return Heap_IntSetFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _value)
EndFunction

bool Function Heap_IntUnsetX(Form _theActor, string _instanceId, string _theKeyName) global
	return Heap_IntUnsetFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName))
EndFunction

int Function Heap_IntPluckX(Form _theActor, string _instanceId, string _theKeyName, int _defaultValue = 0) global
	return Heap_IntPluckFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _defaultValue)
EndFunction

int Function Heap_IntAdjustX(Form _theActor, string _instanceId, string _theKeyName, int _amount) global
	return Heap_IntAdjustFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _amount)
EndFunction


; int[]
int function Heap_IntListAddX(Form _theActor, string _instanceId, string _theKeyName, int _value, bool _allowDuplicate = true) global
	return Heap_IntListAddFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _value, _allowDuplicate)
EndFunction

int function Heap_IntListGetX(Form _theActor, string _instanceId, string _theKeyName, int _index) global
	return Heap_IntListGetFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _index)
EndFunction

int function Heap_IntListSetX(Form _theActor, string _instanceId, string _theKeyName, int _index, int _value) global
	return Heap_IntListSetFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _index, _value)
EndFunction

int function Heap_IntListPluckX(Form _theActor, string _instanceId, string _theKeyName, int _index, int _missing) global
	return Heap_IntListPluckFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _index, _missing)
EndFunction

int function Heap_IntListShiftX(Form _theActor, string _instanceId, string _theKeyName) global
	return Heap_IntListShiftFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName))
EndFunction

int function Heap_IntListPopX(Form _theActor, string _instanceId, string _theKeyName) global
	return Heap_IntListPopFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName))
EndFunction

bool function Heap_IntListInsertX(Form _theActor, string _instanceId, string _theKeyName, int _index, int _value) global
	return Heap_IntListInsertFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _index, _value)
EndFunction

int function Heap_IntListRemoveX(Form _theActor, string _instanceId, string _theKeyName, int _value, bool allInstances = false) global
	return Heap_IntListRemoveFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _value, allInstances)
EndFunction

int function Heap_IntListClearX(Form _theActor, string _instanceId, string _theKeyName) global
	return Heap_IntListClearFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName))
EndFunction

bool function Heap_IntListRemoveAtX(Form _theActor, string _instanceId, string _theKeyName, int _index) global
	return Heap_IntListRemoveAtFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _index)
EndFunction

int function Heap_IntListCountX(Form _theActor, string _instanceId, string _theKeyName) global
	return Heap_IntListCountFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName))
EndFunction

int function Heap_IntListCountValueX(Form _theActor, string _instanceId, string _theKeyName, int _value, bool _exclude = false) global
	return Heap_IntListCountValueFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _value, _exclude)
EndFunction

int function Heap_IntListFindX(Form _theActor, string _instanceId, string _theKeyName, int _value) global
	return Heap_IntListFindFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _value)
EndFunction

bool function Heap_IntListHasX(Form _theActor, string _instanceId, string _theKeyName, int _value) global
	return Heap_IntListHasFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _value)
EndFunction

function Heap_IntListSortX(Form _theActor, string _instanceId, string _theKeyName) global
	Heap_IntListSortFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName))
EndFunction

function Heap_IntListSliceX(Form _theActor, string _instanceId, string _theKeyName, int[] _slice, int _startIndex = 0) global
	Heap_IntListSliceFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _slice, _startIndex)
EndFunction

int function Heap_IntListResizeX(Form _theActor, string _instanceId, string _theKeyName, int _toLength, int _filler = 0) global
	return Heap_IntListResizeFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _toLength, _filler)
EndFunction

bool function Heap_IntListCopyX(Form _theActor, string _instanceId, string _theKeyName, int[] _copy) global
	return Heap_IntListCopyFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _copy)
EndFunction

int[] function Heap_IntListToArrayX(Form _theActor, string _instanceId, string _theKeyName) global
	return Heap_IntListToArrayFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName))
EndFunction

int function Heap_IntListClearPrefixX(Form _theActor, string _prefixKey) global
	return Heap_IntListClearPrefixFK(_theActor, _prefixKey)
EndFunction


int Function Heap_IntListAdjustX(Form _theActor, string _instanceId, string _theKeyName, int _theIndex, int _amount) global
	return Heap_IntListAdjustFK(_theActor, MakeInstanceKey(_instanceId, _theKeyName), _theIndex, _amount)
EndFunction



; With heapKey
; string
bool Function Heap_StringHasFK(Form _theActor, string _theHeapKey) global
	return StorageUtil.HasStringValue(_theActor, _theHeapKey)
EndFunction

string Function Heap_StringGetFK(Form _theActor, string _theHeapKey, string _defaultValue = "") global
	return StorageUtil.GetStringValue(_theActor, _theHeapKey, _defaultValue)
EndFunction

string Function Heap_StringSetFK(Form _theActor, string _theHeapKey, string _value = "") global
	return StorageUtil.SetStringValue(_theActor, _theHeapKey, _value)
EndFunction

bool Function Heap_StringUnsetFK(Form _theActor, string _theHeapKey) global
	return StorageUtil.UnsetStringValue(_theActor, _theHeapKey)
EndFunction

string Function Heap_StringPluckFK(Form _theActor, string _theHeapKey, string _defaultValue = "") global
	return StorageUtil.PluckStringValue(_theActor, _theHeapKey, _defaultValue)
EndFunction



; string[]
int function Heap_StringListAddFK(Form _theActor, string _theHeapKey, string _value, bool _allowDuplicate = true) global
	return StorageUtil.StringListAdd(_theActor, _theHeapKey, _value, _allowDuplicate)
EndFunction

string function Heap_StringListGetFK(Form _theActor, string _theHeapKey, int _index) global
	return StorageUtil.StringListGet(_theActor, _theHeapKey, _index)
EndFunction

string function Heap_StringListSetFK(Form _theActor, string _theHeapKey, int _index, string _value) global
	return StorageUtil.StringListSet(_theActor, _theHeapKey, _index, _value)
EndFunction

string function Heap_StringListPluckFK(Form _theActor, string _theHeapKey, int _index, string _missing) global
	return StorageUtil.StringListPluck(_theActor, _theHeapKey, _index, _missing)
EndFunction

string function Heap_StringListShiftFK(Form _theActor, string _theHeapKey) global
	return StorageUtil.StringListShift(_theActor, _theHeapKey)
EndFunction

string function Heap_StringListPopFK(Form _theActor, string _theHeapKey) global
	return StorageUtil.StringListPop(_theActor, _theHeapKey)
EndFunction

bool function Heap_StringListInsertFK(Form _theActor, string _theHeapKey, int _index, string _value) global
	return StorageUtil.StringListInsert(_theActor, _theHeapKey, _index, _value)
EndFunction

int function Heap_StringListRemoveFK(Form _theActor, string _theHeapKey, string _value, bool _allInstances = false) global
	return StorageUtil.StringListRemove(_theActor, _theHeapKey, _value, _allInstances)
EndFunction

int function Heap_StringListClearFK(Form _theActor, string _theHeapKey) global
	return StorageUtil.StringListClear(_theActor, _theHeapKey)
EndFunction

bool function Heap_StringListRemoveAtFK(Form _theActor, string _theHeapKey, int _index) global
	return StorageUtil.StringListRemoveAt(_theActor, _theHeapKey, _index)
EndFunction

int function Heap_StringListCountFK(Form _theActor, string _theHeapKey) global
	return StorageUtil.StringListCount(_theActor, _theHeapKey)
EndFunction

int function Heap_StringListCountValueFK(Form _theActor, string _theHeapKey, string _value, bool _exclude = false) global
	return StorageUtil.StringListCountValue(_theActor, _theHeapKey, _value, _exclude)
EndFunction

int function Heap_StringListFindFK(Form _theActor, string _theHeapKey, string _value) global
	return StorageUtil.StringListFind(_theActor, _theHeapKey, _value)
EndFunction

bool function Heap_StringListHasFK(Form _theActor, string _theHeapKey, string _value) global
	return StorageUtil.StringListHas(_theActor, _theHeapKey, _value)
EndFunction

function Heap_StringListSortFK(Form _theActor, string _theHeapKey) global
	StorageUtil.StringListSort(_theActor, _theHeapKey)
EndFunction

function Heap_StringListSliceFK(Form _theActor, string _theHeapKey, string[] slice, int _startIndex = 0) global
	StorageUtil.StringListSlice(_theActor, _theHeapKey, slice, _startIndex)
EndFunction

int function Heap_StringListResizeFK(Form _theActor, string _theHeapKey, int toLength, string _filler = "") global
	return StorageUtil.StringListResize(_theActor, _theHeapKey, toLength, _filler)
EndFunction

bool function Heap_StringListCopyFK(Form _theActor, string _theHeapKey, string[] _copy) global
	return StorageUtil.StringListCopy(_theActor, _theHeapKey, _copy)
EndFunction

string[] function Heap_StringListToArrayFK(Form _theActor, string _theHeapKey) global
	return StorageUtil.StringListToArray(_theActor, _theHeapKey)
EndFunction

int function Heap_StringListClearPrefixFK(Form _theActor, string _prefixKey) global
	return StorageUtil.ClearObjStringListPrefix(_theActor, _prefixKey)
EndFunction



; Form
bool Function Heap_FormHasFK(Form _theActor, string _theHeapKey) global
	return StorageUtil.HasFormValue(_theActor, _theHeapKey)
EndFunction

Form Function Heap_FormGetFK(Form _theActor, string _theHeapKey, Form _defaultValue = None) global
	return StorageUtil.GetFormValue(_theActor, _theHeapKey, _defaultValue)
EndFunction

Form Function Heap_FormSetFK(Form _theActor, string _theHeapKey, Form _value = None) global
	return StorageUtil.SetFormValue(_theActor, _theHeapKey, _value)
EndFunction

bool Function Heap_FormUnsetFK(Form _theActor, string _theHeapKey) global
	return StorageUtil.UnsetFormValue(_theActor, _theHeapKey)
EndFunction

Form Function Heap_FormPluckFK(Form _theActor, string _theHeapKey, Form _defaultValue = None) global
	return StorageUtil.PluckFormValue(_theActor, _theHeapKey, _defaultValue)
EndFunction



; Form[]
int function Heap_FormListAddFK(Form _theActor, string _theHeapKey, Form _value, bool _allowDuplicate = true) global
	return StorageUtil.FormListAdd(_theActor, _theHeapKey, _value, _allowDuplicate)
EndFunction

Form function Heap_FormListGetFK(Form _theActor, string _theHeapKey, int _index) global
	return StorageUtil.FormListGet(_theActor, _theHeapKey, _index)
EndFunction

Form function Heap_FormListSetFK(Form _theActor, string _theHeapKey, int _index, Form _value) global
	return StorageUtil.FormListSet(_theActor, _theHeapKey, _index, _value)
EndFunction

Form function Heap_FormListPluckFK(Form _theActor, string _theHeapKey, int _index, Form _missing) global
	return StorageUtil.FormListPluck(_theActor, _theHeapKey, _index, _missing)
EndFunction

Form function Heap_FormListShiftFK(Form _theActor, string _theHeapKey) global
	return StorageUtil.FormListShift(_theActor, _theHeapKey)
EndFunction

Form function Heap_FormListPopFK(Form _theActor, string _theHeapKey) global
	return StorageUtil.FormListPop(_theActor, _theHeapKey)
EndFunction

bool function Heap_FormListInsertFK(Form _theActor, string _theHeapKey, int _index, Form _value) global
	return StorageUtil.FormListInsert(_theActor, _theHeapKey, _index, _value)
EndFunction

int function Heap_FormListRemoveFK(Form _theActor, string _theHeapKey, Form _value, bool _allInstances = false) global
	return StorageUtil.FormListRemove(_theActor, _theHeapKey, _value, _allInstances)
EndFunction

int function Heap_FormListClearFK(Form _theActor, string _theHeapKey) global
	return StorageUtil.FormListClear(_theActor, _theHeapKey)
EndFunction

bool function Heap_FormListRemoveAtFK(Form _theActor, string _theHeapKey, int _index) global
	return StorageUtil.FormListRemoveAt(_theActor, _theHeapKey, _index)
EndFunction

int function Heap_FormListCountFK(Form _theActor, string _theHeapKey) global
	return StorageUtil.FormListCount(_theActor, _theHeapKey)
EndFunction

int function Heap_FormListCountValueFK(Form _theActor, string _theHeapKey, Form _value, bool _exclude = false) global
	return StorageUtil.FormListCountValue(_theActor, _theHeapKey, _value, _exclude)
EndFunction

int function Heap_FormListFindFK(Form _theActor, string _theHeapKey, Form _value) global
	return StorageUtil.FormListFind(_theActor, _theHeapKey, _value)
EndFunction

bool function Heap_FormListHasFK(Form _theActor, string _theHeapKey, Form _value) global
	return StorageUtil.FormListHas(_theActor, _theHeapKey, _value)
EndFunction

function Heap_FormListSortFK(Form _theActor, string _theHeapKey) global
	StorageUtil.FormListSort(_theActor, _theHeapKey)
EndFunction

function Heap_FormListSliceFK(Form _theActor, string _theHeapKey, Form[] slice, int _startIndex = 0) global
	StorageUtil.FormListSlice(_theActor, _theHeapKey, slice, _startIndex)
EndFunction

int function Heap_FormListResizeFK(Form _theActor, string _theHeapKey, int toLength, Form _filler = None) global
	return StorageUtil.FormListResize(_theActor, _theHeapKey, toLength, _filler)
EndFunction

bool function Heap_FormListCopyFK(Form _theActor, string _theHeapKey, Form[] _copy) global
	return StorageUtil.FormListCopy(_theActor, _theHeapKey, _copy)
EndFunction

Form[] function Heap_FormListToArrayFK(Form _theActor, string _theHeapKey) global
	return StorageUtil.FormListToArray(_theActor, _theHeapKey)
EndFunction

int function Heap_FormListClearPrefixFK(Form _theActor, string _prefixKey) global
	return StorageUtil.ClearObjFormListPrefix(_theActor, _prefixKey)
EndFunction



; float
bool Function Heap_FloatHasFK(Form _theActor, string _theHeapKey) global
	return StorageUtil.HasFloatValue(_theActor, _theHeapKey)
EndFunction

float Function Heap_FloatGetFK(Form _theActor, string _theHeapKey, float _defaultValue = 0.0) global
	return StorageUtil.GetFloatValue(_theActor, _theHeapKey, _defaultValue)
EndFunction

float Function Heap_FloatSetFK(Form _theActor, string _theHeapKey, float _value = 0.0) global
	return StorageUtil.SetFloatValue(_theActor, _theHeapKey, _value)
EndFunction

bool Function Heap_FloatUnsetFK(Form _theActor, string _theHeapKey) global
	return StorageUtil.UnsetFloatValue(_theActor, _theHeapKey)
EndFunction

float Function Heap_FloatPluckFK(Form _theActor, string _theHeapKey, float _defaultValue = 0.0) global
	return StorageUtil.PluckFloatValue(_theActor, _theHeapKey, _defaultValue)
EndFunction

float Function Heap_FloatAdjustFK(Form _theActor, string _theHeapKey, float _amount) global
	return StorageUtil.AdjustFloatValue(_theActor, _theHeapKey, _amount)
EndFunction


; float[]
int function Heap_FloatListAddFK(Form _theActor, string _theHeapKey, float _value, bool _allowDuplicate = true) global
	return StorageUtil.FloatListAdd(_theActor, _theHeapKey, _value, _allowDuplicate)
EndFunction

float function Heap_FloatListGetFK(Form _theActor, string _theHeapKey, int _index) global
	return StorageUtil.FloatListGet(_theActor, _theHeapKey, _index)
EndFunction

float function Heap_FloatListSetFK(Form _theActor, string _theHeapKey, int _index, float _value) global
	return StorageUtil.FloatListSet(_theActor, _theHeapKey, _index, _value)
EndFunction

float function Heap_FloatListPluckFK(Form _theActor, string _theHeapKey, int _index, float _missing) global
	return StorageUtil.FloatListPluck(_theActor, _theHeapKey, _index, _missing)
EndFunction

float function Heap_FloatListShiftFK(Form _theActor, string _theHeapKey) global
	return StorageUtil.FloatListShift(_theActor, _theHeapKey)
EndFunction

float function Heap_FloatListPopFK(Form _theActor, string _theHeapKey) global
	return StorageUtil.FloatListPop(_theActor, _theHeapKey)
EndFunction

bool function Heap_FloatListInsertFK(Form _theActor, string _theHeapKey, int _index, float _value) global
	return StorageUtil.FloatListInsert(_theActor, _theHeapKey, _index, _value)
EndFunction

int function Heap_FloatListRemoveFK(Form _theActor, string _theHeapKey, float _value, bool _allInstances = false) global
	return StorageUtil.FloatListRemove(_theActor, _theHeapKey, _value, _allInstances)
EndFunction

int function Heap_FloatListClearFK(Form _theActor, string _theHeapKey) global
	return StorageUtil.FloatListClear(_theActor, _theHeapKey)
EndFunction

bool function Heap_FloatListRemoveAtFK(Form _theActor, string _theHeapKey, int _index) global
	return StorageUtil.FloatListRemoveAt(_theActor, _theHeapKey, _index)
EndFunction

int function Heap_FloatListCountFK(Form _theActor, string _theHeapKey) global
	return StorageUtil.FloatListCount(_theActor, _theHeapKey)
EndFunction

int function Heap_FloatListCountValueFK(Form _theActor, string _theHeapKey, float _value, bool _exclude = false) global
	return StorageUtil.FloatListCountValue(_theActor, _theHeapKey, _value, _exclude)
EndFunction

int function Heap_FloatListFindFK(Form _theActor, string _theHeapKey, float _value) global
	return StorageUtil.FloatListFind(_theActor, _theHeapKey, _value)
EndFunction

bool function Heap_FloatListHasFK(Form _theActor, string _theHeapKey, float _value) global
	return StorageUtil.FloatListHas(_theActor, _theHeapKey, _value)
EndFunction

function Heap_FloatListSortFK(Form _theActor, string _theHeapKey) global
	StorageUtil.FloatListSort(_theActor, _theHeapKey)
EndFunction

function Heap_FloatListSliceFK(Form _theActor, string _theHeapKey, float[] slice, int _startIndex = 0) global
	StorageUtil.FloatListSlice(_theActor, _theHeapKey, slice, _startIndex)
EndFunction

int function Heap_FloatListResizeFK(Form _theActor, string _theHeapKey, int toLength, float _filler = 0.0) global
	return StorageUtil.FloatListResize(_theActor, _theHeapKey, toLength, _filler)
EndFunction

bool function Heap_FloatListCopyFK(Form _theActor, string _theHeapKey, float[] _copy) global
	return StorageUtil.FloatListCopy(_theActor, _theHeapKey, _copy)
EndFunction

float[] function Heap_FloatListToArrayFK(Form _theActor, string _theHeapKey) global
	return StorageUtil.FloatListToArray(_theActor, _theHeapKey)
EndFunction

int function Heap_FloatListClearPrefixFK(Form _theActor, string _prefixKey) global
	return StorageUtil.ClearObjFloatListPrefix(_theActor, _prefixKey)
EndFunction

float Function Heap_FloatListAdjustFK(Form _theActor, string _theHeapKey, int _theIndex, float _amount) global
	return StorageUtil.FloatListAdjust(_theActor, _theHeapKey, _theIndex, _amount)
EndFunction


; int
bool Function Heap_IntHasFK(Form _theActor, string _theHeapKey) global
	return StorageUtil.HasIntValue(_theActor, _theHeapKey)
EndFunction

int Function Heap_IntGetFK(Form _theActor, string _theHeapKey, int _defaultValue = 0) global
	return StorageUtil.GetIntValue(_theActor, _theHeapKey, _defaultValue)
EndFunction

int Function Heap_IntSetFK(Form _theActor, string _theHeapKey, int _value = 0) global
	return StorageUtil.SetIntValue(_theActor, _theHeapKey, _value)
EndFunction

bool Function Heap_IntUnsetFK(Form _theActor, string _theHeapKey) global
	return StorageUtil.UnsetIntValue(_theActor, _theHeapKey)
EndFunction

int Function Heap_IntPluckFK(Form _theActor, string _theHeapKey, int _defaultValue = 0) global
	return StorageUtil.PluckIntValue(_theActor, _theHeapKey, _defaultValue)
EndFunction

int Function Heap_IntAdjustFK(Form _theActor, string _theHeapKey, int _amount) global
	return StorageUtil.AdjustIntValue(_theActor, _theHeapKey, _amount)
EndFunction


; int[]
int function Heap_IntListAddFK(Form _theActor, string _theHeapKey, int _value, bool _allowDuplicate = true) global
	return StorageUtil.IntListAdd(_theActor, _theHeapKey, _value, _allowDuplicate)
EndFunction

int function Heap_IntListGetFK(Form _theActor, string _theHeapKey, int _index) global
	return StorageUtil.IntListGet(_theActor, _theHeapKey, _index)
EndFunction

int function Heap_IntListSetFK(Form _theActor, string _theHeapKey, int _index, int _value) global
	return StorageUtil.IntListSet(_theActor, _theHeapKey, _index, _value)
EndFunction

int function Heap_IntListPluckFK(Form _theActor, string _theHeapKey, int _index, int _missing) global
	return StorageUtil.IntListPluck(_theActor, _theHeapKey, _index, _missing)
EndFunction

int function Heap_IntListShiftFK(Form _theActor, string _theHeapKey) global
	return StorageUtil.IntListShift(_theActor, _theHeapKey)
EndFunction

int function Heap_IntListPopFK(Form _theActor, string _theHeapKey) global
	return StorageUtil.IntListPop(_theActor, _theHeapKey)
EndFunction

bool function Heap_IntListInsertFK(Form _theActor, string _theHeapKey, int _index, int _value) global
	return StorageUtil.IntListInsert(_theActor, _theHeapKey, _index, _value)
EndFunction

int function Heap_IntListRemoveFK(Form _theActor, string _theHeapKey, int _value, bool _allInstances = false) global
	return StorageUtil.IntListRemove(_theActor, _theHeapKey, _value, _allInstances)
EndFunction

int function Heap_IntListClearFK(Form _theActor, string _theHeapKey) global
	return StorageUtil.IntListClear(_theActor, _theHeapKey)
EndFunction

bool function Heap_IntListRemoveAtFK(Form _theActor, string _theHeapKey, int _index) global
	return StorageUtil.IntListRemoveAt(_theActor, _theHeapKey, _index)
EndFunction

int function Heap_IntListCountFK(Form _theActor, string _theHeapKey) global
	return StorageUtil.IntListCount(_theActor, _theHeapKey)
EndFunction

int function Heap_IntListCountValueFK(Form _theActor, string _theHeapKey, int _value, bool _exclude = false) global
	return StorageUtil.IntListCountValue(_theActor, _theHeapKey, _value, _exclude)
EndFunction

int function Heap_IntListFindFK(Form _theActor, string _theHeapKey, int _value) global
	return StorageUtil.IntListFind(_theActor, _theHeapKey, _value)
EndFunction

bool function Heap_IntListHasFK(Form _theActor, string _theHeapKey, int _value) global
	return StorageUtil.IntListHas(_theActor, _theHeapKey, _value)
EndFunction

function Heap_IntListSortFK(Form _theActor, string _theHeapKey) global
	StorageUtil.IntListSort(_theActor, _theHeapKey)
EndFunction

function Heap_IntListSliceFK(Form _theActor, string _theHeapKey, int[] slice, int _startIndex = 0) global
	StorageUtil.IntListSlice(_theActor, _theHeapKey, slice, _startIndex)
EndFunction

int function Heap_IntListResizeFK(Form _theActor, string _theHeapKey, int toLength, int _filler = 0) global
	return StorageUtil.IntListResize(_theActor, _theHeapKey, toLength, _filler)
EndFunction

bool function Heap_IntListCopyFK(Form _theActor, string _theHeapKey, int[] _copy) global
	return StorageUtil.IntListCopy(_theActor, _theHeapKey, _copy)
EndFunction

int[] function Heap_IntListToArrayFK(Form _theActor, string _theHeapKey) global
	return StorageUtil.IntListToArray(_theActor, _theHeapKey)
EndFunction

int function Heap_IntListClearPrefixFK(Form _theActor, string _prefixKey) global
	return StorageUtil.ClearObjIntListPrefix(_theActor, _prefixKey)
EndFunction

int Function Heap_IntListAdjustFK(Form _theActor, string _theHeapKey, int _theIndex, int _amount) global
	return StorageUtil.IntListAdjust(_theActor, _theHeapKey, _theIndex, _amount)
EndFunction


