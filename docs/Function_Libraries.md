# SLTriggers Redux Base Function Library 

## Actor

### actor_advskill

**Description**

Advance targeted actor's skill by specified amount. Only works on Player.

**Parameters**

    actor: target Actor  
    skill: skillname e.g. Alteration, Destruction  
    value: number  


**Example**

    actor_advskill $system.self Alteration 1  

Boost Alteration by 1 point  
Note: Currently only works on PC/Player  


### actor_body

**Description**

Alters or queries information about the actor's body, based on sub-function

**Parameters**

    actor: target Actor  
    sub-function: sub-function  
    third argument: varies by sub-function  

    if parameter 2 is "ClearExtraArrows": clear extra arrows  
    if parameter 2 is "RegenerateHead": regenerate head  
    if parameter 2 is "GetWeight": get actors weight (0-100)  
    if parameter 2 is "SetWeight" (parameter 3: <float, weight>): set actors weight  


**Example**

    actor_body $system.self "SetWeight" 110  



### actor_display_name

**Description**

Set $$ to the actor displayName

**Parameters**

    actor: target Actor  


**Example**

    actor_display_name $actor  



### actor_doaction

**Description**

For the targeted Actor, perform the associated function based on the specified action
'Action' in this case specifically refers to functions that take no parameters and return no values
https://ck.uesp.net/wiki/Actor_Script

**Parameters**

    actor: target Actor  
    action: action name  

    ;;;; These are from Actor  
    ClearArrested  
    ClearExpressionOverride  
    ClearExtraArrows  
    ClearForcedLandingMarker  
    ClearKeepOffsetFromActor  
    ClearLookAt  
    DispelAllSpells  
    DrawWeapon  
    EndDeferredKill  
    EvaluatePackage  
    MakePlayerFriend  
    MoveToPackageLocation  
    RemoveFromAllFactions  
    ResetHealthAndLimbs  
    Resurrect  
    SendAssaultAlarm  
    SetPlayerResistingArrest  
    ShowBarterMenu  
    StartDeferredKill  
    StartSneaking  
    StopCombat  
    StopCombatAlarm  
    UnequipAll  
    UnlockOwnedDoorsInCell  
    ;;;; will call objectreference_doaction if no matches are found  


**Example**

    actor_doaction $system.self StopCombat  



### actor_doconsumer

**Description**

For the specified Actor, perform the requested consumer, provided the appropriate additional parameters
'Consumer' in this case specifically refers to functions that take parameters but return no result
https://ck.uesp.net/wiki/Actor_Script

**Parameters**

    actor: target Actor (accepts both relative "Skyrim.esm:0f" and absolute "0f" values)  
    consumer: consumer name  

    AddPerk  
    AddToFaction  
    AllowBleedoutDialogue  
    AllowPCDialogue  
    AttachAshPile  
    DamageActorValue  
    DamageAV  
    DoCombatSpellApply  
    EnableAI  
    EquipItem  
    EquipShout  
    EquipSpell  
    ForceActorValue  
    ForceAV  
    KeepOffsetFromActor  
    Kill  
    KillEssential  
    KillSilent  
    ModActorValue  
    ModAV  
    ModFactionRank  
    OpenInventory  
    PlaySubGraphAnimation  
    RemoveFromFaction  
    RemovePerk  
    RestoreActorValue  
    RestoreAV  
    SendTrespassAlarm  
    SetActorValue  
    SetAlert  
    SetAllowFlying  
    SetAllowFlyingEx  
    SetAlpha  
    SetAttackActorOnSight  
    SetAV  
    SetBribed  
    SetCrimeFaction  
    SetCriticalStage  
    SetDoingFavor  
    SetDontMove  
    SetExpressionOverride  
    SetEyeTexture  
    SetFactionRank  
    SetForcedLandingMarker  
    SetGhost  
    SetHeadTracking  
    SetIntimidated  
    SetLookAt  
    SetNoBleedoutRecovery  
    SetNotShowOnStealthMeter  
    SetOutfit  
    SetPlayerControls  
    SetPlayerTeammate  
    SetRace  
    SetRelationshipRank  
    SetRestrained  
    SetSubGraphFloatVariable  
    SetUnconscious  
    SetVehicle  
    SetVoiceRecoveryTime  
    StartCannibal  
    StartCombat  
    StartVampireFeed  
    UnequipItem  
    UnequipItemSlot  
    UnequipShout  
    UnequipSpell  
    SendLycanthropyStateChanged  
    SendVampirismStateChanged  
    EquipItemEx  
    EquipItemById  
    UnequipItemEx  
    ChangeHeadPart  
    ReplaceHeadPart  
    UpdateWeight  


**Example**

    set $newGhostStatus 1  
    actor_doconsumer $system.self SetGhost $newGhostStatus  



### actor_dofunction

**Description**

For the targeted Actor, set $$ to the result of the specified Function
'Function' in this case specifically refers to functions that take one or more parameters and return a value
https://ck.uesp.net/wiki/Actor_Script

**Parameters**

    actor: target Actor  (accepts special variable names ($system.self, $system.player) and both relative "Skyrim.esm:0f" and absolute "0f" values)  
    function: function name  

    AddShout  
    AddSpell  
    DispelSpell  
    GetActorValue  
    GetActorValuePercentage  
    GetAV  
    GetAVPercentage  
    GetBaseActorValue  
    GetBaseAV  
    GetEquippedItemType  
    GetFactionRank  
    GetFactionReaction  
    GetRelationshipRank  
    HasAssociation  
    HasFamilyRelationship  
    HasLOS  
    HasMagicEffect  
    HasMagicEffectWithKeyword  
    HasParentRelationship  
    HasPerk  
    HasSpell  
    IsDetectedBy  
    IsEquipped  
    IsHostileToActor  
    IsInFaction  
    PathToReference  
    PlayIdle  
    PlayIdleWithTarget  
    RemoveShout  
    RemoveSpell  
    TrapSoul  
    WornHasKeyword  
    GetActorValueMax  
    GetAVMax  
    GetEquippedItemId  
    GetEquippedSpell  
    GetEquippedWeapon  
    GetEquippedArmorInSlot  
    GetWornForm  
    GetEquippedObject  
    GetNthSpell  


**Example**

    actor_dofunction $system.self GetBaseAV "Health"  
    ; $$ should contain a float value with the base "Health" Actor Value  



### actor_dogetter

**Description**

For the targeted Actor, set $$ to the result of the specified getter
'Getter' in this case specifically refers to functions that take no parameters but return a value
https://ck.uesp.net/wiki/Actor_Script

**Parameters**

    actor: target Actor  (accepts special variable names ($system.self, $system.player) and both relative "Skyrim.esm:0f" and absolute "0f" values)  
    getter: getter name  

    ;;;; These are from Actor  
    CanFlyHere  
    Dismount  
    GetActorBase  
    GetBribeAmount  
    GetCrimeFaction  
    GetCombatState  
    GetCombatTarget  
    GetCurrentPackage  
    GetDialogueTarget  
    GetEquippedShield  
    GetEquippedShout  
    GetFlyingState  
    GetForcedLandingMarker  
    GetGoldAmount  
    GetHighestRelationshipRank  
    GetKiller  
    GetLevel  
    GetLeveledActorBase  
    GetLightLevel  
    GetLowestRelationshipRank  
    GetNoBleedoutRecovery  
    GetPlayerControls  
    GetRace  
    GetSitState  
    GetSleepState  
    GetVoiceRecoveryTime  
    IsAlarmed  
    IsAlerted  
    IsAllowedToFly  
    IsArrested  
    IsArrestingTarget  
    IsBeingRidden - not a SexLab setting  
    IsBleedingOut  
    IsBribed  
    IsChild  
    IsCommandedActor  
    IsDead  
    IsDoingFavor  
    IsEssential  
    IsFlying  
    IsGhost  
    IsGuard  
    IsInCombat  
    IsInKillMove  
    IsIntimidated  
    IsOnMount - see IsBeingRidden  
    IsPlayersLastRiddenHorse - I don't even need to comment now, do I?  
    IsPlayerTeammate  
    IsRunning  
    IsSneaking  
    IsSprinting  
    IsTrespassing  
    IsUnconscious  
    IsWeaponDrawn  
    ;;;; These are from SKSE  
    GetSpellCount  
    IsAIEnabled  
    IsSwimming  
    ;;;; These are Special Edition exclusive  
    WillIntimidateSucceed  
    IsOverEncumbered  
    GetWarmthRating  


**Example**

    actor_dogetter $system.self CanFlyHere  
    if $$ = 1 ICanFlyAroundHere  
    if $$ = 0 IAmGroundedLikeAlways  



### actor_getfactionrank

**Description**

Sets $$ to the actor's rank in the faction indicated by the FormId

**Parameters**

    actor: target Actor  
    faction: FACTION FormID  


**Example**

    actor_getfactionrank $actor "skyrim.esm:378958"  



### actor_getgender

**Description**

Sets $$ to the actor's gender, 0 - male, 1 - female, 2 - creature, "" otherwise

**Parameters**

    actor: target Actor  


**Example**

    actor_getgender $actor  



### actor_getrelation

**Description**

Set $$ to the relationship rank between the two actors

**Parameters**

    first actor: target Actor  
    second actor: target Actor  


**Example**

    actor_getrelation $actor $system.player  

4  - Lover  
3  - Ally  
2  - Confidant  
1  - Friend  
0  - Acquaintance  
-1 - Rival  
-2 - Foe  
-3 - Enemy  
-4 - Archnemesis  


### actor_getscale

**Description**

Sets $$ to the 'scale' value of the specified Actor
Note: this is properly a function of ObjectReference, so may get pushed to a different group at some point

**Parameters**

    actor: target Actor  


**Example**

    actor_getscale $system.self  
    msg_console "Scale reported: " $$  



### actor_haskeyword

**Description**

Sets $$ to 1 if actor has the keyword, 0 otherwise.

**Parameters**

    actor: target Actor  
    keyword: string, keyword name  


**Example**

    actor_haskeyword $actor Vampire  



### actor_haslos

**Description**

Set $$ to 1 if first actor can see second actor, 0 if not.

**Parameters**

    first actor: target Actor  
    second actor: target Actor  


**Example**

    actor_haslos $actor $system.self  
    if $$ = 0 cannotseeme  



### actor_incskill

**Description**

Increase targeted actor's skill by specified amount

**Parameters**

    actor: target Actor  
    skill: skillname e.g. Alteration, Destruction  
    value: number  


**Example**

    actor_incskill $system.self Alteration 1  

Boost Alteration by 1 point  


### actor_infaction

**Description**

Sets $$ to 1 if actor is in the faction indicated by the FormId, 0 otherwise

**Parameters**

    actor: target Actor  
    faction: FACTION FormID  


**Example**

    actor_infaction $actor "skyrim.esm:378958"  

$$ will be 1 if $actor is a follower (CurrentFollowerFaction)  


### actor_isaffectedby

**Description**

Sets $$ to 1 if the specified actor is currently affected by the MGEF or SPEL indicated by FormID (accepts either)

**Parameters**

    actor: target Actor  
    (optional) "ALL": if specified, all following MGEF or SPEL FormIDs must be found on the target Actor  
    magic effect or spell: MGEF or SPEL FormID [<MGEF or SPEL FormID> <MGEF or SPEL FormID> ...]  


**Example**

    actor_isaffectedby $actor "skyrim.esm:1030541"  
    actor_isaffectedby $actor "skyrim.esm:1030541" "skyrim.esm:1030542" "skyrim.esm:1030543"  
    actor_isaffectedby $actor ALL "skyrim.esm:1030541" "skyrim.esm:1030542" "skyrim.esm:1030543"  



### actor_isguard

**Description**

Sets $$ to 1 if actor is guard, 0 otherwise.

**Parameters**

    actor: target Actor  


**Example**

    actor_isguard $actor  



### actor_isplayer

**Description**

Sets $$ to 1 if actor is the player, 0 otherwise.

**Parameters**

    actor: target Actor  


**Example**

    actor_isplayer $actor  



### actor_isvalid

**Description**

Set $$ to 1 if actor is valid, 0 if not.

**Parameters**

    actor: target Actor  


**Example**

    actor_isvalid $actor  
    if $$ = 0 end  
    ...  
    [end]  

Jump to the end if actor is not valid  


### actor_iswearing

**Description**

Sets $$ to 1 if actor is wearing the armor indicated by the FormId, 0 otherwise.

**Parameters**

    actor: target Actor  
    armor: ARMO FormID  


**Example**

    actor_iswearing $actor "petcollar.esp:31017"  



### actor_lochaskeyword

**Description**

Sets $$ to 1 if actor's current location has the indicated keyword, 0 otherwise.

**Parameters**

    actor: target Actor  
    keyword: string, keyword name  


**Example**

    actor_lochaskeyword $actor "LocTypeInn"  

In a bar, inn, or tavern  


### actor_modcrimegold

**Description**

Specified actor reports player, increasing bounty by specified amount.

**Parameters**

    actor: target Actor  
    bounty: number  


**Example**

    actor_modcrimegold $actor 100  



### actor_name

**Description**

Set $$ to the actor name

**Parameters**

    actor: target Actor  


**Example**

    actor_name $actor  



### actor_playanim

**Description**

Causes the actor to play the specified animation

**Parameters**

    actor: target Actor  
    animation: animation name  


**Example**

    actor_playanim $system.self "IdleChildCryingStart"  



### actor_qnnu

**Description**

Repaints actor (calls QueueNiNodeUpdate)

**Parameters**

    actor: target Actor  


**Example**

    actor_qnnu $actor  

Note: Do not call this too frequently as the rapid refreshes can causes crashes to desktop  


### actor_race

**Description**

Sets $$ to the race name based on sub-function. Blank, empty sub-function returns Vanilla racenames. e.g. "SL" can return SexLab race keynames.

**Parameters**

    actor: target Actor  
    sub-function: sub-function  

    if parameter 2 is "": return actors race name. Skyrims, original name. Like: "Nord", "Breton"  


**Example**

    actor_race $system.self ""  



### actor_race_type

**Description**

Returns the "race type". This is what the "Race" filter uses for filtering.
0 - error occurred
1 - Player
2 - Humanoid - Actor.HasKeyword(ActorTypeNPC)
3 - Undead - Actor.HasKeyword(ActorTypeUndead)
4 - Creature - presumed, default if nothing else matches

**Parameters**

    actor: target Actor  


**Example**

    actor_race_type $system.self  



### actor_removefaction

**Description**

Removes the actor from the specified faction

**Parameters**

    actor: target Actor  
    faction: FACTION FormID  


**Example**

    actor_removefaction $actor "skyrim.esm:3505"  



### actor_say

**Description**

Causes the actor to 'say' the topic indicated by FormId; not usable on the Player

**Parameters**

    actor: target Actor  
    topic: TOPIC FormID  


**Example**

    actor_say $actor "Skyrim.esm:1234"  



### actor_sendmodevent

**Description**

Causes the actor to send the mod event with the provided arguments

**Parameters**

    actor: target Actor  
    event: name of the event  
    string arg: string argument (meaning varies by event sent) (optional: default "")  
    float arg: float argument (meaning varies by event sent) (optional: default 0.0)  


**Example**

    actor_sendmodevent $system.self "IHaveNoIdeaButEventNamesShouldBeEasyToFind" "strarg" 20.0  



### actor_setalpha

**Description**

Set the Actor's alpha value (inverse of transparency, 1.0 is fully visible) (has no effect if IsGhost() returns true)

**Parameters**

    actor: target Actor  
    alpha: 0.0 to 1.0 (higher is more visible)  
    fade: 0 - instance | 1 - fade to the new alpha gradually (optional: default 1 - fade)  


**Example**

    actor_setalpha $system.self 0.5 1  

$system.self will fade to new alpha of 0.5, not instantly  


### actor_setfactionrank

**Description**

Sets the actor's rank in the faction indicated by the FormId to the indicated rank

**Parameters**

    actor: target Actor  
    faction: FACTION FormID  
    rank: number  


**Example**

    actor_setfactionrank $actor "skyrim.esm:378958" -1  



### actor_setrelation

**Description**

Set relationship rank between the two actors to the indicated value

**Parameters**

    first actor: target Actor  
    second actor: target Actor  
    rank: number  


**Example**

    actor_setrelation $actor $system.player 0  

See actor_getrelation for ranks  


### actor_setscale

**Description**

Sets the actor's scale to the specified value
Note: this is properly a function of ObjectReference, so may get pushed to a different group at some point

**Parameters**

    actor: target Actor  
    scale: float, new scale value to replace the old  


**Example**

    actor_setscale $system.self 1.01  



### actor_state

**Description**

Returns the state of the actor for a given sub-function

**Parameters**

    actor: target Actor  
    sub-function: sub-function  
    third argument: varies by sub-function  

    if parameter 2 is "GetCombatState": return actors combatstate. 0-no combat, 1-combat, 2-searching  
    if parameter 2 is "GetLevel": return actors level  
    if parameter 2 is "GetSleepState": return actors sleep mode. 0-not, 1-not, but wants to, 2-sleeping, 3-sleeping, but wants to wake up  
    if parameter 2 is "IsAlerted": is actor alerted  
    if parameter 2 is "IsAlarmed": is actor alerted  
    if parameter 2 is "IsPlayerTeammate": is actor PC team member  
    if parameter 2 is "SetPlayerTeammate" (parameter 3: <bool true to set, false to unset>): set actor as PC team member  
    if parameter 2 is "SendAssaultAlarm": actor will send out alarm  


**Example**

    actor_state $system.self "GetCombatState"  



### actor_wornhaskeyword

**Description**

Sets $$ to 1 if actor is wearing any armor with indicated keyword, 0 otherwise.

**Parameters**

    actor: target Actor  
    keyword: string, keyword name  


**Example**

    actor_wornhaskeyword $actor "VendorItemJewelry"  



### actor_worninslot

**Description**

Sets $$ to 1 if actor is wearing armor in the indicated slotId, 0 otherwise.

**Parameters**

    actor: target Actor  
    armorslot: number, e.g. 32 for body slot  


**Example**

    actor_worninslot $actor 32  



## Actor Value

### av_damage

**Description**

Damage actor value

**Parameters**

    actor: target Actor  
    av name: Actor Value name e.g. Health  
    amount: amount to damage  


**Example**

    av_damage $system.self Health 100  
    av_damage $system.self   $3   100 ;where $3 might be "Health"  

Damages Health by 100. This can result in death.  


### av_get

**Description**

Set $$ to the actor's current value for the specified Actor Value

**Parameters**

    actor: target Actor  
    av name: Actor Value name e.g. Health  


**Example**

    av_get $system.self Health  

Sets the actor's current Health into $$  


### av_getbase

**Description**

Sets $$ to the actor's base value for the specified Actor Value

**Parameters**

    actor: target Actor  
    av name: Actor Value name e.g. Health  


**Example**

    av_getbase $system.self Health  

Sets the actor's base Health into $$  


### av_getmax

**Description**

Set $$ to the actor's max value for the specified Actor Value

**Parameters**

    actor: target Actor  
    av name: Actor Value name e.g. Health  


**Example**

    av_get $system.self Health  

Sets the actor's max Health into $$  


### av_getpercentage

**Description**

Set $$ to the actor's value as a percentage of max for the specified Actor Value

**Parameters**

    actor: target Actor  
    av name: Actor Value name e.g. Health  


**Example**

    av_getpercentage $system.self Health  

Sets the actor's percentage of Health remaining into $$  


### av_mod

**Description**

Modify actor value

**Parameters**

    actor: target Actor  
    av name: Actor Value name e.g. Health  
    amount: amount to modify by  


**Example**

    av_mod $system.self Health 100  
    av_mod $system.self   $3   100 ;where $3 might be "Health"  

Changes the max value of the actor value. Not the same as restore/damage.  


### av_restore

**Description**

Restore actor value

**Parameters**

    actor: target Actor  
    av name: Actor Value name e.g. Health  
    amount: amount to restore  


**Example**

    av_restore $system.self Health 100  
    av_restore $system.self   $3   100 ;where $3 might be "Health"  

Restores Health by 100 e.g. healing  


### av_set

**Description**

Set actor value

**Parameters**

    actor: target Actor  
    av name: Actor Value name e.g. Health  
    amount: amount to modify by  


**Example**

    av_set $system.self Health 100  
    av_set $system.self   $3   100 ;where $3 might be "Health"  

Sets the value of the actor value.  


## ActorBase

### actorbase_doconsumer

**Description**

For the specified ActorBase, perform the requested consumer, provided the appropriate additional parameters
'Consumer' in this case specifically refers to functions that take parameters but return no result
https://ck.uesp.net/wiki/ActorBase_Script

**Parameters**

    actor: target ActorBase (accepts both relative "Skyrim.esm:0f" and absolute "0f" values)  
    consumer: consumer name  

    SetEssential  
    SetInvulnerable  
    SetProtected  
    SetOutfit  
    SetCombatStyle  
    SetClass  
    SetHeight  
    SetWeight  
    SetNthHeadPart  
    SetFaceMorph  
    SetFacePreset  
    SetHairColor  
    SetFaceTextureSet  
    SetVoiceType  
    SetSkin  
    SetSkinFar  


**Example**

    actorbase_doconsumer $actorBase SetInvulnerable true  



### actorbase_dofunction

**Description**

For the targeted ActorBase, set $$ to the result of the specified Function
'Function' in this case specifically refers to functions that take one or more parameters and return a value
https://ck.uesp.net/wiki/ActorBase_Script

**Parameters**

    actor: target ActorBase  (both relative "Skyrim.esm:0f" and absolute "0f" values)  
    function: function name  

    GetOutfit  
    GetNthHeadPart  
    GetIndexOfHeadPartByType  
    GetNthOverlayHeadPart  
    GetIndexOfOverlayHeadPartByType  
    GetFaceMorph  
    GetFacePreset  
    GetNthSpell  


**Example**

    set $spell resultfrom actorbase_dofunction $anActorBase GetNthSpell 0  



### actorbase_dogetter

**Description**

For the targeted ActorBase, return the value from the specified getter
'Getter' in this case specifically refers to functions that take no parameters but return a value
https://ck.uesp.net/wiki/ActorBase_Script

**Parameters**

    actor: target ActorBase  (accepts special variable names ($system.self, $system.player) and both relative "Skyrim.esm:0f" and absolute "0f" values)  
    getter: getter name  

    ;;;; These are from ActorBase  
    GetClass  
    GetDeadCount  
    GetGiftFilter  
    GetRace  
    GetSex  
    IsEssential  
    IsInvulnerable  
    IsProtected  
    IsUnique  
    ;;;; These are from SKSE  
    GetCombatStyle  
    GetHeight  
    GetWeight  
    GetNumHeadParts  
    GetNumOverlayHeadParts  
    GetHairColor  
    GetSpellCount  
    GetFaceTextureSet  
    GetVoiceType  
    GetSkin  
    GetSkinFar  
    GetTemplate  




## Core

### toh_elapsed_time

**Description**

Returns the actual game time passed at the time of the last "Top of the Hour"
For example, if you slept from 1:30 to 4:00, you would get a Top of the Hour event at 4 with a value of 2.5


**Example**

    toh_elapsed_time  

$$ would contain the actual elapsed game time from the previous "Top of the Hour" event  


## Form

### form_doaction

**Description**

For the targeted Form, perform the associated function based on the specified action
'Action' in this case specifically refers to functions that take no parameters and return no values
https://ck.uesp.net/wiki/Form_Script

**Parameters**

    form: target Form (accepts both relative "Skyrim.esm:0f" and absolute "0f" values)  
    action: action name  

    ;;;; These are from Form  
    RegisterForSleep  
    RegisterForTrackedStatsEvent  
    StartObjectProfiling  
    StopObjectProfiling  
    UnregisterForSleep  
    UnregisterForTrackedStatsEvent  
    UnregisterForUpdate  
    UnregisterForUpdateGameTime  
    ;;;; These are from SKSE  
    UnregisterForAllKeys  
    UnregisterForAllControls  
    UnregisterForAllMenus  
    RegisterForCameraState  
    UnregisterForCameraState  
    RegisterForCrosshairRef  
    UnregisterForCrosshairRef  
    RegisterForNiNodeUpdate  
    UnregisterForNiNodeUpdate  


**Example**

    form_doaction $system.self StopCombat  



### form_doconsumer

**Description**

For the specified Form, perform the requested consumer, provided the appropriate additional parameters
'Consumer' in this case specifically refers to functions that take parameters but return no result
https://ck.uesp.net/wiki/Form_Script

**Parameters**

    form: target Form (accepts both relative "Skyrim.esm:0f" and absolute "0f" values)  
    consumer: consumer name  

    SetPlayerKnows  
    SetWorldModelPath  
    SetName  
    SetWeight  
    SetGoldValue  
    SendModEvent  


**Example**

    actor_dogetter $system.player GetEquippedShield  
    set $shieldFormID $$  
    form_doconsumer $shieldFormID SetWeight 0.1 ; featherweight shield  



### form_dofunction

**Description**

For the targeted Form, set $$ to the result of the specified function
'Function' in this case specifically refers to functions that take one or more parameters and return a value
https://ck.uesp.net/wiki/Form_Script

**Parameters**

    actor: target Form  (accepts special variable names ($system.self, $system.player) and both relative "Skyrim.esm:0f" and absolute "0f" values)  
    function: function name  

    HasKeywordString  
    HasKeyword  
    GetNthKeyword  
    GetWorldModelNthTextureSet  


**Example**

    form_dofunction $system.self HasKeywordString "ActorTypeNPC"  
    ; $$ should contain true/false based on whether self has the indicated keyword  



### form_dogetter

**Description**

For the targeted Actor, set $$ to the result of the specified getter
'Getter' in this case specifically refers to functions that take no parameters but return a value
https://ck.uesp.net/wiki/Form_Script

**Parameters**

    form: target Form (accepts both relative "Skyrim.esm:0f" and absolute "0f" values)  
    getter: getter name  

    ;;;; T79686hese are from Form  
    GetFormID  
    GetGoldValue  
    PlayerKnows  
    ;;;; These are from SKSE  
    GetType  
    GetName  
    GetWeight  
    GetNumKeywords  
    IsPlayable  
    HasWorldModel  
    GetWorldModelPath  
    GetWorldModelNumTextureSets  
    TempClone  


**Example**

    form_dogetter $system.self IsPlayable  
    if $$ = 1 itwasplayable  



### form_getbyid

**Description**

Performs a lookup for a Form and returns it if found; returns none otherwise
Accepts FormID as: "modfile.esp:012345", "012345" (absolute ID), "anEditorId" (will attempt an editorId lookup)
Note that if multiple mods introduce an object with the same editorId, the lookup would only return whichever one won

**Parameters**

    formID: FormID as: "modfile.esp:012345", "012345" (absolute ID), "anEditorId" (will attempt an editorId lookup)  


**Example**

    form_getbyid "Ale"  
    form_dogetter $$ GetName  
    msg_notify $$ "!! Yay!!"  
    ; Ale!! Yay!!  



## GlobalVariable

### global_getvalue

**Description**

Finds the indicated GlobalVariable and returns its current value as a float.

**Parameters**

    formID: FormID as: "modfile.esp:012345", "012345" (absolute ID), "anEditorId" (will attempt an editorId lookup)  


**Example**

    global_getvalue "GameDaysPassed"  
    $$ will contain the number of in-game days passed as a float  



### global_setvalue

**Description**

Finds the indicated GlobalVariable and sets its current value.

**Parameters**

    formID: FormID as: "modfile.esp:012345", "012345" (absolute ID), "anEditorId" (will attempt an editorId lookup)  
    newValue: float  


**Example**

    global_setvalue "_Dwill" 20.0  
    Sets the Devious Followers willpower global to 20.0  



## Imagespace Modifier

### ism_applyfade

**Description**

Apply imagespace modifier - per original author, check CreationKit, SpecialEffects\Imagespace Modifier

**Parameters**

    item: ITEM FormID  
    duration: fade duration in seconds  


**Example**

    ism_applyfade $1 2  



### ism_removefade

**Description**

Remove imagespace modifier - per original author, check CreationKit, SpecialEffects\Imagespace Modifier

**Parameters**

    item: ITEM FormID  
    duration: fade duration in seconds  


**Example**

    ism_removefade $1 2  



## Items

### item_add

**Description**

Adds the item to the actor's inventory.

**Parameters**

    actor: target Actor  
    item: ITEM FormId  
    count: number (optional: default 1)  
    displaymessage: 0 - show message | 1 - silent (optional: default 0 - show message)  


**Example**

    item_add $system.self "skyrim.esm:15" 10 0  

Adds 10 gold to the actor, displaying the notification  


### item_addex

**Description**

Adds the item to the actor's inventory, but check if some armor was re-equipped (if NPC)

**Parameters**

    actor: target Actor  
    item: ITEM FormId  
    count: number (optional: default 1)  
    displaymessage: 0 - show message | 1 - silent (optional: default 0 - show message)  


**Example**

    item_addex $system.self "skyrim.esm:15" 10 0  



### item_adduse

**Description**

Add item (like item_add) and then use the added item. Useful for potions, food, and other consumables.

**Parameters**

    actor: target Actor  
    item: ITEM FormId  
    count: number (optional: default 1)  
    displaymessage: 0 - show message | 1 - silent (optional: default 0 - show message)  


**Example**

    item_adduse $system.self "skyrim.esm:216158" 1 0  

Add and drink some booze  


### item_equip

**Description**

Equip item ("vanilla" version)

**Parameters**

    actor: target Actor  
    item: ITEM FormId  
    preventRemoval: false - removal allowed | true - removal not allowed  
    sound: false - no sound | true - with sound  
    <actor variable> <ITEM FormId> <false - removal allowed | true - removal not allowed> <false - no sound | true - with sound>  


**Example**

    item_equip $system.self "ZaZAnimationPack.esm:159072" true false  

Equip the ZaZ armor on $system.self, silently, with no removal allowed (uses whatever slot the armor uses)  


### item_equipex

**Description**

Equip item (SKSE version)

**Parameters**

    actor: target Actor  
    item: ITEM FormId  
    armorslot: number e.g. 32 for body slot  
    sound: 0 - no sound | 1 - with sound  
    removalallowed: 0 - removal allowed | 1 - removal not allowed  


**Example**

    item_equipex $system.self "ZaZAnimationPack.esm:159072" 32 0 1  

Equip the ZaZ armor on $system.self, at body slot 32, silently, with no removal allowed  
Equips item directly, Workaround for "NPCs re-equip all armor, if they get an item that looks like armor"  


### item_getcount

**Description**

Set $$ to how many of a specified item an actor has

**Parameters**

    actor: target Actor  
    item: ITEM FormId  


**Example**

    item_getcount $system.self "skyrim.esm:15"  



### item_remove

**Description**

Remove the item from the actor's inventory

**Parameters**

    actor: target Actor  
    item: ITEM FormId  
    count: number  
    displaymessage: 0 - show message | 1 - silent (optional: default 0 - show message)  


**Example**

    item_remove $system.self "skyrim.esm:15" 10 0  

Removes up to 10 gold from the actor  


### item_unequipex

**Description**

Unequip item

**Parameters**

    actor: target Actor  
    item: ITEM FormId  
    armorslot: number e.g. 32 for body slot  


**Example**

    item_unequipex $system.self "ZaZAnimationPack.esm:159072" 32  

Unequips the ZaZ armor from slot 32 on $system.self  


## JSON

### json_getvalue

**Description**

Sets $$ to value from JSON file (uses PapyrusUtil/JsonUtil)

**Parameters**

    filename: name of file, rooted from 'Data/SKSE/Plugins/sl_triggers'  
    datatype: int, float, string  
    key: the key  
    default: default value in case it isn't present (optional: default for type)  


**Example**

    json_getvalue "../somefolder/afile" float "demofloatvalue" 2.3  

JsonUtil automatically appends .json when not given a file extension  


### json_save

**Description**

Tells JsonUtil to immediately save the specified file from cache

**Parameters**

    filename: name of file, rooted from 'Data/SKSE/Plugins/sl_triggers'  


**Example**

    json_save "../somefolder/afile"  



### json_setvalue

**Description**

Sets a value in a JSON file (uses PapyrusUtil/JsonUtil)

**Parameters**

    filename: name of file, rooted from 'Data/SKSE/Plugins/sl_triggers'  
    datatype: int, float, string  
    key: the key  
    new value: value to set  


**Example**

    json_setvalue "../somefolder/afile" float "demofloatvalue" 2.3  

JsonUtil automatically appends .json when not given a file extension  


## MfgFix

### mfg_getphonememodifier

**Description**

Return facial expression (requires MfgFix https://www.nexusmods.com/skyrimspecialedition/mods/11669)

**Parameters**

    actor: target Actor  
    mode: number, 0 - set phoneme | 1 - set modifier  
    id: an id (I'm not familiar with MfgFix :/)  


**Example**

    mfg_getphonememodifier $system.self 0 $1  



### mfg_reset

**Description**

Resets facial expression (requires MfgFix https://www.nexusmods.com/skyrimspecialedition/mods/11669)

**Parameters**

    actor: target Actor  


**Example**

    mfg_reset $system.self  



### mfg_setphonememodifier

**Description**

Set facial expression (requires MfgFix https://www.nexusmods.com/skyrimspecialedition/mods/11669)

**Parameters**

    actor: target Actor  
    mode: number, 0 - set phoneme | 1 - set modifier  
    id: an id  (I'm not familiar with MfgFix :/)  
    value: int  
    <actor variable> <mode> <id> <value>  


**Example**

    mfg_setphonememodifier $system.self 0 $1 $2  



## NiOverride

### apply_overlay

**Description**

use NiOverride to apply change/parameters to overlay in previous functions

**Parameters**

    actor: target Actor  




### changeoverlay_transparency

**Description**

use NiOverride to change overlay transparency

**Parameters**

    actor: target Actor  
    isFemale : bool  
    nodeName (see getoverlay function) : string  
    transparency : float  




### getoverlay_slot

**Description**

use NiOverride to get free overlay slot

**Parameters**

    actor: target Actor  
    isFemale : bool  
    node (body, face, etc...) : string  




### param_overlay

**Description**

use NiOverride to params overlays

**Parameters**

    actor: target Actor  
    isFemale : bool  
    nodeName (see getoverlay function) : string  
    tattoo : string  
    transparency : float  




### remove_overlay

**Description**

use NiOverride to remove overlay

**Parameters**

    actor: target Actor  
    isFemale : bool  
    nodeName (see getoverlay function) : string  
    transparency : float  




## ObjectReference

### objectreference_doaction

**Description**

For the targeted ObjectReference, perform the associated function based on the specified action
'Action' in this case specifically refers to functions that take no parameters and return no values
https://ck.uesp.net/wiki/ObjectReference_Script

**Parameters**

    objectreference: target ObjectReference  (accepts both relative "Skyrim.esm:0f" and absolute "0f" values)  
    action: action name  

    ;;;; These are from ObjectReference  
    ClearDestruction  
    Delete  
    DeleteWhenAble  
    ForceAddRagdollToWorld  
    ForceRemoveRagdollFromWorld  
    InterruptCast  
    MoveToMyEditorLocation  
    RemoveAllInventoryEventFilters  
    StopTranslation  
    ;;;; These are from SKSE  
    ResetInventory  
    ;;;; will call form_doaction if no matches are found  


**Example**

    objectreference_doaction $system.self StopCombat  



### objectreference_doconsumer

**Description**

For the specified ObjectReference, perform the requested consumer, provided the appropriate additional parameters
'Consumer' in this case specifically refers to functions that take parameters but return no result
https://ck.uesp.net/wiki/ObjectReference_Script

**Parameters**

    objectreference: target ObjectReference (accepts both relative "Skyrim.esm:0f" and absolute "0f" values)  
    consumer: consumer name  

    Activate  
    AddInventoryEventFilter  
    AddItem  
    AddKeyIfNeeded  
    AddToMap  
    ApplyHavokImpulse  
    BlockActivation  
    CreateDetectionEvent  
    DamageObject  
    Disable  
    DisableLinkChain  
    DisableNoWait  
    DropObject  
    Enable  
    EnableFastTravel  
    EnableLinkChain  
    EnableNoWait  
    IgnoreFriendlyHits  
    KnockAreaEffect  
    Lock  
    MoveTo  
    MoveToInteractionLocation  
    MoveToNode  
    PlayTerrainEffect  
    ProcessTrapHit  
    PushActorAway  
    RemoveAllItems  
    RemoveInventoryEventFilter  
    RemoveItem  
    Reset  
    Say  
    SendStealAlarm  
    SetActorCause  
    SetActorOwner  
    SetAngle  
    SetAnimationVariableBool  
    SetAnimationVariableFloat  
    SetAnimationVariableInt  
    SetDestroyed  
    SetFactionOwner  
    SetLockLevel  
    SetMotionType  
    SetNoFavorAllowed  
    SetOpen  
    SetPosition  
    SetScale  
    SplineTranslateTo  
    SplineTranslateToRef  
    SplineTranslateToRefNode  
    TetherToHorse  
    TranslateTo  
    TranslateToRef  
    SetHarvested  
    SetItemHealthPercent  
    SetItemMaxCharge  
    SetItemCharge  
    SetEnchantment  
    CreateEnchantment  


**Example**

    actor_dogetter $system.player GetEquippedShield  
    set $shieldFormID $$  
    objectreference_doconsumer $shieldFormID CreateEnchantment 200.0 "Skyrim.esm:form-id-for-MGEF" 20.0 0.0 30.0  



### objectreference_dofunction

**Description**

For the targeted ObjectReference, set $$ to the result of the specified function
'Function' in this case specifically refers to functions that take one or more parameters and return a value
https://ck.uesp.net/wiki/ObjectReference_Script

**Parameters**

    actor: target ObjectReference  (accepts special variable names ($system.self, $system.player) and both relative "Skyrim.esm:0f" and absolute "0f" values)  
    function: function name  

    CalculateEncounterLevel  
    CountLinkedRefChain  
    GetAnimationVariableBool  
    GetAnimationVariableFloat  
    GetAnimationVariableInt  
    GetDistance  
    GetHeadingAngle  
    GetItemCount  
    HasEffectKeyword  
    HasNode  
    HasRefType  
    IsActivateChild  
    IsFurnitureInUse  
    IsFurnitureMarkerInUse  
    IsInLocation  
    MoveToIfUnloaded  
    PlayAnimation  
    PlayAnimationAndWait  
    PlayGamebryoAnimation  
    PlayImpactEffect  
    PlaySyncedAnimationAndWaitSS  
    PlaySyncedAnimationSS  
    RampRumble  
    WaitForAnimationEvent  
    SetDisplayName  
    GetNthForm  
    PlaceActorAtMe  
    PlaceAtMe  
    GetLinkedRef  
    GetNthLinkedRef  


**Example**

    set $containerFormID "AContainerEditorIDForExample"  
    objectreference_dofunction $system.self GetItemCount $containerFormID  
    ; $$ should contain an int value with the number of items in the container  



### objectreference_dogetter

**Description**

For the targeted ObjectReference, set $$ to the result of the specified getter
'Getter' in this case specifically refers to functions that take no parameters but return a value
https://ck.uesp.net/wiki/ObjectReference_Script

**Parameters**

    objectreference: target ObjectReference  (accepts both relative "Skyrim.esm:0f" and absolute "0f" values)  
    getter: getter name  

    ;;;; These are from ObjectReference  
    CanFastTravelToMarker  
    GetActorOwner  
    GetAngleX  
    GetAngleY  
    GetAngleZ  
    GetBaseObject  
    GetCurrentDestructionStage  
    GetCurrentLocation  
    GetCurrentScene  
    GetEditorLocation  
    GetFactionOwner  
    GetHeight  
    GetItemHealthPercent  
    GetKey  
    GetLength  
    GetLockLevel  
    GetMass  
    GetOpenState  
    GetParentCell  
    GetPositionX  
    GetPositionY  
    GetPositionZ  
    GetScale  
    GetTriggerObjectCount  
    GetVoiceType  
    GetWidth  
    GetWorldSpace  
    IsActivationBlocked  
    Is3DLoaded  
    IsDeleted  
    IsDisabled  
    IsEnabled  
    IsIgnoringFriendlyHits  
    IsInDialogueWithPlayer  
    IsInInterior  
    IsLocked  
    IsMapMarkerVisible  
    IsNearPlayer  
    ;;;; These are from SKSE  
    GetNumItems  
    GetTotalItemWeight  
    GetTotalArmorWeight  
    IsHarvested  
    GetItemMaxCharge  
    GetItemCharge  
    IsOffLimits  
    GetDisplayName  
    GetEnableParent  
    GetEnchantment  
    GetNumReferenceAliases  


**Example**

    objectreference_dogetter $system.self CanFlyHere  
    if $$ = 1 ICanFlyAroundHere  
    if $$ = 0 IAmGroundedLikeAlways  



## PapyrusUtil

### jsonutil

**Description**

Wrapper around most JsonUtil functions

**Parameters**

    <sub-function> - JsonUtil functionality to perform  
    <filename> - JSON file to interact with  

    Valid sub-functions are:  
    load              : <filename>  
    save              : <filename>  
    ispendingsave     : <filename>  
    isgood            : <filename>  
    geterrors         : <filename>  
    exists            : <filename>  
    unload            : <filename> [saveChanges: 0 - false | 1 - true] [minify: 0 - false | 1 - true]  
    set               : <filename> <key> <type: int | float | string | form> <value>  
    get               : <filename> <key> <type: int | float | string | form> [<default value>]  
    unset             : <filename> <key> <type: int | float | string | form>  
    has               : <filename> <key> <type: int | float | string | form>  
    adjust            : <filename> <key> <type: int | float>          <amount>  
    listadd           : <filename> <key> <type: int | float | string | form> <value>  
    listget           : <filename> <key> <type: int | float | string | form> <index>  
    listset           : <filename> <key> <type: int | float | string | form> <index> <value>  
    listremoveat      : <filename> <key> <type: int | float | string | form> <index>  
    listinsertat      : <filename> <key> <type: int | float | string | form> <index> <value>  
    listclear         : <filename> <key> <type: int | float | string | form>  
    listcount         : <filename> <key> <type: int | float | string | form>  
    listcountvalue    : <filename> <key> <type: int | float | string | form> <value> [<exclude: 0 - false | 1 - true>]  
    listfind          : <filename> <key> <type: int | float | string | form> <value>  
    listhas           : <filename> <key> <type: int | float | string | form> <value>  
    listresize        : <filename> <key> <type: int | float | string | form> <toLength> [<filler value>]  
    listslice         : <filename> <key> <type: int | float | string | form> <slice length> [<startIndex = 0>] ; returns a typed list e.g. int[]  
    listcopy          : <filename> <key> <type: int | float | string | form> <list variable | value [value ... ] >  
    listtoarray       : <filename> <key> <type: int | float | string | form> ; returns a typed list e.g. int[]  


**Example**

    Example from the regression test script:  
    set $testfile "../sl_triggers/commandstore/jsonutil_function_test"  
      
    inc $thread.testCount  
    set $flag resultfrom jsonutil exists $testfile  
    if $flag  
    inc $thread.passCount  
    deb_msg $"PASS: jsonutil exists ({flag})"  
    else  
    deb_msg $"FAIL: jsonutil exists ({flag})"  
    endif  
      
    inc $thread.testCount  
    set $avalue resultfrom jsonutil set $testfile "key1" "string" "avalue"  
    if $avalue == "avalue"  
    inc $thread.passCount  
    deb_msg $"PASS: jsonutil set ({avalue})"  
    else  
    deb_msg $"FAIL: jsonutil set ({avalue})"  
    endif  
      
    inc $thread.testCount  
    set $hasworks resultfrom jsonutil has $testfile "key1" "string"  
    if $hasworks  
    inc $thread.passCount  
    deb_msg $"PASS: jsonutil has ({hasworks})"  
    else  
    deb_msg $"FAIL: jsonutil has ({hasworks})"  
    endif  
      
    inc $thread.testCount  
    set $unsetworks resultfrom jsonutil unset $testfile "key1" "string"  
    if $unsetworks  
    inc $thread.passCount  
    deb_msg $"PASS: jsonutil unset ({unsetworks})"  
    else  
    deb_msg $"FAIL: jsonutil unset ({unsetworks})"  
    endif  
      
    inc $thread.testCount  
    set $hasalsoworks resultfrom jsonutil has $testfile "key1" "string"  
    if $hasalsoworks  
    deb_msg $"FAIL: jsonutil unset or has is failing ({hasalsoworks})"  
    else  
    inc $thread.passCount  
    deb_msg $"PASS: jsonutil unset/has ({hasalsoworks})"  
    endif  
      
    inc $thread.testCount  
    set $setfloatworks resultfrom jsonutil set $testfile "key1" "float" "87"  
    if $setfloatworks == 87  
    inc $thread.passCount  
    deb_msg $"PASS: jsonutil set with float ({setfloatworks})"  
    else  
    deb_msg $"FAIL: jsonutil set with float ({setfloatworks})"  
    endif  
      
    inc $thread.testCount  
    set $checktypes resultfrom jsonutil has $testfile "key1" "string"  
    if $checktypes  
    deb_msg $"FAIL: has failed, crossed the streams float and string? ({setfloatworks})"  
    else  
    inc $thread.passCount  
    deb_msg $"PASS: has success ({setfloatworks})"  
    endif  
      
    inc $thread.testCount  
    jsonutil listclear $testfile  "somelist" "int"  
      
    jsonutil listadd $testfile  "somelist"  "int"  1  
    jsonutil listadd $testfile  "somelist"  "int"  2  
    jsonutil listadd $testfile  "somelist"  "int"  3  
    jsonutil listadd $testfile  "somelist"  "int"  1  
      
    set $listcount resultfrom jsonutil listcount $testfile "somelist" "int"  
    if $listcount == 4  
    inc $thread.passCount  
    deb_msg $"PASS: listclear/listadd/listcount ({setfloatworks})"  
    else  
    deb_msg $"FAIL: listclear/listadd/listcount; one has failed ({setfloatworks})"  
    endif  
      
    jsonutil save $testfile  



### storageutil

**Description**

Wrapper around most StorageUtil functions

**Parameters**

    <sub-function> - StorageUtil functionality to perform  
    <form identifier> - object to interact with; see below for details  

    <form identifier> - represents the object you want StorageUtil activity keyed to  
    StorageUtil accepts 'none' (null) to represent "global" StorageUtil space  
    For SLTScript purposes, any identifier that will resolve to a Form object can be used  
    Or you may specify the empty string ("") for the global space  
    For example, any of the following might be valid:  
    $system.self, $system.player, $actor   ; these all resolve to Actor  
    "sl_triggers.esp:3426"   ; the FormID for the main Quest object for sl_triggers  
    Read more about StorageUtil for more details  
    Valid sub-functions are:  
    set               : <form identifier> <key> <type: int | float | string | form> <value>  
    get               : <form identifier> <key> <type: int | float | string | form> [<default value>]  
    pluck             : <form identifier> <key> <type: int | float | string | form> [<default value>]  
    unset             : <form identifier> <key> <type: int | float | string | form>  
    has               : <form identifier> <key> <type: int | float | string | form>  
    adjust            : <form identifier> <key> <type: int | float>          <amount>  
    listadd           : <form identifier> <key> <type: int | float | string | form> <value>  
    listget           : <form identifier> <key> <type: int | float | string | form> <index>  
    listpluck         : <form identifier> <key> <type: int | float | string | form> <index> <default value>  
    listset           : <form identifier> <key> <type: int | float | string | form> <index> <value>  
    listremoveat      : <form identifier> <key> <type: int | float | string | form> <index>  
    listinsertat      : <form identifier> <key> <type: int | float | string | form> <index> <value>  
    listadjust        : <form identifier> <key> <type: int | float | string | form> <index> <amount>  
    listclear         : <form identifier> <key> <type: int | float | string | form>  
    listpop           : <form identifier> <key> <type: int | float | string | form>  
    listshift         : <form identifier> <key> <type: int | float | string | form>  
    listsort          : <form identifier> <key> <type: int | float | string | form>  
    listcount         : <form identifier> <key> <type: int | float | string | form>  
    listcountvalue    : <form identifier> <key> <type: int | float | string | form> <value> [<exclude: 0 - false | 1 - true>]  
    listfind          : <form identifier> <key> <type: int | float | string | form> <value>  
    listhas           : <form identifier> <key> <type: int | float | string | form> <value>  
    listresize        : <form identifier> <key> <type: int | float | string | form> <toLength> [<filler value>]  
    listslice         : <form identifier> <key> <type: int | float | string | form> <slice length> [<startIndex = 0>] ; returns a typed list e.g. int[]  
    listcopy          : <form identifier> <key> <type: int | float | string | form> <list variable | value [value ... ] >  
    listtoarray       : <form identifier> <key> <type: int | float | string | form> ; returns a typed list e.g. int[]  


**Example**

    Example usage from the regression tests  
    set $suhost $system.player  
      
    inc $thread.testCount  
    set $result resultfrom storageutil set $suhost "key1" "string" "avalue"  
    if $result == "avalue"  
    inc $thread.passCount  
    deb_msg $"PASS: storageutil set ({result})"  
    else  
    deb_msg $"FAIL: storageutil set ({result})"  
    endif  
      
    inc $thread.testCount  
    set $result resultfrom storageutil has $suhost "key1" "string"  
    if $result  
    inc $thread.passCount  
    deb_msg $"PASS: storageutil has ({result})"  
    else  
    deb_msg $"FAIL: storageutil has ({result})"  
    endif  
      
    inc $thread.testCount  
    set $result resultfrom storageutil unset $suhost "key1" "string"  
    if $result  
    inc $thread.passCount  
    deb_msg $"PASS: storageutil unset ({result})"  
    else  
    deb_msg $"FAIL: storageutil unset ({result})"  
    endif  
      
    inc $thread.testCount  
    set $result resultfrom storageutil has $suhost "key1" "string"  
    if $result  
    deb_msg $"FAIL: storageutil unset ({result})"  
    else  
    inc $thread.passCount  
    deb_msg $"PASS: storageutil unset ({result})"  
    endif  
      
    inc $thread.testCount  
    set $result resultfrom storageutil set $suhost "key1" "float" "87"  
    if $result == 87  
    inc $thread.passCount  
    deb_msg $"PASS: storageutil set float ({result})"  
    else  
    deb_msg $"FAIL: storageutil set float ({result})"  
    endif  
      
    inc $thread.testCount  
    set $result resultfrom storageutil has $suhost "key1" "string"  
    if $result  
    deb_msg $"FAIL: storageutil unset/has ({result})"  
    else  
    inc $thread.passCount  
    deb_msg $"PASS: storageutil unset/has ({result})"  
    endif  
      
    inc $thread.testCount  
    storageutil listclear $suhost  "somelist" "int"  
      
    storageutil listadd $suhost  "somelist"  "int"  1  
    storageutil listadd $suhost  "somelist"  "int"  2  
    storageutil listadd $suhost  "somelist"  "int"  3  
    storageutil listadd $suhost  "somelist"  "int"  1  
      
    set $result resultfrom storageutil listcount $suhost "somelist" "int"  
    if $result == 4  
    inc $thread.passCount  
    deb_msg $"PASS: storageutil listclear/listadd/listcount ({result})"  
    else  
    deb_msg $"FAIL: storageutil listclear/listadd/listcount ({result})"  
    endif  



## Perks

### perk_add

**Description**

Add specified perk to the targeted actor

**Parameters**

    perk: PERK FormID  
    actor: target Actor  


**Example**

    perk_add "skyrim.esm:12384" $system.self  



### perk_addpoints

**Description**

Add specified number of perk points to player

**Parameters**

    perkpointcount: number of perk points to add  


**Example**

    perk_addpoints 4  



### perk_remove

**Description**

Remove specified perk from the targeted actor

**Parameters**

    perk: PERK FormID  
    actor: target Actor  


**Example**

    perk_remove "skyrim.esm:12384" $system.self  



## Sound

### snd_play

**Description**

Return the sound instance handle from playing the specified audio from the specified actor

**Parameters**

    audio: AUDIO FormID  
    actor: target Actor  


**Example**

    snd_play "skyrim.esm:318128" $system.self  



### snd_setvolume

**Description**

Set the sound volume using the specified sound instance handle (from snd_play)

**Parameters**

    handle: sound instance handle from snd_play  
    actor: target Actor  
    volume: 0.0 - 1.0  


**Example**

    snd_setvolume $1 0.5  

Set the volume of the audio sound playing with handle stored in $1 to 50%  


### snd_stop

**Description**

Stops the audio specified by the sound instance handle (from snd_play)

**Parameters**

    handle: sound instance handle from snd_play  


**Example**

    snd_stop $1  



## Spells

### spell_add

**Description**

Adds the specified SPEL by FormId to the targeted Actor, usually to add as an available power or spell in the spellbook.

**Parameters**

    spell: SPEL FormId  
    actor: target Actor  


**Example**

    spell_add "skyrim.esm:275236" $system.self  

The light spell is now in the actor's spellbook  


### spell_cast

**Description**

Cast spell at target

**Parameters**

    spell: SPEL FormID  
    actor: target Actor  


**Example**

    spell_cast "skyrim.esm:275236" $system.self  

Casts light spell on self  


### spell_dcsa

**Description**

Casts spell with DoCombatSpellApply Papyrus function. It is usually used for spells that
are part of a melee attack (like animals that also carry poison or disease).

**Parameters**

    spell: SPEL FormId  
    actor: target Actor  


**Example**

    spell_dcsa "skyrim.esm:275236" $system.self  



### spell_dispel

**Description**

Dispels specified SPEL by FormId from targeted Actor

**Parameters**

    spell: SPEL FormId  
    actor: target Actor  


**Example**

    spell_dispel "skyrim.esm:275236" $system.self  

If light was currently on $system.self, it would now be dispelled  


### spell_remove

**Description**

Removes the specified SPEL by FormId from the targeted Actor, usually to remove as an available power or spell in the spellbook.

**Parameters**

    spell: SPEL FormId  
    actor: target Actor  


**Example**

    spell_remove "skyrim.esm:275236" $system.self  

The light spell should no longer be in the actor's spellbook  


## TopicInfo

### topicinfo_getresponsetext

**Description**

Attempts to return a single response text associated with the provided TopicInfo (by editorID or FormID)
Note: This is more beta than normal; it isn't obvious whether in some cases multiple strings should actually be returned.

**Parameters**

    topicinfo: <formID> or <editorID> for the desired TopicInfo (not Topic)  


**Example**

    topicinfo_getresponsetext "Skyrim.esm:0x00020954"  
    msg_notify $$  
    ; $$ would contain "I used to be an adventurer like you. Then I took an arrow in the knee..."  



## Utility

### console

**Description**

Executes the console command (requires a ConsoleUtil variant installed
Recommend ConsoleUtil-Extended https://www.nexusmods.com/skyrimspecialedition/mods/133569)

**Parameters**

    actor: target Actor  
    command: <command fragment> [<command fragment> ...] ; all <command fragments> will be concatenated  


**Example**

    console $system.self "sgtm" "" "0.5"  
    console $system.self "sgtm 0.5"  

Both are the same  


### deb_msg

**Description**

Joins all <msg> arguments together and logs to "<Documents>\My Games\Skyrim Special Edition\SKSE\sl-triggers.log"
This file is truncated on game start.

**Parameters**

    message: <msg> [<msg> <msg> ...]  
    arguments: ALTERNATIVE: <string list>  


**Example**

    deb_msg "Hello" "world!"  
    deb_msg "Hello world!"  

Both do the same thing  


### math

**Description**

Return values from math operations based on sub-function

**Parameters**

    sub-function: sub-function  
    variable: variable 3 varies by sub-function  

    if parameter 2 1s "asint": return parameter 3 as integer  
    if parameter 2 1s "floor": return parameter 3 the largest integer less than or equal to the value  
    if parameter 2 1s "ceiling": return parameter 3 the smallest integer greater than or equal to the value  
    if parameter 2 1s "abs": return parameter 3 as absolute value of the passed in value - N for N, and N for (-N)  
    if parameter 2 1s "toint": return parameter 3 as integer. Parameter 3 can be in dec or hex. If it starts with 0, its converted as hex value  


**Example**

    math floor 1.2  



### msg_console

**Description**

Display the message in the console

**Parameters**

    message: <msg> [<msg> <msg> ...]  
    arguments: ALTERNATIVE: <string list>  


**Example**

    msg_console "Hello" "world!"  
    msg_console "Hello world!"  

Both are the same  


### msg_notify

**Description**

Display the message in the standard notification area (top left of your screen by default)

**Parameters**

    message: <msg> [<msg> <msg> ...]  
    arguments: ALTERNATIVE: <string list>  


**Example**

    msg_notify "Hello" "world!"  
    msg_notify "Hello world!"  

Both are the same  


### rnd_float

**Description**

Sets $$ to a random integer between min and max inclusive

**Parameters**

    min: number  
    max: number  


**Example**

    rnd_float 1 100  



### rnd_int

**Description**

Sets $$ to a random integer between min and max inclusive

**Parameters**

    min: number  
    max: number  


**Example**

    rnd_int 1 100  



### rnd_list

**Description**

Sets $$ to one of the arguments at random

**Parameters**

    arguments: <argument> <argument> [<argument> <argument> ...]  
    arguments: ALTERNATIVE: <string list>  


**Example**

    rnd_list "Hello" $2 "Yo"  

$$ will be one of the values. $2 will be resolved to it's value before populating $$  


### util_game

**Description**

Perform game related functions based on sub-function

**Parameters**

    sub-function: sub-function  
    parameter: varies by sub-function  

    if sub-function is "IncrementStat", (parameter 3, <stat name>, parameter 4, <amount>), see https://ck.uesp.net/wiki/IncrementStat_-_Game  
    if sub-function is "QueryStat", (parameter 3, <stat name>), returns the value  


**Example**

    util_game "IncrementStat" "Bribes" 1  



### util_getgametime

**Description**

Sets $$ to the value of Utility.GetCurrentGameTime() (a float value representing the number of days in game time; mid-day day 2 is 1.5)


**Example**

    util_getgametime  



### util_getgametime

**Description**

Sets $$ to the in-game hour (i.e. 2:30 AM returns 2)


**Example**

    util_getgametime  



### util_getrandomactor

**Description**

Sets $iterActor to a random actor within specified range of self

**Parameters**

    range: 0 - all | >0 skyrim units  


**Example**

    util_getrandomactor 320  



### util_getrealtime

**Description**

Sets $$ to the value of Utility.GetCurrentRealTime() (a float value representing the number of seconds since Skyrim.exe was launched this session)


**Example**

    util_getrealtime  



### util_getrndactor

**Description**

Return a random actor within specified range of self

**Parameters**

    range: (0 - all | >0 - range in Skyrim units)  
    option: (0 - all | 1 - not in SexLab scene | 2 - must be in SexLab scene) (optional: default 0 - all)  


**Example**

    util_getrndactor 500 2  
    actor_isvalid $actor  
    if $$ = 0 end  
    msg_notify "Someone is watching you!"  
    [end]  



### util_sendevent

**Description**

Send SKSE custom event, with each type/value pair being an argument to the custom event

**Parameters**

    event: name of the event  
    (type/value pairs are optional; this devolves to util_sendmodevent <eventname>, though with such a call the event signature would require having no arguments)  
    param type: type of parameter e.g. "bool", "int", etc.  
    param value: value of parameter  
    [type/value, type/value ...]  

    <type> can be any of [bool, int, float, string, form]  


**Example**

    util_sendevent "slaUpdateExposure" form $system.self float 33  

The "slaUpdateExposure" event will be sent with $system.self, and the float value of 33.0 as the two arguments  


### util_sendmodevent

**Description**

Shorthand for actor_sendmodevent $system.player <event name> <string argument> <float argument>

**Parameters**

    event: name of the event  
    string arg: string argument (meaning varies by event sent) (optional: default "")  
    float arg: float argument (meaning varies by event sent) (optional: default 0.0)  


**Example**

    util_sendmodevent "IHaveNoIdeaButEventNamesShouldBeEasyToFind" "strarg" 0.0  



### util_wait

**Description**

Wait specified number of seconds i.e. Utility.Wait()

**Parameters**

    duration: float, seconds  


**Example**

    util_wait 2.5  

The script will pause processing for 2.5 seconds  


### util_waitforkbd

**Description**

Sets $$ to the keycode pressed after waiting for user to press any of the specified keys.
(See https://ck.uesp.net/wiki/Input_Script for the DXScanCodes)

**Parameters**

    dxscancode: <DXScanCode of key> [<DXScanCode of key> ...]  
    arguments: ALTERNATIVE: <int list>  


**Example**

    util_waitforkbd 74 78 181 55  



### weather_state

**Description**

Weather related functions based on sub-function

**Parameters**

    <sub-function> ; currently only GetClassification  


**Example**

    weather_state GetClassification  



# SLTriggers Redux SexLab P+ Function Library 

## Actor

### actor_race

**Description**

Returns the race name based on sub-function. Blank, empty sub-function returns Vanilla racenames. e.g. "SL" can return SexLab race keynames.

**Parameters**

    actor: target Actor  
    sub-function: sub-function  

    if parameter 2 is "": return actors race name. Skyrims, original name. Like: "Nord", "Breton"  
    if parameter 2 is "SL": return actors Sexlab frameworks race key name. Like: "dogs", "bears", etc. Note: will return "" if actor is humanoid  


**Example**

    actor_race $system.self "SL"  
    msg_notify "  Race SL: " $$  



## SexLab P+

### actor_getgender

**Description**

Returns the actor's SexLab gender, 0 - male, 1 - female, 2 - creature

**Parameters**

    actor: target Actor  


**Example**

    actor_getgender $actor  



### sl_advance

**Description**

Changes the stage of the current SexLab scene, for the target Actor; advances a single stage if positive, reverses a single stage if negative

**Parameters**

    direction: integer, <negative - backwards / non-negative (including zero) - forwards>  
    actor: target Actor  


**Example**

    sl_advance -3 $system.self  

Only goes back one stage  


### sl_animname

**Description**

Sets $$ to the current SexLab animation name


**Example**

    sl_animname $system.self  
    msg_notify "Playing: " $$  



### sl_disableorgasm

**Description**

Disables or enables the ability to orgasm via standard SexLab sex activity (orgasms can still be forced by mods)
Only works if called during a scene, when the SexLab thread is still available

**Parameters**

    actor: target Actor  
    disable: 1 to disable, 0 to enable  


**Example**

    sl_disableorgasm $system.player 1  
    ; this disables orgasm for the player  
    sl_disableorgasm $system.player 0  
    ; this enables orgasm for the player  



### sl_getprop

**Description**

Sets $$ to the value of the requested property

**Parameters**

    property:  Stage | ActorCount  
    actor: target Actor  


**Example**

    sl_getprop Stage $system.self  
    msg_notify "Current Stage: " $$  



### sl_getrndactor

**Description**

Return a random actor within specified range of self

**Parameters**

    range: (0 - all | >0 - range in Skyrim units)  
    option: (0 - all | 1 - not in SexLab scene | 2 - must be in SexLab scene) (optional: default 0 - all)  


**Example**

    sl_getrndactor 500 2  
    actor_isvalid $actor  
    if $$ = 0 end  
    msg_notify "Someone is watching you!"  
    [end]  



### sl_hastag

**Description**

Sets $$ to 1 if the SexLab scene has the specified tag, 0 otherwise

**Parameters**

    tag: tag name e.g. "Oral", "Anal", "Vaginal"  
    actor: target Actor  


**Example**

    sl_hastag "Oral" $system.self  
    if $$ = 1 ORAL  



### sl_isin

**Description**

Sets $$ to 1 if the specified actor is in a SexLab scene, 0 otherwise

**Parameters**

    actor: target Actor  


**Example**

    sl_isin $system.self  



### sl_isinslot

**Description**

Sets $$ to 1 if the specified actor is in the specified SexLab scene slot, 0 otherwise

**Parameters**

    actor: target Actor  
    slotnumber: 1-based SexLab thread slot number  


**Example**

    sl_isinslot $system.player 1  



### sl_orgasm

**Description**

Immediately forces the specified actor to have a SexLab orgasm.

**Parameters**

    actor: target Actor  


**Example**

    sl_orgasm $system.self  
    sl_orgasm $system.partner  

Simultaneous orgasms  


### sl_waitforkbd

**Description**

Returns the keycode pressed after waiting for user to press any of the specified keys or for the end of the SexLab scene
(See https://ck.uesp.net/wiki/Input_Script for the DXScanCodes)

**Parameters**

    actor: target Actor  
    dxscancode: DXScanCode of key [<DXScanCode of key> ...]  
    arguments: ALTERNATIVE: <int list>  


**Example**

    sl_waitforkbd 74 78 181 55  
    if $$ = 74 MINUS  
    ...  
    if $$ < 0 END  

Wait for Num-, Num+, Num/, or Num*, or animation expired, and then do something based on the result.  


### util_waitforend

**Description**

Wait until specified actor is not in SexLab scene

**Parameters**

    actor: target Actor  


**Example**

    util_waitforend $system.self  

Wait until the scene ends  


# SLTriggers Redux SexLab 1.66 Function Library 

## Actor

### actor_race

**Description**

Returns the race name based on sub-function. Blank, empty sub-function returns Vanilla racenames. e.g. "SL" can return SexLab race keynames.

**Parameters**

    actor: target Actor  
    sub-function: sub-function  

    if parameter 2 is "": return actors race name. Skyrims, original name. Like: "Nord", "Breton"  
    if parameter 2 is "SL": return actors Sexlab frameworks race key name. Like: "dogs", "bears", etc. Note: will return "" if actor is humanoid  


**Example**

    actor_race $system.self "SL"  
    msg_notify "  Race SL: " $$  



## SexLab

### actor_getgender

**Description**

Returns the actor's SexLab gender, 0 - male, 1 - female, 2 - creature

**Parameters**

    actor: target Actor  


**Example**

    actor_getgender $actor  



### sl_advance

**Description**

Changes the stage of the current SexLab scene, for the target Actor; advances a single stage if positive, reverses a single stage if negative

**Parameters**

    direction: integer, <negative - backwards / non-negative (including zero) - forwards>  
    actor: target Actor  


**Example**

    sl_advance -3 $system.self  

Only goes back one stage  


### sl_animname

**Description**

Sets $$ to the current SexLab animation name


**Example**

    sl_animname $system.self  
    msg_notify "Playing: " $$  



### sl_disableorgasm

**Description**

Disables or enables the ability to orgasm via standard SexLab sex activity (orgasms can still be forced by mods)
Only works if called during a scene, when the SexLab thread is still available

**Parameters**

    actor: target Actor  
    disable: 1 to disable, 0 to enable  


**Example**

    sl_disableorgasm $system.player 1  
    ; this disables orgasm for the player  
    sl_disableorgasm $system.player 0  
    ; this enables orgasm for the player  



### sl_getprop

**Description**

Sets $$ to the value of the requested property

**Parameters**

    property:  Stage | ActorCount  
    actor: target Actor  


**Example**

    sl_getprop Stage $system.self  
    msg_notify "Current Stage: " $$  



### sl_getrndactor

**Description**

Return a random actor within specified range of self

**Parameters**

    range: (0 - all | >0 - range in Skyrim units)  
    option: (0 - all | 1 - not in SexLab scene | 2 - must be in SexLab scene) (optional: default 0 - all)  


**Example**

    sl_getrndactor 500 2  
    actor_isvalid $actor  
    if $$ = 0 end  
    msg_notify "Someone is watching you!"  
    [end]  



### sl_hastag

**Description**

Sets $$ to 1 if the SexLab scene has the specified tag, 0 otherwise

**Parameters**

    tag: tag name e.g. "Oral", "Anal", "Vaginal"  
    actor: target Actor  


**Example**

    sl_hastag "Oral" $system.self  
    if $$ = 1 ORAL  



### sl_isin

**Description**

Sets $$ to 1 if the specified actor is in a SexLab scene, 0 otherwise

**Parameters**

    actor: target Actor  


**Example**

    sl_isin $system.self  



### sl_isinslot

**Description**

Sets $$ to 1 if the specified actor is in the specified SexLab scene slot, 0 otherwise

**Parameters**

    actor: target Actor  
    slotnumber: 1-based SexLab thread slot number  


**Example**

    sl_isinslot $system.player 1  



### sl_orgasm

**Description**

Immediately forces the specified actor to have a SexLab orgasm.

**Parameters**

    actor: target Actor  


**Example**

    sl_orgasm $system.self  
    sl_orgasm $system.partner  

Simultaneous orgasms  


### sl_waitforkbd

**Description**

Returns the keycode pressed after waiting for user to press any of the specified keys or for the end of the SexLab scene
(See https://ck.uesp.net/wiki/Input_Script for the DXScanCodes)

**Parameters**

    actor: target Actor  
    dxscancode: DXScanCode of key [<DXScanCode of key> ...]  
    arguments: ALTERNATIVE: <int list>  


**Example**

    sl_waitforkbd 74 78 181 55  
    if $$ = 74 MINUS  
    ...  
    if $$ < 0 END  

Wait for Num-, Num+, Num/, or Num*, or animation expired, and then do something based on the result.  


### util_waitforend

**Description**

Wait until specified actor is not in SexLab scene

**Parameters**

    actor: target Actor  


**Example**

    util_waitforend $system.self  

Wait until the scene ends  


## SexLab Separate Orgasms

### slso_bonus_enjoyment

**Description**

Applies BonusEnjoyment to the specified actor

**Parameters**

    actor: target Actor  
    enjoyment: int, 1-100?  


**Example**

    slso_bonus_enjoyment $system.self 30  



# SLTriggers Redux SexLab Dependent Function Library 

## Devious Devices

### dd_unlockall

**Description**

Attempts to unlock all devices locked on the actor

**Parameters**

    actor: target Actor  
    force: "force" to force an unlock, anything else otherwise  


**Example**

    dd_unlockall $self force  

Will attempt to (forcibly if necessary, e.g. quest locked items) unlock all lockable items on targeted actor.  


### dd_unlockslot

**Description**

Attempts to unlock any device in the specified slot

**Parameters**

    actor: target Actor  
    armorslot: int value armor slot e.g. 32 is body armor  
    force: "force" to force an unlock, anything else otherwise  


**Example**

    dd_unlockslot $self 32 force  

Should remove anything in body slot e.g. corset, harness, etc., and forced, so including quest items (be careful!)  


## Devious Followers

### df_resetall

**Description**

Resets all Devious Followers values (i.e. quest states, deal states, boredom, debt)
back to values as if having just started out.


**Example**

    df_resetall  

Should be free of all debts, deals, and rules  


### df_setdebt

**Description**

Sets current debt to the specified amount

**Parameters**

    newdebt: new debt value  


**Example**

    df_setdebt 0  

We all know what you are going to use it for  


## SexLab Aroused/OSLAroused

### sla_get_actor_days_since_last_orgasm

**Description**

Returns the days since the actor last had an orgasm as a float

**Parameters**

    actor: target Actor  


**Example**

    sla_get_actor_days_since_last_orgasm $system.self  



### sla_get_arousal

**Description**

Returns the current arousal of the actor as an int

**Parameters**

    actor: target Actor  


**Example**

    sla_get_arousal  



### sla_get_exposure

**Description**

Returns the current exposure level of the actor as an int

**Parameters**

    actor: target Actor  


**Example**

    sla_get_exposure $system.self  



### sla_get_version

**Description**

Returns the version of SexLabAroused or OSLAroused


**Example**

    sla_get_version  
    msg_console "Version is: " $$  



### sla_send_exposure_event

**Description**

Sends the "slaUpdateExposure" modevent. No return value.

**Parameters**

    actor: target Actor  
    exposureAmount: float; amount of exposure update to send  


**Example**

    sla_send_exposure_event $system.self 5.0  



### sla_set_exposure

**Description**

Sets the exposure for the target actor and returns the new amount as an int

**Parameters**

    actor: target Actor  
    exposureAmount: int; amount of exposure update to set  


**Example**

    sla_set_exposure $system.self 25  



### sla_update_exposure

**Description**

Updates the exposure for the target actor and returns the updated amount as an int.
This uses the API, not a modevent directly (though the API may still be sending a modevent behind the scenes)

**Parameters**

    actor: target Actor  
    exposureAmount: int; amount of exposure update to apply  


**Example**

    sla_update_exposure $system.self 5  



# SLTriggers Redux OStim Function Library 

## OStim

### ostim_actorcount

**Description**

Returns the actorcount of the OStim scene the targetActor is in; 0 if not in a scene

**Parameters**

    Actor: targetActor: the actor whose scene you want the actor count from  


**Example**

    ostim_actorcount $system.self  



### ostim_animname

**Description**

Sets $$ to the current OStim animation name


**Example**

    ostim_animname $system.self  
    msg_notify "Playing: " $$  



### ostim_climax

**Description**

Immediately forces the specified actor to have a OStim orgasm.
May only work during OStim scenes

**Parameters**

    actor: target Actor  
    bool: ignoreStall: (optional; default:false) should the ClimaxStalled setting be ignored  


**Example**

    ostim_climax $system.self  
    ostim_climax $system.partner  

Simultaneous orgasms  


### ostim_findaction

**Description**

int: Returns the action index if the OStim scene metadata has the specified action, -1 otherwise

**Parameters**

    string: action: action name e.g. "vaginalsex", "analsex", "blowjob"  
    actor: (optional; default:Player) target Actor  


**Example**

    ostim_findaction "blowjob" $system.self  
    if $$ = true [doORALthing]  



### ostim_getrndactor

**Description**

Return a random actor within specified range of self

**Parameters**

    range: (0 - all | >0 - range in Skyrim units)  
    option: (0 - all | 1 - not in OStim scene | 2 - must be in OStim scene) (optional: default 0 - all)  


**Example**

    ostim_getrndactor 500 2  
    actor_isvalid $actor  
    if $$ = 0 end  
    msg_notify "Someone is watching you!"  
    [end]  



### ostim_getsceneid

**Description**

string: returns the SceneID the targetActor is in; "" if not in a scene


**Example**

    ostim_getsceneid $system.self  
    msg_notify "SceneID: " $$  



### ostim_getthreadid

**Description**

int: returns the ThreadID for the OStim thread the target actor is in; -1 if not in a thread


**Example**

    ostim_getthreadid $system.self  



### ostim_hasaction

**Description**

bool: Returns true if the OStim scene metadata has the specified action, false otherwise

**Parameters**

    string: action: action name e.g. "vaginalsex", "analsex", "blowjob"  
    actor: (optional; default:Player) target Actor  


**Example**

    ostim_hasaction "blowjob" $system.self  
    if $$ = true [doORALthing]  



### ostim_isclimaxstalled

**Description**

returns whether the actor is prevented from climaxing

**Parameters**

    actor: target Actor  


**Example**

    ostim_isclimaxstalled $system.player  



### ostim_isin

**Description**

Sets $$ to true if the specified actor is in a OStim scene, false otherwise

**Parameters**

    actor: target Actor  


**Example**

    ostim_isin $system.self  



### ostim_isinslot

**Description**

Sets $$ to true if the specified actor is in the specified OStim scene slot, false otherwise

**Parameters**

    actor: target Actor  
    slotnumber: 1-based OStim actor position number  


**Example**

    ostim_isinslot $system.player 1  



### ostim_permitclimax

**Description**

permits this actor to climax again (as in it undoes ostim_stallclimax)

**Parameters**

    actor: target Actor  


**Example**

    ostim_permitclimax $system.player  



### ostim_stallclimax

**Description**

prevents this actor from climaxing, including the prevention of auto climax animations
does not prevent the climaxes of auto climax animations that already started

**Parameters**

    actor: target Actor  


**Example**

    ostim_stallclimax $system.player  



### ostim_waitforkbd

**Description**

Returns the keycode pressed after waiting for user to press any of the specified keys or for the end of the OStim scene
(See https://ck.uesp.net/wiki/Input_Script for the DXScanCodes)

**Parameters**

    actor: target Actor  
    dxscancode: DXScanCode of key [<DXScanCode of key> ...]  
    arguments: ALTERNATIVE: <int list>  


**Example**

    ostim_waitforkbd 74 78 181 55  
    if $$ = 74 MINUS  
    ...  
    if $$ < 0 END  

Wait for Num-, Num+, Num/, or Num*, or animation expired, and then do something based on the result.  


### util_waitforend

**Description**

Wait until specified actor is not in OStim scene

**Parameters**

    actor: target Actor  


**Example**

    util_waitforend $self  

Wait until the scene ends  


# SLTriggers Redux Adult General Function Library 

## OSLAroused

### osla_get_actor_days_since_last_orgasm

**Description**

Sets $$ to the result of OSLAroused_ModInterface.GetArousal()

**Parameters**

    actor: target Actor  


**Example**

    osla_get_actor_days_since_last_orgasm $self  
    msg_console "Arousal is: " $$  



### osla_get_arousal

**Description**

Sets $$ to the result of OSLAroused_ModInterface.GetArousal()

**Parameters**

    actor: target Actor  


**Example**

    osla_get_arousal $self  
    msg_console "Arousal is: " $$  



### osla_get_arousal_multiplier

**Description**

Sets $$ to the result of OSLAroused_ModInterface.GetArousal()

**Parameters**

    actor: target Actor  


**Example**

    osla_get_arousal_multiplier $self  
    msg_console "Arousal multiplier is: " $$  



### osla_get_exposure

**Description**

Sets $$ to the result of OSLAroused_ModInterface.GetArousal()

**Parameters**

    actor: target Actor  


**Example**

    osla_get_exposure $self  
    msg_console "Exposure is: " $$  



### osla_modify_arousal

**Description**

Sets $$ to the result of OSLAroused_ModInterface.ModifyArousal(Actor, float, string)

**Parameters**

    actor: target Actor  
    value: float value  
    reason: string, optional (default "unknown")  


**Example**

    osla_modify_arousal $self 20.0 "for reasons"  



### osla_modify_arousal_multiplier

**Description**

Sets $$ to the result of OSLAroused_ModInterface.ModifyArousalMultiplier(Actor, float, string)

**Parameters**

    actor: target Actor  
    value: float value  
    reason: string, optional (default "unknown")  


**Example**

    osla_modify_arousal_multiplier $self 0.5 "for reasons"  



### osla_set_arousal

**Description**

Sets $$ to the result of OSLAroused_ModInterface.SetArousal(Actor, float, string)

**Parameters**

    actor: target Actor  
    value: float value  
    reason: string, optional (default "unknown")  


**Example**

    osla_set_arousal $self 50.0 "for reasons"  



### osla_set_arousal_multiplier

**Description**

Sets $$ to the result of OSLAroused_ModInterface.SetArousalMultiplier(Actor, float, string)

**Parameters**

    actor: target Actor  
    value: float value  
    reason: string, optional (default "unknown")  


**Example**

    osla_set_arousal_multiplier $self 2.0 "for reasons"  



