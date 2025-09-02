scriptname sl_triggersCmdLibNFF

import sl_triggersStatics


; sltname nff_getfollowers
; sltgrup NFF (Nether's Follower Framework)
; sltdesc Returns: Form[]: a list containing the followers
; sltsamp set $nffFollowers resultfrom nff_getfollowers
; sltsamp set $count resultfrom listcount $nffFollowers
; sltsamp ; counting backwards
; sltsamp while $count > 0
; sltsamp   inc $count -1
; sltsamp   set $follower $nffFollowers[$count]
; sltsamp   ; do something for each $follower
; sltsamp   set $followerName resultfrom actor_name $follower
; sltsamp   msg_notify $"{$followerName} is your #1 fan!"
; sltsamp endwhile
function nff_getfollowers(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if ParamLengthEQ(CmdPrimary, param.Length, 1)
        Actor[] nffFollowers = sl_triggersAdapterNFF.GetFollowersArray()
        Form[] formFollowers = ActorArrayToFormArray(nffFollowers)
        CmdPrimary.MostRecentListFormResult = formFollowers
    endif

	CmdPrimary.CompleteOperationOnActor()
endFunction