scriptname sl_triggersAdapterSLA

int function GetVersion() global
    slaFrameworkScr sla = Quest.GetQuest("sla_Framework") as slaFrameworkScr
    return sla.GetVersion()
endfunction

int function GetArousal(Actor target) global
    slaFrameworkScr sla = Quest.GetQuest("sla_Framework") as slaFrameworkScr
    return sla.GetActorArousal(target)
endfunction

;/
float function GetArousalMultiplier(Actor target) global
    return OSLAroused_ModInterface.GetArousalMultiplier(target)
endfunction
/;

int function GetExposure(Actor target) global
    slaFrameworkScr sla = Quest.GetQuest("sla_Framework") as slaFrameworkScr
    return sla.GetActorExposure(target)
endfunction

int function SetExposure(Actor target, int value) global
    slaFrameworkScr sla = Quest.GetQuest("sla_Framework") as slaFrameworkScr
    return sla.SetActorExposure(target, value)
endfunction

int function UpdateExposure(Actor target, int value, string debugmsg = "") global
    slaFrameworkScr sla = Quest.GetQuest("sla_Framework") as slaFrameworkScr
    return sla.UpdateActorExposure(target, value, debugmsg)
endfunction

function SendUpdateExposureEvent(Actor target, float value) global
    int handle = ModEvent.Create("slaUpdateExposure")
    ModEvent.PushForm(handle, target)
    ModEvent.PushFloat(handle, value)
    ModEvent.Send(handle)
endfunction

;/
float function ModifyArousal(Actor target, float value, string reason = "unknown") global
    return OSLAroused_ModInterface.ModifyArousal(target, value, reason)
endfunction

float function SetArousal(Actor target, float value, string reason = "unknown") global
    return OSLAroused_ModInterface.SetArousal(target, value, reason)
endfunction

float function SetArousalMultiplier(Actor target, float value, string reason = "unknown") global
    return OSLAroused_ModInterface.SetArousalMultiplier(target, value, reason)
endfunction

float function ModifyArousalMultiplier(Actor target, float value, string reason = "unknown") global
    return OSLAroused_ModInterface.ModifyArousalMultiplier(target, value)
endfunction
/;

float function GetActorDaysSinceLastOrgasm(Actor target) global
    slaFrameworkScr sla = Quest.GetQuest("sla_Framework") as slaFrameworkScr
    return sla.GetActorDaysSinceLastOrgasm(target)
endfunction
