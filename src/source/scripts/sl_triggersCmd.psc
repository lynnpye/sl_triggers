Scriptname sl_TriggersCmd extends activemagiceffect

Actor               Property PlayerRef Auto
Keyword				Property ActorTypeNPC Auto
Keyword				Property ActorTypeUndead Auto
SexLabFramework     Property SexLab Auto
Faction	            Property SexLabAnimatingFaction Auto

;string commandsPath1 = "../sl_triggers/commands/"
int    tid
string cmdName
Actor  aCaster
Actor  aPartner1
Actor  aPartner2
Actor  aPartner3
Actor  aPartner4


string[] vars
string[] stack
int      cmdIdx
int      cmdNum

int[]    gotoIdx
string[] gotoLabels
int      gotoCnt

Actor    iterActor

Faction SexLabGenderFaction
sslThreadController thread

int lastKey

Event OnEffectStart(Actor akTarget, Actor akCaster)
	aCaster = akCaster
    aPartner1 = none
    aPartner2 = none
    aPartner3 = none
    aPartner4 = none
	
   	cmdName = StorageUtil.GetStringValue(akCaster, "slt:cmd")
	tid = StorageUtil.GetIntValue(akCaster, "slt:tid")
    
    StorageUtil.UnsetStringValue(akCaster, "slt:cmd")
   	StorageUtil.UnsetIntValue(akCaster, "slt:tid")
    
    ;MiscUtil.PrintConsole("InCmd: " + tid + "," + cmdName)
    
    thread = Sexlab.GetController(tid)
    int actorIdx = 0
    while actorIdx < thread.Positions.Length
        Actor theOther = thread.Positions[actorIdx]
        if theOther != aCaster
            if !aPartner1
                aPartner1 = theOther
            elseif !aPartner2
                aPartner2 = theOther
            elseif !aPartner3
                aPartner3 = theOther
            elseif !aPartner4
                aPartner4 = theOther
            endIf
        endif
        actorIdx += 1
    endWhile
    
    cmdIdx = 0
    vars = new string[10]
    stack = new string[4]
    
    gotoCnt = 0
    gotoIdx = new int[32]
    gotoLabels = new string[32]

    if Self
        RegisterForSingleUpdate(1)
    endIf
EndEvent

Event OnUpdate()
	If !Self
		Return
	EndIf

	If !aCaster
		Self.Dispel()
		Return
	EndIf
	
	If !inSameCell(aCaster)
		Debug.Trace("SL triggers: " + _actorName(aCaster) + " not in same cell as Player. Best to abort.")
		Self.Dispel()
		Return
	EndIf

    exec()
    
    If Self
        Self.Dispel()
    endIf
	;RegisterForSingleUpdate(30)
EndEvent

String Function _actorName(Actor _person)
	if _person
		return _person.GetLeveledActorBase().GetName()
	EndIf
	return "[Null actor]"
EndFunction

Int Function _actorGender(Actor _actor)
	int rank
    
    rank = Sexlab.GetGender(_actor)
    
	return rank
EndFunction

int Function hex_to_int(string _value)
    int retVal
    int idx
    int iDigit
    int pos
    string sChar
    string hexChars = "0123456789ABCDEF"
    
    idx = StringUtil.GetLength(_value) - 1
    while idx >= 0
        sChar = StringUtil.GetNthChar(_value, idx)
        iDigit = StringUtil.Find(hexChars, sChar, 0)
        if iDigit >= 0
            iDigit = Math.LeftShift(iDigit, 4 * pos)
            retVal = Math.LogicalOr(retVal, iDigit)
            idx -= 1
            pos += 1
        else 
            idx = -1
        endIf
    endWhile
    
    return retVal
EndFunction

Form Function _getFormId(string _data)
    Form retVal
    string[] params
    string fname
    string sid
    int  id
    
    params = StringUtil.Split(_data, ":")
    fname = params[0]
    sid = params[1]
    ; check if hex or dec
    if sid && (StringUtil.GetNthChar(sid, 0) == "0")
        id = hex_to_int(sid)
    else
        id = params[1] as int
    endIf
    
    retVal = Game.GetFormFromFile(id, fname)
    if !retVal
        MiscUtil.PrintConsole("Form not found: " + _data)
    endIf
    
    return retVal
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
    
    ;idx = 0
    ;while idx < gotoCnt
    ;    MiscUtil.PrintConsole("Goto list: " + idx + ", " + gotoLabels[idx] + ", " + gotoIdx[idx])
    ;    idx += 1
    ;endWhile
    
EndFunction

Int Function _findGoto(string _label, int _cmdIdx)
    int idx
    
    idx = gotoLabels.find(_label)
    ;MiscUtil.PrintConsole("Goto find1: " + _label + ", " + idx)
    if idx >= 0
        return gotoIdx[idx]
    endIf
    
    string[] cmdLine1
    string   code
    
    ;MiscUtil.PrintConsole("Label not found")
    
    idx = _cmdIdx + 1
    while idx < cmdNum
        cmdLine1 = JsonUtil.PathStringElements(cmdName, ".cmd[" + idx + "]")
        ;MiscUtil.PrintConsole(cmdLine1[0])
        if cmdLine1.Length
            if cmdLine1[0] == ":"
                ;MiscUtil.PrintConsole("add new label")
                _addGoto(idx, cmdLine1[1])
            endIf
        endIf
        idx += 1
    endWhile

    idx = gotoLabels.find(_label)
    ;MiscUtil.PrintConsole("Goto find2: " + _label + ", " + idx)
    if idx >= 0
        return gotoIdx[idx]
    endIf
    ;MiscUtil.PrintConsole("Goto notfound: " + _label + ", " + idx)
    return cmdNum
EndFunction

Bool Function inSameCell(Actor _actor)
	if _actor.getParentCell() != playerRef.getParentCell()
		return False
	EndIf
	return True
EndFunction

string Function resolve(string _code)
    if StringUtil.getNthChar(_code, 0) == "$"
        if _code == "$$"
            return stack[0]
        elseIf _code == "$0"
            return vars[0]
        elseIf _code == "$1"
            return vars[1]
        elseIf _code == "$2"
            return vars[2]
        elseIf _code == "$3"
            return vars[3]
        elseIf _code == "$4"
            return vars[4]
        elseIf _code == "$5"
            return vars[5]
        elseIf _code == "$6"
            return vars[6]
        elseIf _code == "$7"
            return vars[7]
        elseIf _code == "$8"
            return vars[8]
        elseIf _code == "$9"
            return vars[9]
        endIf
    endIf
    return _code    
EndFunction

Actor Function resolveActor(string _code)
    if _code == "$self"
        return aCaster
    elseIf _code == "$player"
        return PlayerRef
    elseIf _code == "$actor"
        return iterActor
    elseIf _code == "$partner"
        return aPartner1
    elseIf _code == "$partner2"
        return aPartner2
    elseIf _code == "$partner3"
        return aPartner3
    elseIf _code == "$partner4"
        return aPartner4
    endIf
    return aCaster 
EndFunction

bool Function resolveCond(string _p1, string _p2, string _oper)
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

string Function exec()
    string[] cmdLine
    string   code
    string   p1
    string   p2
    string   po
    bool     ifTrue
    
    cmdNum = JsonUtil.PathCount(cmdName, ".cmd")
    cmdIdx = 0
    ;MiscUtil.PrintConsole("Lines: " + cmdNum)
    while cmdIdx < cmdNum
        cmdLine = JsonUtil.PathStringElements(cmdName, ".cmd[" + cmdIdx + "]")
        if cmdLine.Length
            code = resolve(cmdLine[0])
            ;MiscUtil.PrintConsole("Cmd: " + code)

            if code == ":"
                _addGoto(cmdIdx, cmdLine[1])
                cmdIdx += 1
            elseIf code == "goto"    
                cmdIdx = _findGoto(cmdLine[1], cmdIdx)
                ;MiscUtil.PrintConsole("Goto: " + cmdIdx)
                cmdIdx += 1
            elseIf code == "if"
                ; ["if", "$$", "=", "0", "end"],
                p1 = resolve(cmdLine[1])
                p2 = resolve(cmdLine[3])
                po = cmdLine[2]
                ifTrue = resolveCond(p1, p2, po)
                if ifTrue
                    cmdIdx = _findGoto(cmdLine[4], cmdIdx)
                    ;MiscUtil.PrintConsole("GotoIf: " + cmdIdx)
                endIf
                cmdIdx += 1
            elseIf code == "return"
                return ""
            else
                GotoState("cmd_" + code)
                oper(cmdLine)
                GotoState("")
                cmdIdx += 1
            endIf
        endIf
    endWhile
    
    return ""
EndFunction

function oper(string[] param)
endFunction

Event OnKeyDown(Int keyCode)
    lastKey = keyCode
    ;MiscUtil.PrintConsole("KeyDown: " + lastKey)
EndEvent

State cmd_set ; set "$1", "value"
function oper(string[] param)
    if StringUtil.getNthChar(param[1], 0) == "$"
        int idx = StringUtil.getNthChar(param[1], 1) as int
        if idx >= 0 && idx <= 9
            if param.length == 3
                vars[idx] = resolve(param[2])
            elseIf param.length == 5
                if param[3] == "+"
                    float p1 = resolve(param[2]) as float
                    float p2 = resolve(param[4]) as float
                    vars[idx] = (p1 + p2) as string
                elseIf param[3] == "-"
                    vars[idx] = ((resolve(param[2]) as float) - (resolve(param[4]) as float)) as string
                elseIf param[3] == "*"
                    vars[idx] = ((resolve(param[2]) as float) * (resolve(param[4]) as float)) as string
                elseIf param[3] == "/"
                    vars[idx] = ((resolve(param[2]) as float) / (resolve(param[4]) as float)) as string
                elseIf param[3] == "&"
                    vars[idx] = resolve(param[2]) + resolve(param[4])
                endIf
            endIf
        else
            Debug.Notification("Bad var: " +  cmdName + "(" + cmdIdx + ")")
        endIf
    endIf
endFunction
EndState 

State cmd_inc ; inc "$1", "value"
function oper(string[] param)
    if StringUtil.getNthChar(param[1], 0) == "$"
        int idx = StringUtil.getNthChar(param[1], 1) as int
        if idx >= 0 && idx <= 9
            vars[idx] = ((vars[idx] as float) + (resolve(param[2]) as float)) as string
        else
            Debug.Notification("Bad var: " +  cmdName + "(" + cmdIdx + ")")
        endIf
    endIf
endFunction
EndState 

State cmd_cat ; cat "$1", "value"
function oper(string[] param)
    if StringUtil.getNthChar(param[1], 0) == "$"
        int idx = StringUtil.getNthChar(param[1], 1) as int
        if idx >= 0 && idx <= 9
            vars[idx] = vars[idx] + resolve(param[2])
        else
            Debug.Notification("Bad var: " +  cmdName + "(" + cmdIdx + ")")
        endIf
    endIf
endFunction
EndState 

State cmd_av_restore ;av_restore "$self", "actor_value", "value"
function oper(string[] param)
    Actor mate
    
    mate = resolveActor(param[1])
    mate.RestoreActorValue(resolve(param[2]), resolve(param[3]) as float)
endFunction
EndState 

State cmd_av_damage ;av_damage "$self", "actor_value", "value"
function oper(string[] param)
    Actor mate
    mate = resolveActor(param[1])
    mate.DamageActorValue(resolve(param[2]), resolve(param[3]) as float)
endFunction
EndState 

State cmd_av_mod ;av_mod "$self", "actor_value", "value"
function oper(string[] param)
    Actor mate
    
    mate = resolveActor(param[1])
    mate.ModActorValue(resolve(param[2]), resolve(param[3]) as float)
endFunction
EndState 

State cmd_av_set ;av_set "$self", "actor_value", "value"
function oper(string[] param)
    Actor mate
    
    mate = resolveActor(param[1])
    mate.SetActorValue(resolve(param[2]), resolve(param[3]) as float)
endFunction
EndState 

State cmd_av_getbase ;av_getbase "$self", "actor_value"
function oper(string[] param)
    Actor mate
    float val
    
    mate = resolveActor(param[1])
    val = mate.GetBaseActorValue(resolve(param[2]))
    
    stack[0] = val as string
    ;MiscUtil.PrintConsole("Return: " + stack[0])
endFunction
EndState 

State cmd_av_get ;av_get "$self", "actor_value"
function oper(string[] param)
    Actor mate
    float val
    
    mate = resolveActor(param[1])
    val = mate.GetActorValue(resolve(param[2]))
    
    stack[0] = val as string
    ;MiscUtil.PrintConsole("Return: " + stack[0])
endFunction
EndState 

State cmd_av_getmax ;av_getmax "$self", "actor_value"
function oper(string[] param)
    Actor mate
    float val
    
    mate = resolveActor(param[1])
    val = mate.GetActorValueMax(resolve(param[2]))
    
    stack[0] = val as string
endFunction
EndState 


State cmd_av_getpercent ;av_getmax "$self", "actor_value"
function oper(string[] param)
    Actor mate
    float val
    
    mate = resolveActor(param[1])
    val = mate.GetActorValuePercentage(resolve(param[2]))
    val = val * 100.0
    
    stack[0] = val as string
endFunction
EndState 

State cmd_spell_cast ;spell_cast "module:id", "$self"
function oper(string[] param)
    Spell thing
    Actor mate
    thing = _getFormId(resolve(param[1])) as Spell
    if thing
        mate = resolveActor(param[2])
        thing.RemoteCast(mate, mate, mate)
    endIf
endFunction
EndState 

State cmd_spell_dcsa ;spell_dcsa "module:id", "$self"
function oper(string[] param)
    Spell thing
    Actor mate
    thing = _getFormId(resolve(param[1])) as Spell
    if thing
        mate = resolveActor(param[2])
        mate.DoCombatSpellApply(thing, mate)
    endIf
endFunction
EndState 

State cmd_spell_dispel ;spell_dispel "module:id", "$self"
function oper(string[] param)
    Spell thing
    Actor mate
    thing = _getFormId(resolve(param[1])) as Spell
    if thing
        mate = resolveActor(param[2])
        mate.DispelSpell(thing)
    endIf
endFunction
EndState 

State cmd_spell_add ;spell_add "module:id", "$self"
function oper(string[] param)
    Spell thing
    Actor mate
    thing = _getFormId(resolve(param[1])) as Spell
    if thing
        mate = resolveActor(param[2])
        mate.AddSpell(thing)
    endIf
endFunction
EndState 

State cmd_spell_remove ;spell_remove "module:id", "$self"
function oper(string[] param)
    Spell thing
    Actor mate
    thing = _getFormId(resolve(param[1])) as Spell
    if thing
        mate = resolveActor(param[2])
        mate.RemoveSpell(thing)
    endIf
endFunction
EndState 


State cmd_item_add ;item_add "$self", "module:id", "count:int", "silent:bool"
function oper(string[] param)
    Form thing
    Actor mate
    int count
    bool isSilent
    
    mate = resolveActor(param[1])
    thing = _getFormId(resolve(param[2]))
    if thing
        count = resolve(param[3]) as int
        isSilent = resolve(param[4]) as int
        mate.AddItem(thing, count, isSilent)
    endIf
endFunction
EndState 

State cmd_item_addex ;item_add "$self", "module:id", "count:int", "silent:bool"
function oper(string[] param)
    Form thing
    Actor mate
    int count
    bool isSilent
    
    mate = resolveActor(param[1])
    thing = _getFormId(resolve(param[2]))
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
                            aCaster.UnequipItemEx(thisArmor, 0)
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
endFunction
EndState 

State cmd_item_remove ;item_remove "$self", "module:id", "count:int", "silent:bool"
function oper(string[] param)
    Form thing
    Actor mate
    int count
    bool isSilent
    
    mate = resolveActor(param[1])
    thing = _getFormId(resolve(param[2]))
    if thing
        count = resolve(param[3]) as int
        isSilent = resolve(param[4]) as int
        mate.RemoveItem(thing, count, isSilent)
    endIf
endFunction
EndState 

State cmd_item_adduse ;item_adduse "$self", "module:id", "count:int", "silent:bool"
function oper(string[] param)
    Form thing
    Actor mate
    int count
    bool isSilent
    
    mate = resolveActor(param[1])
    thing = _getFormId(resolve(param[2]))
    if thing
        count = resolve(param[3]) as int
        isSilent = resolve(param[4]) as int
        mate.AddItem(thing, count, isSilent)
        mate.EquipItem(thing, false, isSilent)
    endIf
endFunction
EndState 


State cmd_item_equipex ;item_equipex "$self", "module:id", "slot:int", "sound:bool"
function oper(string[] param)
    Form thing
    Actor mate
    int slotId
    bool isSilent
    
    mate = resolveActor(param[1])
    thing = _getFormId(resolve(param[2]))
    if thing
        slotId = resolve(param[3]) as int
        isSilent = resolve(param[4]) as int
        mate.EquipItemEx(thing, slotId, false, isSilent)
    endIf
endFunction
EndState 

State cmd_item_equip ;item_equipex "$self", "module:id", "noremove:int", "sound:bool"
function oper(string[] param)
    Form thing
    Actor mate
    int slotId
    bool isSilent
    
    mate = resolveActor(param[1])
    thing = _getFormId(resolve(param[2]))
    if thing
        slotId = resolve(param[3]) as int
        isSilent = resolve(param[4]) as int
        mate.EquipItem(thing, slotId, isSilent)
    endIf
endFunction
EndState 

State cmd_item_unequipex ;item_equipex "$self", "module:id", "slot:int"
function oper(string[] param)
    Form thing
    Actor mate
    int slotId
    bool isSilent
    
    mate = resolveActor(param[1])
    thing = _getFormId(resolve(param[2]))
    if thing
        slotId = resolve(param[3]) as int
        mate.UnEquipItemEx(thing, slotId)
    endIf
endFunction
EndState 

State cmd_item_getcount ;item_equipex "$self", "module:id"
function oper(string[] param)
    Form thing
    Actor mate
    int retVal

    mate = resolveActor(param[1])
    thing = _getFormId(resolve(param[2]))
    if thing
        retVal = mate.GetItemCount(thing)
        stack[0] = retVal as string
    endIf
endFunction
EndState 

State cmd_msg_notify ;msg_notify "text"
function oper(string[] param)
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
endFunction
EndState 

State cmd_msg_console ;msg_console "text"
function oper(string[] param)
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
endFunction
EndState 


State cmd_rnd_list ;rnd_list "stuff1", "stuff2", ...
function oper(string[] param)
    string ss
    int cnt
    int idx
    
    cnt = param.length
    idx = utility.RandomInt(1, cnt - 1)
    ss = resolve(param[idx])
    stack[0] = ss
    ;MiscUtil.PrintConsole("rnd_list: " + cnt + "," + idx + ", " + ss + ", " + stack[0])
endFunction
EndState 

State cmd_rnd_int ;rnd_int "min", "max"
function oper(string[] param)
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
    
endFunction
EndState 

State cmd_util_wait ;util_wait "sec"
function oper(string[] param)
    string ss
    ss = resolve(param[1])
    Utility.wait(ss as float)
endFunction
EndState 

State cmd_util_waitforend ;util_waitforend
function oper(string[] param)
    Actor mate
    
    mate = resolveActor(param[1])

    while mate.GetFactionRank(SexLabAnimatingFaction) >= 0 && inSameCell(mate)
        Utility.wait(6)
    endWhile

endFunction
EndState 

State cmd_util_getrndactor ;util_getrndactor "range", "option"
function oper(string[] param)
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
        return
    endIf
    
    idxRnd = Utility.RandomInt(0, cnt)
    idx = 0
    while idx < cnt
		Actor mate = inCell[idx]
        
		if mate && mate != PlayerRef && mate.isEnabled() && !mate.isDead() && !mate.isInCombat() && !mate.IsUnconscious() && mate.HasKeyWord(ActorTypeNPC) && mate.Is3DLoaded() && cc == mate.getParentCell()
            if idx > idxRnd
                idx = cnt + 1
            elseIf opt == 0
                lastFound = mate
            elseif opt == 1
                if !mate.IsInFaction(SexLabAnimatingFaction)
                    lastFound = mate
                endIf
            elseif opt == 2
                if mate.IsInFaction(SexLabAnimatingFaction)
                    lastFound = mate
                endIf
            endIf
		endIf
    
        idx += 1
    endWhile
    
    iterActor = lastFound    
    
endFunction
EndState 


State cmd_sl_isin ;sl_isin "$self"
function oper(string[] param)
    Actor mate
    int retVal
    
    mate = resolveActor(param[1])
    
    ;if SexLab.ValidateActor(mate) == -10 && inSameCell(mate)
    if mate.GetFactionRank(SexLabAnimatingFaction) >= 0 && inSameCell(mate)
        stack[0] = "1"
    else
        stack[0] = "0"
    endIf
endFunction
EndState 

State cmd_sl_hastag ;sl_hastag "tag_name"
function oper(string[] param)
    string ss
    
    stack[0] = "0"
    
    if thread
        ss = resolve(param[1])
        if thread.Animation.HasTag(ss)
            stack[0] = "1"
        endIf
    endIf

endFunction
EndState 

State cmd_sl_animname ;sl_animname
function oper(string[] param)
    string ss
    
    stack[0] = ""
    
    if thread
        stack[0] = thread.Animation.Name
        ;MiscUtil.PrintConsole("animname: " + stack[0])
    endIf

endFunction
EndState 

State cmd_sl_getprop ;sl_getprop
function oper(string[] param)
    string ss
    
    stack[0] = ""
    
    if thread
        ss = resolve(param[1])
        if ss == "Stage"
            stack[0] = thread.Stage as string
        elseif ss == "ActorCount"
            stack[0] = thread.ActorCount as string
        endIf
        ;MiscUtil.PrintConsole("animname: " + stack[0])
    endIf

endFunction
EndState 

State cmd_perk_addpoints ;perk_addpoints "count"
function oper(string[] param)
    string ss
    int    p1
    ss = resolve(param[1])
    p1 = ss as int
    Game.AddPerkPoints(p1)
endFunction
EndState 

State cmd_perk_add ;perk_add "module:id", "$self"
function oper(string[] param)
    Perk thing
    Actor mate
    thing = _getFormId(resolve(param[1])) as Perk
    if thing
        mate = resolveActor(param[2])
        mate.AddPerk(thing)
    endIf
endFunction
EndState 

State cmd_perk_remove ;perk_remove "module:id", "$self"
function oper(string[] param)
    Perk thing
    Actor mate
    thing = _getFormId(resolve(param[1])) as Perk
    if thing
        mate = resolveActor(param[2])
        mate.RemovePerk(thing)
    endIf
endFunction
EndState 


State cmd_actor_advskill ;actor_advskill "$self", "skill name", "count"
function oper(string[] param)
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

endFunction
EndState 

State cmd_actor_incskill ;actor_incskill "$self", "skill name", "count"
function oper(string[] param)
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

endFunction
EndState 

State cmd_actor_isvalid ;actor_isvalid "$self"
function oper(string[] param)
    Actor mate
    Cell  cc = PlayerRef.getParentCell()
    
    mate = resolveActor(param[1])
    if mate && mate.isEnabled() && !mate.isDead() && !mate.isInCombat() && !mate.IsUnconscious() && mate.Is3DLoaded() && cc == mate.getParentCell()
        stack[0] = "1"
    else
        stack[0] = "0"
    endIf

endFunction
EndState 

State cmd_actor_haslos ;actor_haslos "$a1", "$a2"
function oper(string[] param)
    Actor mate
    Actor mate2
    
    mate = resolveActor(param[1])
    mate2 = resolveActor(param[2])
    if mate.hasLOS(mate2)
        stack[0] = "1"
    else
        stack[0] = "0"
    endIf

endFunction
EndState 

State cmd_actor_name ;actor_name "$a1"
function oper(string[] param)
    Actor mate
    
    mate = resolveActor(param[1])
    stack[0] = _actorName(mate)

endFunction
EndState 

State cmd_actor_modcrimegold ;actor_haslos "$actor", "count"
function oper(string[] param)
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

endFunction
EndState 

State cmd_actor_qnnu ;actor_qnnu "$a1"
function oper(string[] param)
    Actor mate
    
    mate = resolveActor(param[1])
    mate.QueueNiNodeUpdate()

endFunction
EndState 

State cmd_actor_isquard ;actor_isquard "$a1"
function oper(string[] param)
    Actor mate
    
    mate = resolveActor(param[1])
    if mate.IsGuard()
        stack[0] = "1"
    else
        stack[0] = "0"
    endIf
    
endFunction
EndState 

State cmd_actor_isplayer ;actor_isplayer "$a1"
function oper(string[] param)
    Actor mate
    
    mate = resolveActor(param[1])
    if mate == PlayerRef
        stack[0] = "1"
    else
        stack[0] = "0"
    endIf
    
endFunction
EndState 

State cmd_actor_getgender ;actor_getgender "$a1"
function oper(string[] param)
    Actor mate
    int   gender
    
    mate = resolveActor(param[1])
    gender = _actorGender(mate)
    
    stack[0] = gender as int
    
endFunction
EndState 

State cmd_actor_say ;actor_say "$self", "topic id"
function oper(string[] param)
    Actor mate
    Topic thing
    
    thing = _getFormId(resolve(param[2])) as Topic
    if thing
        mate = resolveActor(param[1])
        if mate == PlayerRef && SexLab.Config.ToggleFreeCamera
            ;mate.Say(thing, mate, true)
        else
            mate.Say(thing)
        endIf
    endIf

endFunction
EndState 

State cmd_actor_haskeyword ;actor_haskeyword "$a1", "keyword name"
function oper(string[] param)
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
    
endFunction
EndState 

State cmd_actor_wornhaskeyword ;actor_wornhaskeyword "$a1", "keyword name"
function oper(string[] param)
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
    
endFunction
EndState 

State cmd_actor_lochaskeyword ;actor_lochaskeyword "$a1", "keyword name"
function oper(string[] param)
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
    
endFunction
EndState 

State cmd_actor_getrelation ;actor_getrelation "$a1", "$a2"
function oper(string[] param)
    Actor mate1
    Actor mate2
    int   ret
    
    mate1 = resolveActor(param[1])
    mate2 = resolveActor(param[2])
    
    ret = mate1.GetRelationshipRank(mate2)
    stack[0] = ret as int
    
endFunction
EndState 

State cmd_actor_setrelation ;actor_setrelation "$a1", "$a2", "num"
function oper(string[] param)
    Actor mate1
    Actor mate2
    string  ss
    int   p1
    
    mate1 = resolveActor(param[1])
    mate2 = resolveActor(param[2])
    ss = resolve(param[3])
    p1 = ss as int
    
    mate1.SetRelationshipRank(mate2, p1)
    
endFunction
EndState 

State cmd_actor_infaction ;actor_infaction "$a1", "faction id"
function oper(string[] param)
    Actor mate
    Faction thing
    
    mate = resolveActor(param[1])
    thing = _getFormId(resolve(param[2])) as Faction
    
    stack[0] = "0"
    if thing
        if mate.IsInFaction(thing)
            stack[0] = "1"
        endif
    endif
    
endFunction
EndState 

;getfactionrank
State cmd_actor_getfactionrank ;actor_getfactionrank "$a1", "faction id"
function oper(string[] param)
    Actor mate
    Faction thing
    int retVal
    
    mate = resolveActor(param[1])
    thing = _getFormId(resolve(param[2])) as Faction
    
    stack[0] = "0"
    if thing
        retVal = mate.GetFactionRank(thing)
        stack[0] = retVal as Int
    endif
    
endFunction
EndState 

State cmd_actor_setfactionrank ;actor_setfactionrank "$a1", "faction id", "rank"
function oper(string[] param)
    Actor mate
    Faction thing
    string ss
    int p1
    
    mate = resolveActor(param[1])
    thing = _getFormId(resolve(param[2])) as Faction
    ss = resolve(param[3])
    p1 = ss as int
    
    if thing
        mate.SetFactionRank(thing, p1)
    endif
    
endFunction
EndState 

State cmd_actor_removefaction ;actor_removefaction "$a1", "faction id"
function oper(string[] param)
    Actor mate
    Faction thing
    
    mate = resolveActor(param[1])
    thing = _getFormId(resolve(param[2])) as Faction

    if thing
        mate.RemoveFromFaction(thing)
    endif
    
endFunction
EndState 

State cmd_actor_playanim ;
function oper(string[] param)
    Actor mate
    string ss
    
    mate = resolveActor(param[1])
    ss = resolve(param[2])
    
    Debug.SendAnimationEvent(mate, ss)
    
endFunction
EndState 

State cmd_actor_sendmodevent ;actor_sendmodevent "actor", "event name", "arg1", "arg2"
function oper(string[] param)
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

endFunction
EndState 

State cmd_actor_state ;actor_state "actor", "func name", ...
function oper(string[] param)
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

endFunction
EndState 

State cmd_actor_body ;actor_body "actor", "func name", ...
function oper(string[] param)
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

endFunction
EndState 

State cmd_actor_race ;actor_race "actor", "option"
function oper(string[] param)
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

endFunction
EndState 


State cmd_ism_applyfade ;ism_applyfade "item id", duration"
function oper(string[] param)
    Form   thing
    string ss
    float  p1

    thing = _getFormId(resolve(param[1]))
    ss = resolve(param[2])
    p1 = ss as float

    if thing
        (thing as ImageSpaceModifier).ApplyCrossFade(p1)
    endIf

endFunction
EndState 


State cmd_ism_removefade ;ism_removefade "item id", duration"
function oper(string[] param)
    Form   thing
    string ss
    float  p1

    thing = _getFormId(resolve(param[1]))
    ss = resolve(param[2])
    p1 = ss as float

    if thing
        ImageSpaceModifier.RemoveCrossFade(p1)
    endIf

endFunction
EndState 


State cmd_util_sendmodevent ;util_sendmodevent "event name", "arg1", "arg2"
function oper(string[] param)
    string ss1
    string ss2
    string ss3
    float  p3
    
    ss1 = resolve(param[1])
    ss2 = resolve(param[2])
    ss3 = resolve(param[3])
    p3 = ss3 as float
    
    SendModEvent(ss1, ss2, p3)

endFunction
EndState 

State cmd_util_sendevent ;util_sendevent "event name", "arg1", "arg2"
function oper(string[] param)
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
    
endFunction
EndState 

State cmd_util_getgametime ;
function oper(string[] param)
    float dayTime = Utility.GetCurrentGameTime()
    
    stack[0] = dayTime as string
    
endFunction
EndState 

State cmd_util_gethour ;
function oper(string[] param)
	float dayTime = Utility.GetCurrentGameTime()
 
	dayTime -= Math.Floor(dayTime)
	dayTime *= 24
    
    int theHour = dayTime as int
    
    stack[0] = theHour as string
    
endFunction
EndState 

State cmd_util_game ;
function oper(string[] param)
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
    
endFunction
EndState 

State cmd_snd_play ;snd_play "item:id", "actor"
function oper(string[] param)
    Sound   thing
    Actor   mate
    int     retVal
    
    thing = _getFormId(resolve(param[1])) as Sound
    mate = resolveActor(param[2])
    ;MiscUtil.PrintConsole("snd:play: " + thing)
    if thing
        retVal = thing.Play(mate)
        stack[0] = retVal as string
    endIf

endFunction
EndState 

State cmd_snd_setvolume ;snd_setvolume "soundId", "vol"
function oper(string[] param)
    string ss
    int    soundId
    float  vol
    
    ss = resolve(param[1])
    soundId = ss as int
    
    ss = resolve(param[2])
    vol = ss as float

    ;MiscUtil.PrintConsole("snd:set volume: " + soundId)
    Sound.SetInstanceVolume(soundId, vol)

endFunction
EndState 

State cmd_snd_stop ;snd_stop "soundId"
function oper(string[] param)
    string ss
    int    soundId

    ss = resolve(param[1])
    soundId = ss as int
    
    ;MiscUtil.PrintConsole("snd:stop: " + soundId)
    Sound.StopInstance(soundId)

endFunction
EndState 

State cmd_console ;console "$actor", "cmd", ...
function oper(string[] param)
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
    
endFunction
EndState 

State cmd_mfg_reset ;mfg_reset "$actor"
function oper(string[] param)
    Actor mate
    
    mate = resolveActor(param[1])

    sl_TriggersMfg.mfg_reset(mate)
    
endFunction
EndState 

State cmd_mfg_setphonememodifier ;mfg_setphonememodifier "$actor", "mode", "id", "value"
function oper(string[] param)
    Actor mate
    int   p1
    int   p2
    int   p3
    
    mate = resolveActor(param[1])
    p1 = resolve(param[2]) as Int
    p2 = resolve(param[3]) as Int
    p3 = resolve(param[4]) as Int
    
    sl_TriggersMfg.mfg_SetPhonemeModifier(mate, p1, p2, p3)
    
endFunction
EndState 

State cmd_mfg_getphonememodifier ;mfg_getphonememodifier "$actor", "mode", "id"
function oper(string[] param)
    Actor mate
    int   p1
    int   p2
    int   retVal
    
    mate = resolveActor(param[1])
    p1 = resolve(param[2]) as Int
    p2 = resolve(param[3]) as Int
    
    retVal = sl_TriggersMfg.mfg_GetPhonemeModifier(mate, p1, p2)
    stack[0] = retVal as string
    
endFunction
EndState 

State cmd_util_waitforkbd ;util_waitfokbd "keycode", "keycode", ...
function oper(string[] param)
    string ss
    string ssx
    int cnt
    int idx
    int scancode

    cnt = param.length

    if (aCaster != PlayerRef) || (cnt <= 1) || !(PlayerRef.GetFactionRank(SexLabAnimatingFaction) >= 0)
        stack[0] = "-1"
        return
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
    
    while Self && lastKey == 0 && PlayerRef.GetFactionRank(SexLabAnimatingFaction) >= 0
        Utility.Wait(0.5)
    endWhile
    
    if !(PlayerRef.GetFactionRank(SexLabAnimatingFaction) >= 0)
        stack[0] = "-1"
    else
        stack[0] = lastKey as string
    endIf
    
    ;MiscUtil.PrintConsole("RetKey: " + lastKey)
    
    UnregisterForAllKeys()
    
endFunction
EndState 


State cmd_json_getvalue ;json_getvalue "file name", "type", "keyname", "value_if_missing"
function oper(string[] param)
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
    
endFunction
EndState 

State cmd_json_setvalue ;json_getvalue "file name", "type", "keyname", "value"
function oper(string[] param)
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
    
endFunction
EndState 

State cmd_json_save ;json_getvalue "file name"
function oper(string[] param)
    string pname
    
    pname = resolve(param[1])
    ;MiscUtil.PrintConsole("Set: " + pname)
    JsonUtil.Save(pname)
    
endFunction
EndState 

State cmd_weather_state ;weather_state "actor", "func name", ...
function oper(string[] param)
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

endFunction
EndState 

State cmd_math ;math "function", ["arg1", ...]
function oper(string[] param)
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
            ii1 = hex_to_int(ss2)
        elseIf ss2
            ii1 = ss2 as int
        else 
            ii1 = 0
        endIf
        stack[0] = ii1 as string
    endIf

endFunction
EndState 
