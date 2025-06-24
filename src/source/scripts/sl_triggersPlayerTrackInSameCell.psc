scriptname sl_triggersPlayerTrackInSameCell extends ActiveMagicEffect

import sl_triggersStatics

Actor Property                      PlayerRef Auto
sl_triggersMain Property            SLTRMain Auto
sl_triggersExtensionCore Property   SLTRCore Auto
ObjectReference Property            SLTRPlayerTracker Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
    SLTDebugMsg("Player changed cells")
    Utility.Wait(0.1) ; maybe not necessary?
    SLTRPlayerTracker.MoveTo(PlayerRef)
    SLTRCore.SLTR_Internal_PlayerCellChange()
EndEvent