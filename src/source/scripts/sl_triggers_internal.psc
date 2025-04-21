scriptname sl_triggers_internal Hidden

; safe access
ActiveMagicEffect[] Function SafeGetActiveMagicEffectsForActor(Actor _theActor) global
    return sl_triggers_internal.GetActiveMagicEffectsForActor(_theActor)
EndFunction

bool Function SafeIsLoaded() global
    return sl_triggers_internal.IsLoaded()
EndFunction

; direct access
ActiveMagicEffect[] Function GetActiveMagicEffectsForActor(Actor _theActor) global native

bool Function IsLoaded() global native