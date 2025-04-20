scriptname sl_triggersCmdCore extends sl_triggersCmdBase

import sl_triggersStatics
import sl_triggersHeap

bool function oper(string[] param)
	return false
endFunction

Event OnEffectStart(Actor akTarget, Actor akCaster)
	SLTOnEffectStart(akCaster)
	
	QueueUpdateLoop(0.1)
EndEvent

Event OnUpdate()
	QueueUpdateLoop(DefaultGetKeepAliveTimeWithJitter(15.0))
EndEvent

;; This is probably one of the most minimal implementations of this one can expect

State cmd_toh_elapsed_time
bool function oper(string[] param)
	stack[0] = (CmdExtension as sl_triggersExtensionCore).TohElapsedTime as string

	return true
endFunction
EndState



State cmd_actual_hours_since_last_top
bool function oper(string[] param)
	GotoState("cmd_toh_elapsed_time")
	return oper(param)
endFunction
EndState

