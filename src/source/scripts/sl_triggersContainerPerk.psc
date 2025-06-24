scriptname sl_triggersContainerPerk extends Perk Hidden

import sl_triggersStatics

sl_triggersMain Property                SLT auto
sl_triggersExtensionCore Property       SLTExtensionCore auto

Function SendOnSLTRContainerActivate()
    SendModEvent(EVENT_SLTR_ON_CONTAINER_ACTIVATE())
EndFunction