scriptname sl_triggersCmdLibRacemenuNIO

import sl_triggersStatics

; sltname getoverlay_slot
; sltgrup NiOverride
; sltdesc Returns: string: returns a free overlay slot
; sltargs Form: actor: target Actor
; sltargs bool: isFemale: true if a female target, false otherwise
; sltargs string: nodeName: (body, face, etc...)
; sltsamp set $nodeName resultfrom getvoverlay_slot $system.player true "Body"
function getoverlay_slot(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

	Int NumSlots
	string UsedSlot
	Int SlotToUse
	Int i = 0
    string newResult

    if ParamLengthGT(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
			bool isFemale = CmdPrimary.ResolveBool(param[2])
            string node = CmdPrimary.ResolveString(param[3])
			
            If (CmdPrimary.SLT.Debug_Cmd_Functions)
			    CmdPrimary.SFD("Looking for "+ node +" free overlay slot for " + _targetActor)
            EndIf

			if (node == "Face")
				NumSlots = sl_triggersAdapterRacemenu.GetNumFaceOverlays()
			ElseIf (node == "Body")
				NumSlots = sl_triggersAdapterRacemenu.GetNumBodyOverlays()
			ElseIf (node == "Hand")
				NumSlots = sl_triggersAdapterRacemenu.GetNumHandOverlays()
			Elseif (node == "Feet")
				NumSlots = sl_triggersAdapterRacemenu.GetNumFeetOverlays()
			EndIf
			
            If (CmdPrimary.SLT.Debug_Cmd_Functions)
			    CmdPrimary.SFD("Number of " + node + " slot for "  + _targetActor + "  : " + NumSlots )
            EndIf

            i = NumSlots

            while (i > 0)

                string nodeName = node + " [ovl" + i + "]"
                UsedSlot = sl_triggersAdapterRacemenu.GetNodeOverrideString(_targetActor, true, nodeName, 9, 0)
                
                If (CmdPrimary.SLT.Debug_Cmd_Functions)
                    CmdPrimary.SFD("Slot N : " + i + " has overlay " + UsedSlot)
                EndIf
                
                if (UsedSlot == "" || UsedSlot == "actors\\character\\overlays\\default.dds")
                    SlotToUse = i
                endif
                
                i -= 1
            endwhile
			
			string nodeName2 = node + " [ovl" + SlotToUse + "]"

            If (CmdPrimary.SLT.Debug_Cmd_Functions)
                CmdPrimary.SFD("free node for " + _targetActor + " is " + nodeName2)
            EndIf
									
			newResult = nodeName2
        endif
    endif

    CmdPrimary.MostRecentStringResult = newResult

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname param_overlay
; sltgrup NiOverride
; sltdesc Adds a tattoo overlay to the node with the given transparency
; sltargs Form: actor: target Actor
; sltargs bool: isFemale: true if a female target, false otherwise
; sltargs string: nodeName: (body, face, etc...)
; sltargs string: tattoo
; sltargs float: transparency
; sltsamp param_overlay $system.player true $nodeName $tattooName 1.0
function param_overlay(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthGT(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
			bool isFemale = CmdPrimary.ResolveBool(param[2])
            string nodeName = CmdPrimary.ResolveString(param[3])
			string tattoo = CmdPrimary.ResolveString(param[4])
			float transparency = CmdPrimary.ResolveFloat(param[5])
			
            If (CmdPrimary.SLT.Debug_Cmd_Functions)
			    CmdPrimary.SFD("configuring : " + tattoo + " on " + nodeName + " for " + _targetActor)
            EndIf
			
			sl_triggersAdapterRacemenu.AddNodeOverrideString(_targetActor, isFemale, nodeName, 9, 0, tattoo, true)
			sl_triggersAdapterRacemenu.AddNodeOverrideFloat(_targetActor, isFemale, nodeName, 8, 0, transparency, true)
			sl_triggersAdapterRacemenu.AddNodeOverrideInt(_targetActor, isFemale, nodeName, 7, 0, 0x00000000, true)
        endif
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname changeoverlay_transparency
; sltgrup NiOverride
; sltdesc Modifies the transparency of a given overlay
; sltargs Form: actor: target Actor
; sltargs bool: isFemale: true if a female target, false otherwise
; sltargs string: nodeName: (body, face, etc...)
; sltargs float: transparency
; sltsamp changeoverlay_transparency $system.player true $nodeName 1.0
function changeoverlay_transparency(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    string newResult

    if ParamLengthGT(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
			bool isFemale = CmdPrimary.ResolveBool(param[2])
            string nodeName = CmdPrimary.ResolveString(param[3])
			float transparency = CmdPrimary.ResolveFloat(param[4])

            If (CmdPrimary.SLT.Debug_Cmd_Functions)
                CmdPrimary.SFD("Changing "+ nodeName +" overlay transparency for " + _targetActor)
            EndIf
	
			sl_triggersAdapterRacemenu.AddNodeOverrideFloat(_targetActor, true, nodeName, 9, 0, transparency, true)
								
			newResult = sl_triggersAdapterRacemenu.ApplyNodeOverrides(_targetActor)
        endif
    endif

    CmdPrimary.MostRecentStringResult = newResult

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname remove_overlay
; sltgrup NiOverride
; sltdesc Removes the overlay indicated by nodeName
; sltargs Form: actor: target Actor
; sltargs bool: isFemale: true if a female target, false otherwise
; sltargs string: nodeName: (body, face, etc...)
; sltsamp remove_overlay $system.player true $nodeName
function remove_overlay(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    string newResult

    if ParamLengthGT(CmdPrimary, param.Length, 2)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
			bool isFemale = CmdPrimary.ResolveBool(param[2])
            string nodeName = CmdPrimary.ResolveString(param[3])

            If (CmdPrimary.SLT.Debug_Cmd_Functions)
                CmdPrimary.SFD("Removing "+ nodeName +" overlay for " + _targetActor)
            EndIf
									
			newResult = sl_triggersAdapterRacemenu.RemoveAllNodeNameOverrides(_targetActor, isFemale, nodeName)
        endif
    endif

    CmdPrimary.MostRecentStringResult = newResult

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname apply_overlay
; sltgrup NiOverride
; sltdesc Tells NIO to apply pending changes. Not typically required.
; sltargs Form: actor: target Actor
; sltsamp apply_overlay $system.player
function apply_overlay(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    string newResult

    if ParamLengthGT(CmdPrimary, param.Length, 1)
        Actor _targetActor = CmdPrimary.ResolveActor(param[1])
        if _targetActor
			newResult = sl_triggersAdapterRacemenu.AddOverlays(_targetActor)
        endif
    endif

    CmdPrimary.MostRecentStringResult = newResult

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname nio_hasnodeoverride
; sltgrup NiOverride
; sltdesc Returns: bool: true if the target has the node override; false otherwise
; sltargs Form: target of function (e.g. $system.player)
; sltargs bool: isFemale: true if a female target, false otherwise
; sltargs string: nodeName: (body, face, etc...)
; sltargs int: _key: NIO key
; sltargs int: index: NIO index
function nio_hasnodeoverride(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 6)
        ObjectReference ref = CmdPrimary.ResolveForm(param[1]) as ObjectReference
        bool isFemale = CmdPrimary.ResolveBool(param[2])
        string node = CmdPrimary.ResolveString(param[3])
        int _key = CmdPrimary.ResolveInt(param[4])
        int index = CmdPrimary.ResolveInt(param[5])
        CmdPrimary.MostRecentBoolResult = sl_triggersAdapterRacemenu.HasNodeOverride(ref, isFemale, node, _key, index)
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction


; sltname nio_getnodeoverride_float
; sltgrup NiOverride
; sltdesc Returns: float: the float override for the node on the target
; sltargs Form: ref: target of function (e.g. $system.player)
; sltargs bool: isFemale: true if a female target, false otherwise
; sltargs string: node: NIO node you are working with
; sltargs int: _key: NIO key
; sltargs int: index: NIO index
function nio_getnodeoverride_float(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 6)
        ObjectReference ref = CmdPrimary.ResolveForm(param[1]) as ObjectReference
        bool isFemale = CmdPrimary.ResolveBool(param[2])
        string node = CmdPrimary.ResolveString(param[3])
        int _key = CmdPrimary.ResolveInt(param[4])
        int index = CmdPrimary.ResolveInt(param[5])
        CmdPrimary.MostRecentFloatResult = sl_triggersAdapterRacemenu.GetNodeOverrideFloat(ref, isFemale, node, _key, index)
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname nio_getnodeoverride_int
; sltgrup NiOverride
; sltdesc Returns: int: the int override for the node on the target
; sltargs Form: ref: target of function (e.g. $system.player)
; sltargs bool: isFemale: true if a female target, false otherwise
; sltargs string: node: NIO node you are working with
; sltargs int: _key: NIO key
; sltargs int: index: NIO index
function nio_getnodeoverride_int(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 6)
        ObjectReference ref = CmdPrimary.ResolveForm(param[1]) as ObjectReference
        bool isFemale = CmdPrimary.ResolveBool(param[2])
        string node = CmdPrimary.ResolveString(param[3])
        int _key = CmdPrimary.ResolveInt(param[4])
        int index = CmdPrimary.ResolveInt(param[5])
        CmdPrimary.MostRecentIntResult = sl_triggersAdapterRacemenu.GetNodeOverrideInt(ref, isFemale, node, _key, index)
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname nio_getnodeoverride_bool
; sltgrup NiOverride
; sltdesc Returns: bool: the bool override for the node on the target
; sltargs Form: ref: target of function (e.g. $system.player)
; sltargs bool: isFemale: true if a female target, false otherwise
; sltargs string: node: NIO node you are working with
; sltargs int: _key: NIO key
; sltargs int: index: NIO index
function nio_getnodeoverride_bool(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 6)
        ObjectReference ref = CmdPrimary.ResolveForm(param[1]) as ObjectReference
        bool isFemale = CmdPrimary.ResolveBool(param[2])
        string node = CmdPrimary.ResolveString(param[3])
        int _key = CmdPrimary.ResolveInt(param[4])
        int index = CmdPrimary.ResolveInt(param[5])
        CmdPrimary.MostRecentBoolResult = sl_triggersAdapterRacemenu.GetNodeOverrideBool(ref, isFemale, node, _key, index)
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname nio_getnodeoverride_string
; sltgrup NiOverride
; sltdesc Returns: string: the string override for the node on the target
; sltargs Form: ref: target of function (e.g. $system.player)
; sltargs bool: isFemale: true if a female target, false otherwise
; sltargs string: node: NIO node you are working with
; sltargs int: _key: NIO key
; sltargs int: index: NIO index
function nio_getnodeoverride_string(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 6)
        ObjectReference ref = CmdPrimary.ResolveForm(param[1]) as ObjectReference
        bool isFemale = CmdPrimary.ResolveBool(param[2])
        string node = CmdPrimary.ResolveString(param[3])
        int _key = CmdPrimary.ResolveInt(param[4])
        int index = CmdPrimary.ResolveInt(param[5])
        CmdPrimary.MostRecentStringResult = sl_triggersAdapterRacemenu.GetNodeOverrideString(ref, isFemale, node, _key, index)
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname nio_getnodeoverride_textureset
; sltgrup NiOverride
; sltdesc Returns: Form: the TextureSet override for the node on the target
; sltargs Form: ref: target of function (e.g. $system.player)
; sltargs bool: isFemale: true if a female target, false otherwise
; sltargs string: node: NIO node you are working with
; sltargs int: _key: NIO key
; sltargs int: index: NIO index
function nio_getnodeoverride_textureset(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 6)
        ObjectReference ref = CmdPrimary.ResolveForm(param[1]) as ObjectReference
        bool isFemale = CmdPrimary.ResolveBool(param[2])
        string node = CmdPrimary.ResolveString(param[3])
        int _key = CmdPrimary.ResolveInt(param[4])
        int index = CmdPrimary.ResolveInt(param[5])
        CmdPrimary.MostRecentFormResult = sl_triggersAdapterRacemenu.GetNodeOverrideTextureSet(ref, isFemale, node, _key, index)
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction


; sltname nio_addnodeoverride_float
; sltgrup NiOverride
; sltdesc Calls NiOveride.AddNodeOverride for float
; sltargs Form: ref: target of function (e.g. $system.player)
; sltargs bool: isFemale: true if a female target, false otherwise
; sltargs string: node: NIO node you are working with
; sltargs int: _key: NIO key
; sltargs int: index: NIO index
; sltargs float: value: value to apply
; sltargs bool: persist: persist the override?
function nio_addnodeoverride_float(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 8)
        ObjectReference ref = CmdPrimary.ResolveForm(param[1]) as ObjectReference
        bool isFemale = CmdPrimary.ResolveBool(param[2])
        string node = CmdPrimary.ResolveString(param[3])
        int _key = CmdPrimary.ResolveInt(param[4])
        int index = CmdPrimary.ResolveInt(param[5])
        float value = CmdPrimary.ResolveFloat(param[6])
        bool persist = CmdPrimary.ResolveBool(param[7])
        sl_triggersAdapterRacemenu.AddNodeOverrideFloat(ref, isFemale, node, _key, index, value, persist)
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname nio_addnodeoverride_int
; sltgrup NiOverride
; sltdesc Calls NiOveride.AddNodeOverride for int
; sltargs Form: ref: target of function (e.g. $system.player)
; sltargs bool: isFemale: true if a female target, false otherwise
; sltargs string: node: NIO node you are working with
; sltargs int: _key: NIO key
; sltargs int: index: NIO index
; sltargs int: value: value to apply
; sltargs bool: persist: persist the override?
function nio_addnodeoverride_int(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 8)
        ObjectReference ref = CmdPrimary.ResolveForm(param[1]) as ObjectReference
        bool isFemale = CmdPrimary.ResolveBool(param[2])
        string node = CmdPrimary.ResolveString(param[3])
        int _key = CmdPrimary.ResolveInt(param[4])
        int index = CmdPrimary.ResolveInt(param[5])
        int value = CmdPrimary.ResolveInt(param[6])
        bool persist = CmdPrimary.ResolveBool(param[7])
        sl_triggersAdapterRacemenu.AddNodeOverrideInt(ref, isFemale, node, _key, index, value, persist)
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname nio_addnodeoverride_bool
; sltgrup NiOverride
; sltdesc Calls NiOveride.AddNodeOverride for bool
; sltargs Form: ref: target of function (e.g. $system.player)
; sltargs bool: isFemale: true if a female target, false otherwise
; sltargs string: node: NIO node you are working with
; sltargs int: _key: NIO key
; sltargs int: index: NIO index
; sltargs bool: value: value to apply
; sltargs bool: persist: persist the override?
function nio_addnodeoverride_bool(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 8)
        ObjectReference ref = CmdPrimary.ResolveForm(param[1]) as ObjectReference
        bool isFemale = CmdPrimary.ResolveBool(param[2])
        string node = CmdPrimary.ResolveString(param[3])
        int _key = CmdPrimary.ResolveInt(param[4])
        int index = CmdPrimary.ResolveInt(param[5])
        bool value = CmdPrimary.ResolveBool(param[6])
        bool persist = CmdPrimary.ResolveBool(param[7])
        sl_triggersAdapterRacemenu.AddNodeOverrideBool(ref, isFemale, node, _key, index, value, persist)
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname nio_addnodeoverride_string
; sltgrup NiOverride
; sltdesc Calls NiOveride.AddNodeOverride for string
; sltargs Form: ref: target of function (e.g. $system.player)
; sltargs bool: isFemale: true if a female target, false otherwise
; sltargs string: node: NIO node you are working with
; sltargs int: _key: NIO key
; sltargs int: index: NIO index
; sltargs string: value: value to apply
; sltargs bool: persist: persist the override?
function nio_addnodeoverride_string(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 8)
        ObjectReference ref = CmdPrimary.ResolveForm(param[1]) as ObjectReference
        bool isFemale = CmdPrimary.ResolveBool(param[2])
        string node = CmdPrimary.ResolveString(param[3])
        int _key = CmdPrimary.ResolveInt(param[4])
        int index = CmdPrimary.ResolveInt(param[5])
        string value = CmdPrimary.ResolveString(param[6])
        bool persist = CmdPrimary.ResolveBool(param[7])
        sl_triggersAdapterRacemenu.AddNodeOverrideString(ref, isFemale, node, _key, index, value, persist)
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname nio_addnodeoverride_textureset
; sltgrup NiOverride
; sltdesc Calls NiOveride.AddNodeOverride for TextureSet
; sltargs Form: ref: target of function (e.g. $system.player)
; sltargs bool: isFemale: true if a female target, false otherwise
; sltargs string: node: NIO node you are working with
; sltargs int: _key: NIO key
; sltargs int: index: NIO index
; sltargs Form: value: TextureSet value to apply
; sltargs bool: persist: persist the override?
function nio_addnodeoverride_textureset(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 8)
        ObjectReference ref = CmdPrimary.ResolveForm(param[1]) as ObjectReference
        bool isFemale = CmdPrimary.ResolveBool(param[2])
        string node = CmdPrimary.ResolveString(param[3])
        int _key = CmdPrimary.ResolveInt(param[4])
        int index = CmdPrimary.ResolveInt(param[5])
        TextureSet value = CmdPrimary.ResolveForm(param[6]) as TextureSet
        bool persist = CmdPrimary.ResolveBool(param[7])
        sl_triggersAdapterRacemenu.AddNodeOverrideTextureSet(ref, isFemale, node, _key, index, value, persist)
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction


; sltname nio_hasbodymorph
; sltgrup NiOverride
; sltdesc Returns: bool: true if the target has the body morph; false otherwise
; sltargs Form: ref: target of function (e.g. $system.player)
; sltargs string: morphName: name of the morph you are working with
; sltargs string: keyName: NIO key you are working with
function nio_hasbodymorph(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 4)
        ObjectReference ref = CmdPrimary.ResolveForm(param[1]) as ObjectReference
        string morphName = CmdPrimary.ResolveString(param[2])
        string keyName = CmdPrimary.ResolveString(param[3])
        CmdPrimary.MostRecentBoolResult = sl_triggersAdapterRacemenu.HasBodyMorph(ref, morphName, keyName)
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname nio_setbodymorph
; sltgrup NiOverride
; sltdesc Sets the bodymorph of the target
; sltargs Form: ref: target of function (e.g. $system.player)
; sltargs string: morphName: name of the morph you are working with
; sltargs string: keyName: NIO key you are working with
; sltargs float: value: value to apply
function nio_setbodymorph(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 5)
        ObjectReference ref = CmdPrimary.ResolveForm(param[1]) as ObjectReference
        string morphName = CmdPrimary.ResolveString(param[2])
        string keyName = CmdPrimary.ResolveString(param[3])
        float value = CmdPrimary.ResolveFloat(param[4])
        sl_triggersAdapterRacemenu.SetBodyMorph(ref, morphName, keyName, value)
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname nio_getbodymorph
; sltgrup NiOverride
; sltdesc Returns: float: the current morph value for the target
; sltargs Form: ref: target of function (e.g. $system.player)
; sltargs string: morphName: name of the morph you are working with
; sltargs string: keyName: NIO key you are working with
function nio_getbodymorph(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 4)
        ObjectReference ref = CmdPrimary.ResolveForm(param[1]) as ObjectReference
        string morphName = CmdPrimary.ResolveString(param[2])
        string keyName = CmdPrimary.ResolveString(param[3])
        CmdPrimary.MostRecentFloatResult = sl_triggersAdapterRacemenu.GetBodyMorph(ref, morphName, keyName)
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname nio_clearbodymorph
; sltgrup NiOverride
; sltdesc Clears the morph value of the target
; sltargs Form: ref: target of function (e.g. $system.player)
; sltargs string: morphName: name of the morph you are working with
; sltargs string: keyName: NIO key you are working with
function nio_clearbodymorph(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 4)
        ObjectReference ref = CmdPrimary.ResolveForm(param[1]) as ObjectReference
        string morphName = CmdPrimary.ResolveString(param[2])
        string keyName = CmdPrimary.ResolveString(param[3])
        sl_triggersAdapterRacemenu.ClearBodyMorph(ref, morphName, keyName)
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname nio_updatemodelweight
; sltgrup NiOverride
; sltdesc Updates the weight data post morph value. Only to be used on actors who have morph values set.
; sltargs Form: ref: target of function (e.g. $system.player)
function nio_updatemodelweight(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        ObjectReference ref = CmdPrimary.ResolveForm(param[1]) as ObjectReference
        sl_triggersAdapterRacemenu.UpdateModelWeight(ref)
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname nio_get_morphnames
; sltgrup NiOverride
; sltdesc Returns: string[]: a list of the morphNames applied to the target actor.
; sltargs Form: ref: target of function (e.g. $system.player)
function nio_get_morphnames(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 2)
        ObjectReference ref = CmdPrimary.ResolveForm(param[1]) as ObjectReference
        CmdPrimary.MostRecentListStringResult = sl_triggersAdapterRacemenu.GetMorphNames(ref)
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction

; sltname nio_get_morphkeys
; sltgrup NiOverride
; sltdesc Returns: string[]: a list of the keys applied to the target actor for the specified morph.
; sltargs Form: ref: target of function (e.g. $system.player)
; sltargs string: morphName: name of the morph you are working with
function nio_get_morphkeys(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 3)
        ObjectReference ref = CmdPrimary.ResolveForm(param[1]) as ObjectReference
        string morphName = CmdPrimary.ResolveString(param[2])
        CmdPrimary.MostRecentListStringResult = sl_triggersAdapterRacemenu.GetMorphKeys(ref, morphName)
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction
