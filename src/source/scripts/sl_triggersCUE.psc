scriptname sl_triggersCUE hidden

import sl_triggersStatics

string Function slt_version() global
    return "SLT version: " + GetModVersion()
EndFunction

string Function slt_list() global
    string[] commandsList = sl_triggersMain.GetInstance().GetScriptsList()
    string longString = PapyrusUtil.StringJoin(commandsList, "\n")
    return "SLT ScriptsList Start:\n" + longString + "\nSLT Scripts ListEnd"
EndFunction

string Function slt_run(string scrname) global
    if !scrname
        return "slt run: script name is a required parameter"
    endif
    
    Actor _theActor = Game.GetCurrentConsoleRef() as Actor
    if !_theActor
        _theActor = Game.GetCurrentCrosshairRef() as Actor
        if !_theActor
            _theActor = Game.GetPlayer()
            if !_theActor
                return "slt run: unable to determine Actor to run on"
            endif
        endif
    endif

    _theActor.SendModEvent(EVENT_SLT_REQUEST_COMMAND(), scrname)

    return "Sent request to run \"" + scrname + "\" on Actor \"" + _theActor.GetDisplayName() + "\""
EndFunction