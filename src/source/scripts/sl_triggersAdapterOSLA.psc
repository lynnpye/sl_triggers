scriptname sl_triggersAdapterOSLA

float function GetArousal(Actor target) global
    return OSLAroused_ModInterface.GetArousal(target)
endfunction

float function GetArousalMultiplier(Actor target) global
    return OSLAroused_ModInterface.GetArousalMultiplier(target)
endfunction

float function GetExposure(Actor target) global
    return OSLAroused_ModInterface.GetArousal(target)
endfunction

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

float function GetActorDaysSinceLastOrgasm(Actor target) global
    return OSLAroused_ModInterface.GetActorDaysSinceLastOrgasm(target)
endfunction