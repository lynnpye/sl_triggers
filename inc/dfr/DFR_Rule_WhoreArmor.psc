Scriptname DFR_Rule_WhoreArmor extends DFR_Rule_Builtin  

DFR_Outfits property Outfits auto

function OnModuleLoad()
    EventName = "Armor"
endFunction

bool function OnStart(Actor akTarget)
    Outfits.StartWhoreArmorRule()
    return parent.OnStart(akTarget)
endFunction 

function OnStop()
    Outfits.StopWhoreArmorRule()
    return parent.OnStop()
endFunction
