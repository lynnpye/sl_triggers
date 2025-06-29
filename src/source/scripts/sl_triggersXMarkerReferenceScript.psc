scriptname sl_triggersXMarkerReferenceScript extends ObjectReference

import sl_triggersStatics

Actor Property                      PlayerRef Auto
sl_triggersMain Property            SLTRMain Auto
sl_triggersExtensionCore Property   SLTRCore Auto

Event OnCellDetach()
    if !PlayerRef || !SLTRCore
        if !PlayerRef
            SLTErrMsg("XMarker.OnCellDetach: PlayerRef is null; this is bad")
        endif
        if !SLTRCore
            SLTErrMsg("XMarker.OnCellDetach: SLTRCore is null; this is bad")
        endif
        return
    endif

    Utility.Wait(0.1)
    MoveTo(PlayerRef)
    SLTRCore.SLTR_Internal_PlayerCellChange()
EndEvent