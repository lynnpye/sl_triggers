Scriptname sl_TriggersCmd extends sl_TriggersCmdBase

import sl_triggersStatics
import sl_triggersHeap
import sl_triggersFile


; Properties
int			Property lastKey Auto Hidden
Actor		Property iterActor Auto Hidden

; internal variables
int			cmdIdx 
int			cmdNum 
string		cmdName

int[]		gotoIdx 
string[]	gotoLabels 
int			gotoCnt 
bool		deferredInitNeeded
bool		clusterDispelSent

ActiveMagicEffect[]		supportCmds

int			expectedSupportCmds
int			supportCmdsCheckedIn


String Function _slt_getActualInstanceId()
	return InstanceId
EndFunction

Event OnEffectStart(Actor akTarget, Actor akCaster)
	deferredInitNeeded = true
    cmdIdx = 0
    stack = new string[4]
    
    gotoCnt = 0
    gotoIdx = new int[127]
    gotoLabels = new string[127]
	
	instanceId = Heap_DequeueInstanceIdF(akCaster)
   	cmdName = Heap_StringGetFK(akCaster, MakeInstanceKey(instanceId, "cmd"))
	
	SLTOnEffectStart(akCaster)
	SafeRegisterForModEvent_AME(self, _slt_GetClusterBeginExecutionEvent(), "OnSLTAMEClusterBeginExecutionEvent")
	
	QueueUpdateLoop(0.1)
EndEvent

Event OnUpdate()
	; when we start receiving these, we are assuming we are ready
	If !Self
		Return
	EndIf
	
	float currentRealTime = Utility.GetCurrentRealTime()
	
	if deferredInitNeeded
		deferredInitNeeded = false
		
		; retrieve the formSpells if present
		supportCmds = new ActiveMagicEffect[128] ; implicit 128 extension limit but I mean c'mon
		
		expectedSupportCmds = 0
		if Heap_FormListCountFK(CmdTargetActor, MakeInstanceKey(InstanceId, "spellForms"))
			while Heap_FormListCountFK(CmdTargetActor, MakeInstanceKey(InstanceId, "spellForms")) > 0
				Spell spellForm = Heap_FormListShiftFK(CmdTargetActor, MakeInstanceKey(instanceId, "spellForms")) as Spell
				
				; only if there was actually a Spell from the extension
				if spellForm
					expectedSupportCmds += 1
					spellForm.RemoteCast(CmdTargetActor, CmdTargetActor, CmdTargetActor)
				endif
			endwhile
		endif

        SendClusterExecute()
	endif
EndEvent

Event OnSLTAMEClusterBeginExecutionEvent(string eventName, string strArg, float numArg, Form sender)
    UnregisterForModEvent(_slt_GetClusterBeginExecutionEvent())

    if !self
        return
    endif

    int count = 25
    while supportCmdsCheckedIn < expectedSupportCmds && count > 0
        Utility.Wait(0.1)
        count -= 1
    endwhile
    
    if supportCmdsCheckedIn < expectedSupportCmds
        SendClusterDispel()
        return
    endif

	; sort supportCmds if necessary
	if supportCmdsCheckedIn > 0 && supportCmds
		ActiveMagicEffect[] tmpBuffer = supportCmds
		
		sl_triggersCmdBase c_j
		sl_triggersCmdBase c_i
		ActiveMagicEffect c_swap
		int j = 0
		while j < supportCmdsCheckedIn
			c_j = tmpBuffer[j] as sl_triggersCmdBase
			int i = j + 1
			while i < supportCmdsCheckedIn
				c_i = tmpBuffer[i] as sl_triggersCmdBase
				if c_i._slt_getActualPriority() < c_j._slt_getActualPriority()
					c_swap = tmpBuffer[j]
					tmpBuffer[j] = tmpBuffer[i]
					tmpBuffer[i] = c_swap
				endif
			
				i += 1
			endwhile
		
			j += 1
		endwhile
		
		supportCmds = tmpBuffer
	endif
    
    exec()
	
	Heap_ClearPrefixF(CmdTargetActor, MakeInstanceKeyPrefix(instanceId))
    
	SendClusterDispel()
EndEvent

Event OnKeyDown(Int keyCode)
    lastKey = keyCode
    ;MiscUtil.PrintConsole("KeyDown: " + lastKey)
EndEvent

Function SendClusterDispel()
	if clusterDispelSent
		return
	endif
	clusterDispelSent = true
	SendModEvent(_slt_GetClusterEvent(), "DISPEL")
EndFunction

Function SendClusterExecute() ; really just to me
	SendModEvent(_slt_GetClusterBeginExecutionEvent())
EndFunction

Function SupportCheckin(sl_triggersCmdBase supportCmd)
	supportCmds[supportCmdsCheckedIn] = supportCmd
	supportCmdsCheckedIn += 1
EndFunction


Function _addGoto(int _idx, string _label)
    int idx
    
    idx = 0
    while idx < gotoCnt
        if gotoLabels[idx] == _label
            return 
        endIf    
        idx += 1
    endWhile
    
    gotoIdx[gotoCnt] = _idx
    gotoLabels[gotoCnt] = _label
    gotoCnt += 1
EndFunction

Int Function _findGoto(string _label, int _cmdIdx, string _cmdtype)
    int idx
    
    idx = gotoLabels.find(_label)
    if idx >= 0
        return gotoIdx[idx]
    endIf
    
    string[] cmdLine1
    string   code
    
    idx = _cmdIdx + 1
    while idx < cmdNum
        cmdLine1 = Heap_StringListToArrayX(CmdTargetActor, GetInstanceId(), "OperationList[" + idx + "]")
        ;cmdLine1 = JsonUtil.PathStringElements(cmdName, ".cmd[" + idx + "]")
        if cmdLine1.Length
            if (_cmdtype == "json" && cmdLine1[0] == ":") || (_cmdtype == "ini" && cmdLine1.Length == 1 && StringUtil.GetNthChar(cmdLine1[0], 0) == "[" && StringUtil.GetNthChar(cmdLine1[0], StringUtil.GetLength(cmdLine1[0]) - 1) == "]")
                if _cmdtype == "json"
                    _addGoto(idx, cmdLine1[1])
                elseif _cmdtype == "ini"
                    _addGoto(idx, StringUtil.Substring(cmdLine1[0], 1, StringUtil.GetLength(cmdLine1[0]) - 2))
                endif
            endIf
        endIf
        idx += 1
    endWhile

    idx = gotoLabels.find(_label)
    if idx >= 0
        return gotoIdx[idx]
    endIf
    return cmdNum
EndFunction

string Function ParseCommandFile()
    string _myCmdName = cmdName
    string _last = StringUtil.Substring(_myCmdName, StringUtil.GetLength(_myCmdName) - 4)
    string[] cmdLine
    if _last == "json"
        _myCmdName = CommandsFolder() + _myCmdName
        cmdNum = JsonUtil.PathCount(_myCmdName, ".cmd")
        cmdIdx = 0
        while cmdIdx < cmdNum
            cmdLine = JsonUtil.PathStringElements(_myCmdName, ".cmd[" + cmdIdx + "]")
            if cmdLine.Length
                Heap_IntAdjustX(CmdTargetActor, GetInstanceId(), "OperationList", 1)
                int idx = 0
                while idx < cmdLine.Length
                    Heap_StringListAddX(CmdTargetActor, GetInstanceId(), "OperationList[" + cmdIdx + "]", cmdLine[idx])
                    idx += 1
                endwhile
            endif
            cmdIdx += 1
        endwhile
        return "json"
    elseif _last == ".ini"
        string cmdpath = FullCommandsFolder() + _myCmdName
        string cmdstring = MiscUtil.ReadFromFile(cmdpath)
        string[] cmdlines = sl_triggers_internal.SafeSplitLines(cmdstring)

        cmdNum = cmdlines.Length
        cmdIdx = 0
        while cmdIdx < cmdNum
            cmdLine = sl_triggers_internal.SafeTokenize(cmdlines[cmdIdx])
            if cmdLine.Length
                Heap_IntAdjustX(CmdTargetActor, GetInstanceId(), "OperationList", 1)
                int idx = 0
                while idx < cmdLine.Length
                    Heap_StringListAddX(CmdTargetActor, GetInstanceId(), "OperationList[" + cmdIdx + "]", cmdLine[idx])
                    idx += 1
                endwhile
            endif
            cmdIdx += 1
        endwhile
        return "ini"
    endif
EndFunction

;/
opens the command file, loops through the commands, and runs them
/;
bool EXEC_GUARDIAN
string Function exec()
    if EXEC_GUARDIAN
        return ""
    endif
    EXEC_GUARDIAN = true
    string[] cmdLine
    string   code
    string   p1
    string   p2
    string   po
    bool     ifTrue

    Heap_IntSetX(CmdTargetActor, GetInstanceId(), "OperationList", 0)

    string cmdtype = ParseCommandFile()

    cmdNum = Heap_IntGetX(CmdTargetActor, GetInstanceId(), "OperationList")
    cmdidx = 0
    
    while cmdidx < cmdNum
        cmdLine = Heap_StringListToArrayX(CmdTargetActor, GetInstanceId(), "OperationList[" + cmdidx + "]")

        if cmdLine.Length
            code = resolve(cmdLine[0])

            if (cmdtype == "json" && code == ":") || (cmdtype == "ini" && cmdLine.Length == 1 && StringUtil.GetNthChar(cmdLine[0], 0) == "[" && StringUtil.GetNthChar(cmdLine[0], StringUtil.GetLength(cmdLine[0]) - 1) == "]")
                if cmdtype == "json"
                    _addGoto(cmdIdx, cmdLine[1])
                elseif cmdtype == "ini"
                    _addGoto(cmdIdx, StringUtil.Substring(cmdLine[0], 1, StringUtil.GetLength(cmdLine[0]) - 2))
                endif
                cmdIdx += 1
            elseIf code == "goto"
                cmdIdx = _findGoto(cmdLine[1], cmdIdx, cmdtype)
                cmdIdx += 1
            elseIf code == "if"
                ; ["if", "$$", "=", "0", "end"],
                p1 = resolve(cmdLine[1])
                p2 = resolve(cmdLine[3])
                po = cmdLine[2]
                ifTrue = resolveCond(p1, p2, po)
                if ifTrue
                    cmdIdx = _findGoto(cmdLine[4], cmdIdx, cmdtype)
                endIf
                cmdIdx += 1
            elseIf code == "return"
                return ""
            else
				ActualOper(cmdLine, code)
                cmdIdx += 1
            endIf
        endif
    endwhile
    
    return ""
EndFunction

string Function ActualResolve(string _code)\
	; try negative priority resolve
	; try our resolve
	; try positive priority resolve
	if supportCmdsCheckedIn < 1
		return self.CustomResolve(_code)
	endif
	
	string _value
	bool readyForCore = true
	int i = 0
	sl_triggersCmdBase currCmd
	while i < supportCmdsCheckedIn && !_value
		currCmd = supportCmds[i] as sl_triggersCmdBase
		
		if currCmd._slt_getActualPriority() < 0
			_value = currCmd.CustomResolve(_code)
		elseif readyForCore
			readyForCore = false
			_value = self.CustomResolve(_code)
            i -= 1
        elseif currCmd._slt_getActualPriority() > 0
			_value = currCmd.CustomResolve(_code)
		endif
	
		i += 1
	endwhile

    if _value
        return _value
    endif
	
	return _code
EndFunction

string Function CustomResolve(string _code)
	int varindex = -1
    if StringUtil.getNthChar(_code, 0) == "$"
        if _code == "$$"
            return stack[0]
        else
			varindex = isVarString(_code)
			if varindex >= 0
				return vars_get(varindex)
			endif
			
			varindex = isVarStringG(_code)
			if varindex >= 0
				return SLT.globalvars_get(varindex)
			endif
        endIf
    endIf
    return ""    
EndFunction

Actor Function ActualResolveActor(string _code)
	; try negative priority resolve
	; try our resolve
	; try positive priority resolve
	Actor _value
	
	if supportCmdsCheckedIn < 1
		_value = self.CustomResolveActor(_code)
	else
		bool readyForCore = true
		int i = 0
		sl_triggersCmdBase currCmd
		while i < supportCmdsCheckedIn && !_value
			currCmd = supportCmds[i] as sl_triggersCmdBase
			
			if currCmd._slt_getActualPriority() < 0
				_value = currCmd.CustomResolveActor(_code)
			elseif readyForCore
				readyForCore = false
				_value = self.CustomResolveActor(_code)
                i -= 1
            elseif currCmd._slt_getActualPriority() > 0
				_value = currCmd.CustomResolveActor(_code)
			endif
		
			i += 1
		endwhile
	endif
	
	if _value
		return _value
	endif
	return CmdTargetActor
EndFunction

Actor Function CustomResolveActor(string _code)
    if _code == "$self"
        return CmdTargetActor
    elseIf _code == "$player"
        return PlayerRef
    elseIf _code == "$actor"
        return iterActor
    endIf
    return none
EndFunction

bool Function ActualResolveCond(string _p1, string _p2, string _oper)
	; try negative priority resolve
	; try our resolve
	; try positive priority resolve
	bool _value
	
	if supportCmdsCheckedIn < 1
		_value = self.CustomResolveCond(_p1, _p2, _oper)
	else
		bool readyForCore = true
		int i = 0
		sl_triggersCmdBase currCmd
		while i < supportCmdsCheckedIn && !_value
			currCmd = supportCmds[i] as sl_triggersCmdBase
			
			if currCmd._slt_getActualPriority() < 0
				_value = currCmd.CustomResolveCond(_p1, _p2, _oper)
			elseif readyForCore
				readyForCore = false
				_value = self.CustomResolveCond(_p1, _p2, _oper)
                i -= 1
            elseif currCmd._slt_getActualPriority() > 0
				_value = currCmd.CustomResolveCond(_p1, _p2, _oper)
			endif
		
			i += 1
		endwhile
	endif
	
	return _value
EndFunction

bool Function CustomResolveCond(string _p1, string _p2, string _oper)
    if _oper == "="
        if (_p1 as float) == (_p2 as float)
            return true
        endif
    elseIf _oper == "!="
        if (_p1 as float) != (_p2 as float)
            return true
        endif
    elseIf _oper == ">"
        if (_p1 as float) > (_p2 as float)
            return true
        endif
    elseIf _oper == ">="
        if (_p1 as float) >= (_p2 as float)
            return true
        endif
    elseIf _oper == "<"
        if (_p1 as float) < (_p2 as float)
            return true
        endif
    elseIf _oper == "<="
        if (_p1 as float) <= (_p2 as float)
            return true
        endif
    elseIf _oper == "&="
        if _p1 == _p2
            return true
        endif
    elseIf _oper == "&!="
        if _p1 != _p2
            return true
        endif
    endif
    return false
endFunction

Function ActualOper(string[] param, string code)
	; try negative priority resolve
	; try our resolve
	; try positive priority resolve
	bool cmdSuccess = false
	
	if supportCmdsCheckedIn < 1
		cmdSuccess = self._slt_oper_driver(param, code)
	else
		bool readyForCore = true
		int i = 0
		sl_triggersCmdBase currCmd
		while i < supportCmdsCheckedIn && !cmdSuccess
			currCmd = supportCmds[i] as sl_triggersCmdBase

			if currCmd._slt_getActualPriority() < 0
				cmdSuccess = currCmd._slt_oper_driver(param, code)
            elseif readyForCore
                readyForCore = false
                cmdSuccess = self._slt_oper_driver(param, code)
                i -= 1
            elseif currCmd._slt_getActualPriority() > 0
				cmdSuccess = currCmd._slt_oper_driver(param, code)
            endif
		
			i += 1
		endwhile
	endif
EndFunction

; blank empty state version
bool function oper(string[] param)
	return false
endFunction


;/
all the operations
/;
State cmd_set ; set "$1", "value"
bool function oper(string[] param)
	int varindex = isVarString(param[1])
	if varindex >= 0
		if param.length == 3
			vars_set(varindex, resolve(param[2]))
		elseif param.length == 5
			if param[3] == "+"
				float p1 = resolve(param[2]) as float
				float p2 = resolve(param[4]) as float
				vars_set(varindex, (p1 + p2) as string)
			elseIf param[3] == "-"
				vars_set(varindex, ((resolve(param[2]) as float) - (resolve(param[4]) as float)) as string)
			elseIf param[3] == "*"
				vars_set(varindex, ((resolve(param[2]) as float) * (resolve(param[4]) as float)) as string)
			elseIf param[3] == "/"
				vars_set(varindex, ((resolve(param[2]) as float) / (resolve(param[4]) as float)) as string)
			elseIf param[3] == "&"
				vars_set(varindex, resolve(param[2]) + resolve(param[4]))
			endIf
		endif
	endif
	
	varindex = isVarStringG(param[1])
	if varindex >= 0
		if param.length == 3
			SLT.globalvars_set(varindex, resolve(param[2]))
		elseif param.length == 5
			if param[3] == "+"
				float p1 = resolve(param[2]) as float
				float p2 = resolve(param[4]) as float
				SLT.globalvars_set(varindex, (p1 + p2) as string)
			elseIf param[3] == "-"
				SLT.globalvars_set(varindex, ((resolve(param[2]) as float) - (resolve(param[4]) as float)) as string)
			elseIf param[3] == "*"
				SLT.globalvars_set(varindex, ((resolve(param[2]) as float) * (resolve(param[4]) as float)) as string)
			elseIf param[3] == "/"
				SLT.globalvars_set(varindex, ((resolve(param[2]) as float) / (resolve(param[4]) as float)) as string)
			elseIf param[3] == "&"
				SLT.globalvars_set(varindex, resolve(param[2]) + resolve(param[4]))
			endIf
		endif
	endif

	return true
endFunction
EndState 

State cmd_inc ; inc "$1", "value"
bool function oper(string[] param)
    if StringUtil.getNthChar(param[1], 0) == "$"
        int idx = StringUtil.getNthChar(param[1], 1) as int
        if idx >= 0 && idx <= 9
            vars_set(idx, ((vars_get(idx) as float) + (resolve(param[2]) as float)) as string)
        else
            Debug.Notification("Bad var: " +  cmdName + "(" + cmdIdx + ")")
        endIf
    endIf

	return true
endFunction
EndState 

State cmd_cat ; cat "$1", "value"
bool function oper(string[] param)
    if StringUtil.getNthChar(param[1], 0) == "$"
        int idx = StringUtil.getNthChar(param[1], 1) as int
        if idx >= 0 && idx <= 9
            vars_set(idx, vars_get(idx) + resolve(param[2]))
        else
            Debug.Notification("Bad var: " +  cmdName + "(" + cmdIdx + ")")
        endIf
    endIf

	return true
endFunction
EndState 

State cmd_av_restore ;av_restore "$self", "actor_value", "value"
bool function oper(string[] param)
    Actor mate
    
    mate = resolveActor(param[1])
    mate.RestoreActorValue(resolve(param[2]), resolve(param[3]) as float)

	return true
endFunction
EndState 

State cmd_av_damage ;av_damage "$self", "actor_value", "value"
bool function oper(string[] param)
    Actor mate
    mate = resolveActor(param[1])
    mate.DamageActorValue(resolve(param[2]), resolve(param[3]) as float)

	return true
endFunction
EndState 

State cmd_av_mod ;av_mod "$self", "actor_value", "value"
bool function oper(string[] param)
    Actor mate
    
    mate = resolveActor(param[1])
    mate.ModActorValue(resolve(param[2]), resolve(param[3]) as float)

	return true
endFunction
EndState 

State cmd_av_set ;av_set "$self", "actor_value", "value"
bool function oper(string[] param)
    Actor mate
    
    mate = resolveActor(param[1])
    mate.SetActorValue(resolve(param[2]), resolve(param[3]) as float)

	return true
endFunction
EndState 

State cmd_av_getbase ;av_getbase "$self", "actor_value"
bool function oper(string[] param)
    Actor mate
    float val
    
    mate = resolveActor(param[1])
    val = mate.GetBaseActorValue(resolve(param[2]))
    
    stack[0] = val as string
    ;MiscUtil.PrintConsole("Return: " + stack[0])

	return true
endFunction
EndState 

State cmd_av_get ;av_get "$self", "actor_value"
bool function oper(string[] param)
    Actor mate
    float val
    
    mate = resolveActor(param[1])
    val = mate.GetActorValue(resolve(param[2]))
    
    stack[0] = val as string
    ;MiscUtil.PrintConsole("Return: " + stack[0])

	return true
endFunction
EndState 

State cmd_av_getmax ;av_getmax "$self", "actor_value"
bool function oper(string[] param)
    Actor mate
    float val
    
    mate = resolveActor(param[1])
    val = mate.GetActorValueMax(resolve(param[2]))
    
    stack[0] = val as string

	return true
endFunction
EndState 


State cmd_av_getpercent ;av_getmax "$self", "actor_value"
bool function oper(string[] param)
    Actor mate
    float val
    
    mate = resolveActor(param[1])
    val = mate.GetActorValuePercentage(resolve(param[2]))
    val = val * 100.0
    
    stack[0] = val as string

	return true
endFunction
EndState 

State cmd_spell_cast ;spell_cast "module:id", "$self"
bool function oper(string[] param)
    Spell thing
    Actor mate
    thing = getFormId(resolve(param[1])) as Spell
    if thing
        mate = resolveActor(param[2])
        thing.RemoteCast(mate, mate, mate)
    endIf

	return true
endFunction
EndState 

State cmd_spell_dcsa ;spell_dcsa "module:id", "$self"
bool function oper(string[] param)
    Spell thing
    Actor mate
    thing = getFormId(resolve(param[1])) as Spell
    if thing
        mate = resolveActor(param[2])
        mate.DoCombatSpellApply(thing, mate)
    endIf

	return true
endFunction
EndState 

State cmd_spell_dispel ;spell_dispel "module:id", "$self"
bool function oper(string[] param)
    Spell thing
    Actor mate
    thing = getFormId(resolve(param[1])) as Spell
    if thing
        mate = resolveActor(param[2])
        mate.DispelSpell(thing)
    endIf

	return true
endFunction
EndState 

State cmd_spell_add ;spell_add "module:id", "$self"
bool function oper(string[] param)
    Spell thing
    Actor mate
    thing = getFormId(resolve(param[1])) as Spell
    if thing
        mate = resolveActor(param[2])
        mate.AddSpell(thing)
    endIf

	return true
endFunction
EndState 

State cmd_spell_remove ;spell_remove "module:id", "$self"
bool function oper(string[] param)
    Spell thing
    Actor mate
    thing = getFormId(resolve(param[1])) as Spell
    if thing
        mate = resolveActor(param[2])
        mate.RemoveSpell(thing)
    endIf

	return true
endFunction
EndState 


State cmd_item_add ;item_add "$self", "module:id", "count:int", "silent:bool"
bool function oper(string[] param)
    Form thing
    Actor mate
    int count
    bool isSilent
    
    mate = resolveActor(param[1])
    thing = getFormId(resolve(param[2]))
    if thing
        count = resolve(param[3]) as int
        isSilent = resolve(param[4]) as int
        mate.AddItem(thing, count, isSilent)
    endIf

	return true
endFunction
EndState 

State cmd_item_addex ;item_add "$self", "module:id", "count:int", "silent:bool"
bool function oper(string[] param)
    Form thing
    Actor mate
    int count
    bool isSilent
    
    mate = resolveActor(param[1])
    thing = getFormId(resolve(param[2]))
    if thing
        count = resolve(param[3]) as int
        isSilent = resolve(param[4]) as int
        
        Form[] itemSlots = new Form[34]
        int index
        int slotsChecked
        int thisSlot
        
        If mate != PlayerRef
            index = 0
            slotsChecked += 0x00100000
            slotsChecked += 0x00200000
            slotsChecked += 0x80000000
            thisSlot = 0x01
            While (thisSlot < 0x80000000)
                ;MiscUtil.PrintConsole("thisSlot: " + thisSlot)
                if (Math.LogicalAnd(slotsChecked, thisSlot) != thisSlot) ;only check slots we haven't found anything equipped on already
                    Form thisArmor = mate.GetWornForm(thisSlot)
                    if (thisArmor)
                        ;MiscUtil.PrintConsole("Has:" + thisArmor + ":" + (thisArmor as Armor).GetSlotMask())
                        itemSlots[index] = thisArmor
                        index += 1
                        slotsChecked += (thisArmor as Armor).GetSlotMask() ;add all slots this item covers to our slotsChecked variable
                    else 
                        slotsChecked += thisSlot
                    endif
                endif
                thisSlot *= 2 ;double the number to move on to the next slot
            endWhile
        EndIf
        
        mate.AddItem(thing, count, isSilent)

        If mate != PlayerRef
            index = 0
            slotsChecked = 0
            slotsChecked += 0x00100000
            slotsChecked += 0x00200000
            slotsChecked += 0x80000000
            thisSlot = 0x01
            While (thisSlot < 0x80000000)
                ;MiscUtil.PrintConsole("thisSlot: " + thisSlot)
                if (Math.LogicalAnd(slotsChecked, thisSlot) != thisSlot)
                    ;MiscUtil.PrintConsole("thisSlot to remove")
                    Form thisArmor = mate.GetWornForm(thisSlot)
                    if (thisArmor)
                        ;MiscUtil.PrintConsole("thisSlot good armor")
                        If itemSlots.Find(thisArmor) < 0
                            ;MiscUtil.PrintConsole("thisSlot gone armor")
                            CmdTargetActor.UnequipItemEx(thisArmor, 0)
                        EndIf
                        slotsChecked += (thisArmor as Armor).GetSlotMask()
                        ;MiscUtil.PrintConsole("checkedSlot: " + slotsChecked)
                    else 
                        ;MiscUtil.PrintConsole("thisSlot bad armor")
                        slotsChecked += thisSlot
                    endif
                endif
                thisSlot *= 2 ;double the number to move on to the next slot
            endWhile
        EndIf
        
    endIf

	return true
endFunction
EndState 

State cmd_item_remove ;item_remove "$self", "module:id", "count:int", "silent:bool"
bool function oper(string[] param)
    Form thing
    Actor mate
    int count
    bool isSilent
    
    mate = resolveActor(param[1])
    thing = getFormId(resolve(param[2]))
    if thing
        count = resolve(param[3]) as int
        isSilent = resolve(param[4]) as int
        mate.RemoveItem(thing, count, isSilent)
    endIf

	return true
endFunction
EndState 

State cmd_item_adduse ;item_adduse "$self", "module:id", "count:int", "silent:bool"
bool function oper(string[] param)
    Form thing
    Actor mate
    int count
    bool isSilent
    
    mate = resolveActor(param[1])
    thing = getFormId(resolve(param[2]))
    if thing
        count = resolve(param[3]) as int
        isSilent = resolve(param[4]) as int
        mate.AddItem(thing, count, isSilent)
        mate.EquipItem(thing, false, isSilent)
    endIf

	return true
endFunction
EndState 


State cmd_item_equipex ;item_equipex "$self", "module:id", "slot:int", "sound:bool"
bool function oper(string[] param)
    Form thing
    Actor mate
    int slotId
    bool isSilent
    
    mate = resolveActor(param[1])
    thing = getFormId(resolve(param[2]))
    if thing
        slotId = resolve(param[3]) as int
        isSilent = resolve(param[4]) as int
        mate.EquipItemEx(thing, slotId, false, isSilent)
    endIf

	return true
endFunction
EndState 

State cmd_item_equip ;item_equipex "$self", "module:id", "noremove:int", "sound:bool"
bool function oper(string[] param)
    Form thing
    Actor mate
    int slotId
    bool isSilent
    
    mate = resolveActor(param[1])
    thing = getFormId(resolve(param[2]))
    if thing
        slotId = resolve(param[3]) as int
        isSilent = resolve(param[4]) as int
        mate.EquipItem(thing, slotId, isSilent)
    endIf

	return true
endFunction
EndState 

State cmd_item_unequipex ;item_equipex "$self", "module:id", "slot:int"
bool function oper(string[] param)
    Form thing
    Actor mate
    int slotId
    bool isSilent
    
    mate = resolveActor(param[1])
    thing = getFormId(resolve(param[2]))
    if thing
        slotId = resolve(param[3]) as int
        mate.UnEquipItemEx(thing, slotId)
    endIf

	return true
endFunction
EndState 

State cmd_item_getcount ;item_equipex "$self", "module:id"
bool function oper(string[] param)
    Form thing
    Actor mate
    int retVal

    mate = resolveActor(param[1])
    thing = getFormId(resolve(param[2]))
    if thing
        retVal = mate.GetItemCount(thing)
        stack[0] = retVal as string
    endIf

	return true
endFunction
EndState 

State cmd_msg_notify ;msg_notify "text"
bool function oper(string[] param)
    string ss
    string ssx
    int cnt
    int idx
    
    cnt = param.length
    idx = 1
    while idx < cnt
        ss = resolve(param[idx])
        ssx += ss
        idx += 1
    endWhile
    
    Debug.Notification(ssx)

	return true
endFunction
EndState 

State cmd_msg_console ;msg_console "text"
bool function oper(string[] param)
    string ss
    string ssx
    int cnt
    int idx
    
    cnt = param.length
    idx = 1
    while idx < cnt
        ss = resolve(param[idx])
        ssx += ss
        idx += 1
    endWhile

    MiscUtil.PrintConsole(ssx)

	return true
endFunction
EndState 


State cmd_rnd_list ;rnd_list "stuff1", "stuff2", ...
bool function oper(string[] param)
    string ss
    int cnt
    int idx
    
    cnt = param.length
    idx = utility.RandomInt(1, cnt - 1)
    ss = resolve(param[idx])
    stack[0] = ss
    ;MiscUtil.PrintConsole("rnd_list: " + cnt + "," + idx + ", " + ss + ", " + stack[0])

	return true
endFunction
EndState 

State cmd_rnd_int ;rnd_int "min", "max"
bool function oper(string[] param)
    string ss
    int idx
    int p1
    int p2
    
    ss = resolve(param[1])
    p1 = ss as int
    ss = resolve(param[2])
    p2 = ss as int
    
    idx = utility.RandomInt(p1, p2)
    stack[0] = idx as string
    

	return true
endFunction
EndState 

State cmd_util_wait ;util_wait "sec"
bool function oper(string[] param)
    string ss
    ss = resolve(param[1])
    Utility.wait(ss as float)

	return true
endFunction
EndState 

State cmd_util_getrndactor ;util_getrndactor "range", "option"
bool function oper(string[] param)
    string ss
    float  p1
    int    opt
    
    ss = resolve(param[1])
    p1 = ss as float
    ;0 - any, 1 - not in SL, 2 - is in SL
    ss = resolve(param[2])
    opt = ss as int
    
    Actor[] inCell = MiscUtil.ScanCellNPCs(PlayerRef, p1)
    Actor   lastFound
    Cell    cc = PlayerRef.getParentCell()
    int     idx
    int     cnt
    int     idxRnd

    iterActor = none
    cnt = inCell.Length
    if cnt < 1
        return false
    endIf
    
    idxRnd = Utility.RandomInt(0, cnt)
    idx = 0
    while idx < cnt
		Actor mate = inCell[idx]
        
		if mate && mate != PlayerRef && mate.isEnabled() && !mate.isDead() && !mate.isInCombat() && !mate.IsUnconscious() && mate.HasKeyWord(ActorTypeNPC) && mate.Is3DLoaded() && cc == mate.getParentCell()
            if idx > idxRnd
                idx = cnt + 1
            else
                lastFound = mate
            endIf
		endIf
    
        idx += 1
    endWhile
    
    iterActor = lastFound

	return true
endFunction
EndState 

State cmd_perk_addpoints ;perk_addpoints "count"
bool function oper(string[] param)
    string ss
    int    p1
    ss = resolve(param[1])
    p1 = ss as int
    Game.AddPerkPoints(p1)

	return true
endFunction
EndState 

State cmd_perk_add ;perk_add "module:id", "$self"
bool function oper(string[] param)
    Perk thing
    Actor mate
    thing = getFormId(resolve(param[1])) as Perk
    if thing
        mate = resolveActor(param[2])
        mate.AddPerk(thing)
    endIf

	return true
endFunction
EndState 

State cmd_perk_remove ;perk_remove "module:id", "$self"
bool function oper(string[] param)
    Perk thing
    Actor mate
    thing = getFormId(resolve(param[1])) as Perk
    if thing
        mate = resolveActor(param[2])
        mate.RemovePerk(thing)
    endIf

	return true
endFunction
EndState 


State cmd_actor_advskill ;actor_advskill "$self", "skill name", "count"
bool function oper(string[] param)
    Actor mate
    string skillName
    string ss
    int    p1
    
    mate = resolveActor(param[1])
    skillName = resolve(param[2])
    ss = resolve(param[3])
    p1 = ss as int

    if mate == playerRef
        Game.AdvanceSkill(skillName, p1)
    endIf


	return true
endFunction
EndState 

State cmd_actor_incskill ;actor_incskill "$self", "skill name", "count"
bool function oper(string[] param)
    Actor mate
    string skillName
    string ss
    int    p1
    
    mate = resolveActor(param[1])
    skillName = resolve(param[2])
    ss = resolve(param[3])
    p1 = ss as int
    
    if mate == playerRef
        Game.IncrementSkillBy(skillName, p1)
    else
        mate.ModActorValue(skillName, p1)
    endIf


	return true
endFunction
EndState 

State cmd_actor_isvalid ;actor_isvalid "$self"
bool function oper(string[] param)
    Actor mate
    Cell  cc = PlayerRef.getParentCell()
    
    mate = resolveActor(param[1])
    if mate && mate.isEnabled() && !mate.isDead() && !mate.isInCombat() && !mate.IsUnconscious() && mate.Is3DLoaded() && cc == mate.getParentCell()
        stack[0] = "1"
    else
        stack[0] = "0"
    endIf


	return true
endFunction
EndState 

State cmd_actor_haslos ;actor_haslos "$a1", "$a2"
bool function oper(string[] param)
    Actor mate
    Actor mate2
    
    mate = resolveActor(param[1])
    mate2 = resolveActor(param[2])
    if mate.hasLOS(mate2)
        stack[0] = "1"
    else
        stack[0] = "0"
    endIf


	return true
endFunction
EndState 

State cmd_actor_name ;actor_name "$a1"
bool function oper(string[] param)
    Actor mate
    
    mate = resolveActor(param[1])
    stack[0] = actorName(mate)


	return true
endFunction
EndState 

State cmd_actor_modcrimegold ;actor_haslos "$actor", "count"
bool function oper(string[] param)
    Actor mate
    string ss
    int    p1
    
    mate = resolveActor(param[1])
    ss = resolve(param[2])
    p1 = ss as int
    
	Faction crimeFact = mate.GetCrimeFaction()
	if crimeFact
		crimeFact.ModCrimeGold(p1, false)
    endIf


	return true
endFunction
EndState 

State cmd_actor_qnnu ;actor_qnnu "$a1"
bool function oper(string[] param)
    Actor mate
    
    mate = resolveActor(param[1])
    mate.QueueNiNodeUpdate()


	return true
endFunction
EndState 

State cmd_actor_isguard ;actor_isguard "$a1"
bool function oper(string[] param)
    Actor mate
    
    mate = resolveActor(param[1])
    if mate.IsGuard()
        stack[0] = "1"
    else
        stack[0] = "0"
    endIf
    

	return true
endFunction
EndState 

State cmd_actor_isquard ;actor_isguard "$a1"
bool function oper(string[] param)
	GotoState("cmd_actor_isguard") ; because, seriously
	return oper(param)
endFunction
EndState 

State cmd_actor_isplayer ;actor_isplayer "$a1"
bool function oper(string[] param)
    Actor mate
    
    mate = resolveActor(param[1])
    if mate == PlayerRef
        stack[0] = "1"
    else
        stack[0] = "0"
    endIf
    

	return true
endFunction
EndState 

State cmd_actor_getgender ;actor_getgender "$a1"
bool function oper(string[] param)
    Actor mate
    int   gender
    
    mate = resolveActor(param[1])
    gender = actorGender(mate)
    
    stack[0] = gender as int

	return true
endFunction
EndState 

State cmd_actor_say ;actor_say "$self", "topic id"
bool function oper(string[] param)
    Actor mate
    Topic thing
    
    thing = getFormId(resolve(param[2])) as Topic
    if thing
        mate = resolveActor(param[1])
        mate.Say(thing)
    endIf

	return true
endFunction
EndState 

State cmd_actor_haskeyword ;actor_haskeyword "$a1", "keyword name"
bool function oper(string[] param)
    Actor mate
    string ss
    Keyword keyw
    
    mate = resolveActor(param[1])
    ss = resolve(param[2])    
    
    keyw = Keyword.GetKeyword(ss)
    
    if keyw && mate.HasKeyword(keyw)
        stack[0] = "1"
    else
        stack[0] = "0"
    endIf

	return true
endFunction
EndState 

State cmd_actor_iswearing ;actor_iswearing "$a1", "module:id"
bool function oper(string[] param)
	Actor mate
	Form thing
	
	mate = resolveActor(param[1])
	thing = getFormId(resolve(param[2]))
	
	if thing && mate.IsEquipped(thing)
        stack[0] = "1"
    else
        stack[0] = "0"
    endIf
	

	return true
endFunction
EndState

State cmd_actor_worninslot ;actor_worninslot "$a1", "slot"
bool function oper(string[] param)
	Actor mate
	int slot = param[2] as int
	
	mate = resolveActor(param[1])
	if mate && mate.GetEquippedArmorInSlot(slot)
		stack[0] = "1"
	else
		stack[0] = "0"
	endIf

	return true
endFunction
EndState

State cmd_actor_wornhaskeyword ;actor_wornhaskeyword "$a1", "keyword name"
bool function oper(string[] param)
    Actor mate
    string ss
    Keyword keyw
    
    mate = resolveActor(param[1])
    ss = resolve(param[2])    
    
    keyw = Keyword.GetKeyword(ss)
    
    if keyw && mate.WornHasKeyword(keyw)
        stack[0] = "1"
    else
        stack[0] = "0"
    endIf
    

	return true
endFunction
EndState 

State cmd_actor_lochaskeyword ;actor_lochaskeyword "$a1", "keyword name"
bool function oper(string[] param)
    Actor mate
    string ss
    Keyword keyw
    
    mate = resolveActor(param[1])
    ss = resolve(param[2])    
    
    keyw = Keyword.GetKeyword(ss)
    
    if keyw && mate.GetCurrentLocation().HasKeyword(keyw)
        stack[0] = "1"
    else
        stack[0] = "0"
    endIf
    

	return true
endFunction
EndState 

State cmd_actor_getrelation ;actor_getrelation "$a1", "$a2"
bool function oper(string[] param)
    Actor mate1
    Actor mate2
    int   ret
    
    mate1 = resolveActor(param[1])
    mate2 = resolveActor(param[2])
    
    ret = mate1.GetRelationshipRank(mate2)
    stack[0] = ret as int
    

	return true
endFunction
EndState 

State cmd_actor_setrelation ;actor_setrelation "$a1", "$a2", "num"
bool function oper(string[] param)
    Actor mate1
    Actor mate2
    string  ss
    int   p1
    
    mate1 = resolveActor(param[1])
    mate2 = resolveActor(param[2])
    ss = resolve(param[3])
    p1 = ss as int
    
    mate1.SetRelationshipRank(mate2, p1)
    

	return true
endFunction
EndState 

State cmd_actor_infaction ;actor_infaction "$a1", "faction id"
bool function oper(string[] param)
    Actor mate
    Faction thing
    
    mate = resolveActor(param[1])
    thing = getFormId(resolve(param[2])) as Faction
    
    stack[0] = "0"
    if thing
        if mate.IsInFaction(thing)
            stack[0] = "1"
        endif
    endif
    

	return true
endFunction
EndState 

;getfactionrank
State cmd_actor_getfactionrank ;actor_getfactionrank "$a1", "faction id"
bool function oper(string[] param)
    Actor mate
    Faction thing
    int retVal
    
    mate = resolveActor(param[1])
    thing = getFormId(resolve(param[2])) as Faction
    
    stack[0] = "0"
    if thing
        retVal = mate.GetFactionRank(thing)
        stack[0] = retVal as Int
    endif
    

	return true
endFunction
EndState 

State cmd_actor_setfactionrank ;actor_setfactionrank "$a1", "faction id", "rank"
bool function oper(string[] param)
    Actor mate
    Faction thing
    string ss
    int p1
    
    mate = resolveActor(param[1])
    thing = getFormId(resolve(param[2])) as Faction
    ss = resolve(param[3])
    p1 = ss as int
    
    if thing
        mate.SetFactionRank(thing, p1)
    endif
    

	return true
endFunction
EndState 

State cmd_actor_isaffectedby ;actor_isaffected by "$player", "Skyrim.esm:1030541" (can be MGEF or SPEL)
bool function oper(string[] param)
	Actor mate
	Form thing
	
	mate = resolveActor(param[1])
	if !mate
		stack[0] = "0"
		return true
	endif
	
	thing = GetFormId(resolve(param[2]))
	
	; is it a MGEF?
	MagicEffect mgef = thing as MagicEffect
	if mgef
		if mate.HasMagicEffect(mgef)
			stack[0] = "1"
		else
			stack[0] = "0"
		endif
		return true
	endif
	
	; is it a SPEL?
	Spell spel = thing as Spell
	if spel
		int i = 0
		int numeffs = spel.GetNumEffects()
		while i < numeffs
			mgef = spel.GetNthEffectMagicEffect(i)
			if mate.HasMagicEffect(mgef)
				stack[0] = "1"
				return true
			endif
			
			i += 1
		endwhile
	endif
	
	; it was nothing :(
	stack[0] = "0"
	return true
endFunction
EndState

State cmd_actor_removefaction ;actor_removefaction "$a1", "faction id"
bool function oper(string[] param)
    Actor mate
    Faction thing
    
    mate = resolveActor(param[1])
    thing = getFormId(resolve(param[2])) as Faction

    if thing
        mate.RemoveFromFaction(thing)
    endif
    

	return true
endFunction
EndState 

State cmd_actor_playanim ;
bool function oper(string[] param)
    Actor mate
    string ss
    
    mate = resolveActor(param[1])
    ss = resolve(param[2])
    
    Debug.SendAnimationEvent(mate, ss)
    

	return true
endFunction
EndState 

State cmd_actor_sendmodevent ;actor_sendmodevent "actor", "event name", "arg1", "arg2"
bool function oper(string[] param)
    Actor mate
    string ss1
    string ss2
    string ss3
    float  p3
    
    mate = resolveActor(param[1])
    ss1 = resolve(param[2])
    ss2 = resolve(param[3])
    ss3 = resolve(param[4])
    p3 = ss3 as float
    
    if mate 
        mate.SendModEvent(ss1, ss2, p3)
    endIf


	return true
endFunction
EndState 

State cmd_actor_state ;actor_state "actor", "func name", ...
bool function oper(string[] param)
    Actor mate
    string ss1
    
    mate = resolveActor(param[1])
    ss1 = resolve(param[2])
    
    stack[0] = ""
    if mate 
        if ss1 == "GetCombatState"
            stack[0] = mate.GetCombatState() as string
        elseif ss1 == "GetLevel"
            stack[0] = mate.GetLevel() as string
        elseif ss1 == "GetSleepState"
            stack[0] = mate.GetSleepState() as string
        elseif ss1 == "IsAlerted"
            stack[0] = mate.IsAlerted() as string
        elseif ss1 == "IsAlarmed"
            stack[0] = mate.IsAlarmed() as string
        elseif ss1 == "IsPlayerTeammate"
            stack[0] = mate.IsPlayerTeammate() as string
        elseif ss1 == "SetPlayerTeammate"
            int p3
            p3 = resolve(param[3]) as int
            mate.SetPlayerTeammate(p3 as bool)
        elseif ss1 == "SendAssaultAlarm"
            mate.SendAssaultAlarm()
        endIf
    endIf


	return true
endFunction
EndState 

State cmd_actor_body ;actor_body "actor", "func name", ...
bool function oper(string[] param)
    Actor mate
    string ss1
    string ss2
    
    mate = resolveActor(param[1])
    ss1 = resolve(param[2])
    
    stack[0] = ""
    if mate 
        if ss1 == "ClearExtraArrows"
            mate.ClearExtraArrows()
        elseif ss1 == "RegenerateHead"
            mate.RegenerateHead()
        elseif ss1 == "GetWeight"
            stack[0] = mate.GetActorBase().GetWeight() as string
        elseif ss1 == "SetWeight"
            float baseW
            float newW
            float neckD
        
            ss2 = resolve(param[3])
            
            baseW = mate.GetActorBase().GetWeight()
            newW  = ss2 as float
            If newW < 0
                newW = 0
            ElseIf newW > 100
                newW = 100
            EndIf
            neckD = (baseW - newW) / 100
	
            If neckD
                mate.GetActorBase().SetWeight(newW)
                mate.UpdateWeight(neckD)
            EndIf
        endIf
    endIf


	return true
endFunction
EndState 

State cmd_actor_race ;actor_race "actor", "option"
bool function oper(string[] param)
    Actor mate
    string ss1
    
    mate = resolveActor(param[1])
    ss1 = resolve(param[2])
    
    stack[0] = ""
    if mate 
        if ss1 == ""
            stack[0] = mate.GetRace().GetName()
        elseIf ss1 == "SL"
            stack[0] = sslCreatureAnimationSlots.GetRaceKey(mate.GetRace())
        endIf
    endIf


	return true
endFunction
EndState 


State cmd_ism_applyfade ;ism_applyfade "item id", duration"
bool function oper(string[] param)
    Form   thing
    string ss
    float  p1

    thing = getFormId(resolve(param[1]))
    ss = resolve(param[2])
    p1 = ss as float

    if thing
        (thing as ImageSpaceModifier).ApplyCrossFade(p1)
    endIf


	return true
endFunction
EndState 


State cmd_ism_removefade ;ism_removefade "item id", duration"
bool function oper(string[] param)
    Form   thing
    string ss
    float  p1

    thing = getFormId(resolve(param[1]))
    ss = resolve(param[2])
    p1 = ss as float

    if thing
        ImageSpaceModifier.RemoveCrossFade(p1)
    endIf


	return true
endFunction
EndState 


State cmd_util_sendmodevent ;util_sendmodevent "event name", "arg1", "arg2"
bool function oper(string[] param)
    string ss1
    string ss2
    string ss3
    float  p3
    
    ss1 = resolve(param[1])
    ss2 = resolve(param[2])
    ss3 = resolve(param[3])
    p3 = ss3 as float
    
    SendModEvent(ss1, ss2, p3)


	return true
endFunction
EndState 

State cmd_util_sendevent ;util_sendevent "event name", "arg1", "arg2"
bool function oper(string[] param)
    string eventName
    string typeId
    string ss
    int idxArg
    
    eventName = resolve(param[1])
    int eid = ModEvent.Create(eventName)
    
    if eid
        idxArg = 2 ;0 is func name, 1 is event name
        while idxArg < param.Length
            typeId = resolve(param[idxArg])
            if typeId == "bool"
                ss = resolve(param[idxArg + 1])
                if (ss as int)
                    ModEvent.PushBool(eid, true)
                else
                    ModEvent.PushBool(eid, false)
                endIf
            elseif typeId == "int"
                ss = resolve(param[idxArg + 1])
                ModEvent.PushInt(eid, ss as int)
            elseif typeId == "float"
                ss = resolve(param[idxArg + 1])
                ModEvent.PushFloat(eid, ss as float)
            elseif typeId == "string"
                ss = resolve(param[idxArg + 1])
                ModEvent.PushString(eid, ss)
            elseif typeId == "form"
                actor mate1 = resolveActor(param[idxArg + 1])
                ModEvent.PushForm(eid, mate1)
            endif
            
            idxArg += 2
        endWhile
        
        ModEvent.Send(eid)
    endIf
    

	return true
endFunction
EndState 

State cmd_util_getgametime ;
bool function oper(string[] param)
    float dayTime = Utility.GetCurrentGameTime()
    
    stack[0] = dayTime as string
    

	return true
endFunction
EndState 

State cmd_util_gethour ;
bool function oper(string[] param)
	float dayTime = Utility.GetCurrentGameTime()
 
	dayTime -= Math.Floor(dayTime)
	dayTime *= 24
    
    int theHour = dayTime as int
    
    stack[0] = theHour as string
    

	return true
endFunction
EndState 

State cmd_util_game ;
bool function oper(string[] param)
    string p1
    string p2
    
    p1 = resolve(param[1])
    if p1 == "IncrementStat"
        p2 = resolve(param[2])
        int iModAmount = resolve(param[3]) as Int
        Game.IncrementStat(p2, iModAmount)
    elseIf p1 == "QueryStat"
        p2 = resolve(param[2])
        stack[0] = Game.QueryStat(p2) as string
    endIf
    

	return true
endFunction
EndState 

State cmd_snd_play ;snd_play "item:id", "actor"
bool function oper(string[] param)
    Sound   thing
    Actor   mate
    int     retVal
    
    thing = getFormId(resolve(param[1])) as Sound
    mate = resolveActor(param[2])
    ;MiscUtil.PrintConsole("snd:play: " + thing)
    if thing
        retVal = thing.Play(mate)
        stack[0] = retVal as string
    endIf


	return true
endFunction
EndState 

State cmd_snd_setvolume ;snd_setvolume "soundId", "vol"
bool function oper(string[] param)
    string ss
    int    soundId
    float  vol
    
    ss = resolve(param[1])
    soundId = ss as int
    
    ss = resolve(param[2])
    vol = ss as float

    ;MiscUtil.PrintConsole("snd:set volume: " + soundId)
    Sound.SetInstanceVolume(soundId, vol)


	return true
endFunction
EndState 

State cmd_snd_stop ;snd_stop "soundId"
bool function oper(string[] param)
    string ss
    int    soundId

    ss = resolve(param[1])
    soundId = ss as int
    
    ;MiscUtil.PrintConsole("snd:stop: " + soundId)
    Sound.StopInstance(soundId)


	return true
endFunction
EndState 

State cmd_console ;console "$actor", "cmd", ...
bool function oper(string[] param)
    string ss
    string ssx
    int cnt
    int idx
    Actor mate
    
    mate = resolveActor(param[1])
    
    cnt = param.length
    idx = 2
    while idx < cnt
        ss = resolve(param[idx])
        ssx += ss
        idx += 1
    endWhile
    
    sl_TriggersConsole.exec_console(mate, ssx)
    

	return true
endFunction
EndState 

State cmd_mfg_reset ;mfg_reset "$actor"
bool function oper(string[] param)
    Actor mate
    
    mate = resolveActor(param[1])

    sl_TriggersMfg.mfg_reset(mate)
    

	return true
endFunction
EndState 

State cmd_mfg_setphonememodifier ;mfg_setphonememodifier "$actor", "mode", "id", "value"
bool function oper(string[] param)
    Actor mate
    int   p1
    int   p2
    int   p3
    
    mate = resolveActor(param[1])
    p1 = resolve(param[2]) as Int
    p2 = resolve(param[3]) as Int
    p3 = resolve(param[4]) as Int
    
    sl_TriggersMfg.mfg_SetPhonemeModifier(mate, p1, p2, p3)
    

	return true
endFunction
EndState 

State cmd_mfg_getphonememodifier ;mfg_getphonememodifier "$actor", "mode", "id"
bool function oper(string[] param)
    Actor mate
    int   p1
    int   p2
    int   retVal
    
    mate = resolveActor(param[1])
    p1 = resolve(param[2]) as Int
    p2 = resolve(param[3]) as Int
    
    retVal = sl_TriggersMfg.mfg_GetPhonemeModifier(mate, p1, p2)
    stack[0] = retVal as string
    

	return true
endFunction
EndState 

State cmd_util_waitforkbd ;util_waitfokbd "keycode", "keycode", ...
bool function oper(string[] param)
    string ss
    string ssx
    int cnt
    int idx
    int scancode

    cnt = param.length

    if (CmdTargetActor != PlayerRef) || (cnt <= 1)
        stack[0] = "-1"
        return false
    endIf

    UnregisterForAllKeys()

    idx = 1
    while idx < cnt
        ss = resolve(param[idx])
        scancode = ss as int
        if scancode > 0
            RegisterForKey(scanCode)
            ;MiscUtil.PrintConsole("RegKey: " + scanCode)
        endIf
        idx += 1
    endWhile
    
    lastKey = 0
	int timeoutcheck = 0
    
    while Self && lastKey == 0 && timeoutcheck < 20
        Utility.Wait(0.5)
		timeoutcheck += 1
    endWhile
    
    stack[0] = lastKey as string
    
    ;MiscUtil.PrintConsole("RetKey: " + lastKey)
    
    UnregisterForAllKeys()

	return true
endFunction
EndState 

State cmd_json_getvalue ;json_getvalue "file name", "type", "keyname", "value_if_missing"
bool function oper(string[] param)
    string pname
    string ptype
    string pkey
    string pdef
    
    pname = resolve(param[1])
    ptype = resolve(param[2])
    pkey  = resolve(param[3])
    pdef  = resolve(param[4])
    
    if ptype == "int"
        int iRet
        iRet = JsonUtil.GetIntValue(pname, pkey, pdef as int)
        stack[0] = iRet as string
    elseif ptype == "float"
        float fRet
        fRet = JsonUtil.GetFloatValue(pname, pkey, pdef as float)
        stack[0] = fRet as string
    else
        string sRet
        sRet = JsonUtil.GetStringValue(pname, pkey, pdef)
        stack[0] = sRet
    endIf
    

	return true
endFunction
EndState 

State cmd_json_setvalue ;json_getvalue "file name", "type", "keyname", "value"
bool function oper(string[] param)
    string pname
    string ptype
    string pkey
    string pdef
    
    pname = resolve(param[1])
    ptype = resolve(param[2])
    pkey  = resolve(param[3])
    pdef  = resolve(param[4])

    if ptype == "int"
        JsonUtil.SetIntValue(pname, pkey, pdef as int)
    elseif ptype == "float"
        JsonUtil.SetFloatValue(pname, pkey, pdef as float)
    else
        JsonUtil.SetStringValue(pname, pkey, pdef)
    endIf
    

	return true
endFunction
EndState 

State cmd_json_save ;json_getvalue "file name"
bool function oper(string[] param)
    string pname
    
    pname = resolve(param[1])
    ;MiscUtil.PrintConsole("Set: " + pname)
    JsonUtil.Save(pname)
    

	return true
endFunction
EndState 

State cmd_weather_state ;weather_state "actor", "func name", ...
bool function oper(string[] param)
    string ss1
    string ss2
    
    ss1 = resolve(param[1])
    
    stack[0] = ""
    if ss1 == "GetClassification"
        Weather curr = Weather.GetCurrentWeather()
        if curr
            stack[0] = curr.GetClassification() as string
        endIf
    endIf


	return true
endFunction
EndState 

State cmd_math ;math "function", ["arg1", ...]
bool function oper(string[] param)
    string ss1
    string ss2
    int    ii1
    float  ff1
    
    ss1 = resolve(param[1])
    
    stack[0] = ""
    if ss1 == "asint"
        ss2 = resolve(param[2])
        if ss2 
            ii1 = ss2 as int
        else
            ii1 = 0
        endIf
        stack[0] = ii1 as string
    elseIf ss1 == "floor"
        ss1 = resolve(param[2])
        ii1 = Math.floor(ss1 as float)
        stack[0] = ii1 as string
    elseIf ss1 == "ceiling"
        ss1 = resolve(param[2])
        ii1 = Math.Ceiling(ss1 as float)
        stack[0] = ii1 as string
    elseIf ss1 == "abs"
        ss1 = resolve(param[2])
        ff1 = Math.abs(ss1 as float)
        stack[0] = ff1 as string
    elseIf ss1 == "toint"
        ss2 = resolve(param[2])
        if ss2 && (StringUtil.GetNthChar(ss2, 0) == "0")
            ii1 = hexToInt(ss2)
        elseIf ss2
            ii1 = ss2 as int
        else 
            ii1 = 0
        endIf
        stack[0] = ii1 as string
    endIf


	return true
endFunction
EndState 