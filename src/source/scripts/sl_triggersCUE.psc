scriptname sl_triggersCUE hidden

import sl_triggersStatics

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; slt_version
string Function slt_version() global
    return "SLT version: " + GetModVersion()
EndFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; slt_list
string Function slt_list() global
    string[] commandsList = sl_triggers.GetScriptsList()
    PrintScriptsListToConsole(commandsList)
    return ""
EndFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; slt_run
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; slt_hexbug
string Function slt_hexbug(string p01str) global
    string hexmsg = "You ran hexbug. This is the default response."
    bool dotest

    if dotest
        
    endif

    return hexmsg
EndFunction