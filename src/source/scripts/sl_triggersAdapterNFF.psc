scriptname sl_triggersAdapterNFF

import sl_triggersStatics

nwsFollowerVariableScript Function GetNFFVarScript() global
    Form questForm = sl_triggers.GetForm("nwsFollowerVariables")
    if questForm
        Quest questAsQuest = questForm as Quest
        if questAsQuest
            nwsFollowerVariableScript nffVarScript = questAsQuest as nwsFollowerVariableScript
            if nffVarScript
                ;SLTDebugMsg("NFF.GetNFFVarScript: returning nffVarScript(" + nffVarScript + ")")
                return nffVarScript
            else
                SLTErrMsg("NFF.GetNFFVarScript: could not coerce quest(" + questAsQuest + ") with editorID 'nwsFollowerVariables' to type 'nwsFollowerVariableScript', which is unexpected; bailing out")
            endif
        else
            SLTErrMsg("NFF.GetNFFVarScript: could not coerce form(" + questForm + ") with editorID 'nwsFollowerVariables' to quest, which is unexpected; bailing out")
        endif
    else
        SLTWarnMsg("NFF.GetNFFVarScript: unable to find form with editorID 'nwsFollowerVariables'; bailing out")
    endif
    return none
EndFunction

Actor[] Function GetFollowersArray() global
    nwsFollowerVariableScript varScript = GetNFFVarScript()

    ; this code is a hacked copy of code used throughout NWS
    ; the basic concept is to obtain the slot count, iterate the slots
    ; and for each valid actor in a slot... you have a valid actor
	int slotsUsed = varScript.nwsFollowerMaxCount.GetValue() as int
	if slotsUsed > 10
		slotsUsed = 10
        ; in (almost?) every(?) snippet I saw, the following line was present
        ; and I have to say, being already knee deep in the guts as it were
        ; I have no desire to start slicing vigorously, so I'm going to 
        ; ignore it and be read-only
		;varScript.nwsFollowerMaxCount.SetValue(10)
	endif
	int index = 0
	Actor follower
	ReferenceAlias nffAlias
    ; primed list
	Actor[] followers = PapyrusUtil.ActorArray(0)

	; for each slot
	While (index < (slotsUsed + 2))
        ;SLTInfoMsg("NFF.GetFollowersArray: slot[" + index + "]")
		nffAlias = varScript.DialogueFollower.GetAlias(index) as ReferenceAlias
		if nffAlias
			follower = nffAlias.GetReference() as Actor

			if follower
                ; accumulate valid followers into our actor list to return
                followers = PapyrusUtil.PushActor(followers, follower)
                ;SLTInfoMsg("NFF.GetFollowersArray: slot had Actor(" + followers[followers.Length - 1] + ")")
            ;else
                ;SLTInfoMsg("NFF.GetFollowersArray: slot had Alias(" + nffAlias + ") but not an Actor")
			endif
        ;else
            ;SLTInfoMsg("NFF.GetFollowersArray: slot had no Alias")
		endif
		index += 1
	EndWhile

    return followers
EndFunction