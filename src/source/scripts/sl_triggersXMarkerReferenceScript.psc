scriptname sl_triggersXMarkerReferenceScript extends ObjectReference

import sl_triggersStatics

Actor Property                      PlayerRef Auto
sl_triggersMain Property            SLTRMain Auto
sl_triggersExtensionCore Property   SLTRCore Auto

Event OnCellDetach()
    SLTDebugMsg("XMarker cell detached")
    Utility.Wait(0.1)
    MoveTo(PlayerRef)
    SLTRCore.SLTR_Internal_PlayerCellChange()
EndEvent