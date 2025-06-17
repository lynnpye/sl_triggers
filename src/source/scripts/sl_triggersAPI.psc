scriptname sl_triggersAPI

int Function GetVersion() global
    sl_triggersStatics.GetModVersion()
EndFunction

string[] Function GetScriptsList() global
    return sl_triggers.GetScriptsList()
EndFunction

Function RunScript(string _scriptname, Actor _theActor = none) global
    Actor _sender = _theActor
    if !_sender
        _sender = Game.GetCurrentCrosshairRef() as Actor
        if !_sender
            _sender = Game.GetPlayer()
        endif
    endif

    _sender.SendModEvent(sl_triggersStatics.EVENT_SLT_REQUEST_COMMAND(), _scriptname)
EndFunction

string Function GetOnNewSessionEventName() global
    return sl_triggersStatics.EVENT_SLT_ON_NEW_SESSION()
EndFunction

Function RegisterExtension(sl_triggersExtension extensionToRegister) global
    if extensionToRegister
        extensionToRegister.SendModEvent(sl_triggersStatics.EVENT_SLT_REGISTER_EXTENSION(), extensionToRegister.SLTExtensionKey)
    endif
EndFunction