# SLTriggers Redux Base Function Library 

## Actor

### actor_advskill

**Description**

Advance targeted actor's skill by specified amount. Only works on Player.

**Parameters**

    Form: actor: target Actor  
    string: skill: skillname e.g. Alteration, Destruction  
    float: value: number  


**Example**

    actor_advskill $system.self Alteration 1  

Boost Alteration by 1 point  
Note: Currently only works on PC/Player  


### actor_body

**Description**

Returns: (varies): Alters or queries information about the actor's body, based on sub-function

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

Returns: string: the actor displayName

**Parameters**

    Form: actor: target Actor  


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

    actor: target Actor (accepts both relative "Skyrim.esm:0xf" and absolute "0xf" values)  
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
    ;;;; will call objectreference_doconsumer if no matches are found  


**Example**

    ; make the script target an ally of the player's  
    actor_doconsumer $system.self SetRelationshipRank $system.player 3  



### actor_dofunction

**Description**

For the targeted Actor, set $$ to the result of the specified Function
'Function' in this case specifically refers to functions that take one or more parameters and return a value
https://ck.uesp.net/wiki/Actor_Script

**Parameters**

    actor: target Actor  (accepts special variable names ($system.self, $system.player) and both relative "Skyrim.esm:0xf" and absolute "0xf" values)  
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
    ;;;; will call objectreference_dofunction if no matches are found  


**Example**

    ; to get the target's base health  
    set $selfBaseHealth resultfrom actor_dofunction $system.self GetBaseAV "Health"  



### actor_dogetter

**Description**

For the targeted Actor, set $$ to the result of the specified getter
'Getter' in this case specifically refers to functions that take no parameters but return a value
https://ck.uesp.net/wiki/Actor_Script

**Parameters**

    actor: target Actor  (accepts special variable names ($system.self, $system.player) and both relative "Skyrim.esm:0xf" and absolute "0xf" values)  
    getter: getter name  

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
    IsBeingRidden  
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
    IsOnMount  
    IsPlayersLastRiddenHorse  
    IsPlayerTeammate  
    IsRunning  
    IsSneaking  
    IsSprinting  
    IsTrespassing  
    IsUnconscious  
    IsWeaponDrawn  
    GetSpellCount  
    IsAIEnabled  
    IsSwimming  
    WillIntimidateSucceed  
    IsOverEncumbered  
    GetWarmthRating  
    ;;;; will call objectreference_dogetter if no matches are found  


**Example**

    ; respond to combat status  
    set $isFighting resultfrom actor_dogetter $system.self IsInCombat  
    if $isFighting [IsFighting]  
    ; do non-fighting things  
    ; respond to whether they are sneaking (perhaps bypassing traps you were going to script in?)  
    set $isSneaking resultfrom actor_dogetter $system.self IsSneaking  
    if $isSneaking [DoNothingAndExit]  
    ; now do whatever you were planning to do, since the target is not sneaking  



### actor_getfactionrank

**Description**

Returns: int: the actor's rank in the faction indicated by the FormId

**Parameters**

    Form: actor: target Actor  
    Form: faction: the Faction  


**Example**

    actor_getfactionrank $actor "skyrim.esm:378958"  



### actor_getgender

**Description**

Returns: int: the actor's gender, 0 - male, 1 - female, -1 - None

**Parameters**

    Form: actor: target Actor  


**Example**

    actor_getgender $actor  



### actor_getrelation

**Description**

Returns: int: the relationship rank between the two actors

**Parameters**

    Form: first actor: target Actor  
    Form: second actor: target Actor  


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

Returns: float: the 'scale' value of the specified Actor
Note: this is properly a function of ObjectReference, so may get pushed to a different group at some point

**Parameters**

    Form: actor: target Actor  


**Example**

    actor_getscale $system.self  
    msg_console "Scale reported: " $$  



### actor_haskeyword

**Description**

Returns: bool: true if actor has the keyword, false otherwise.

**Parameters**

    Form: actor: target Actor  
    string: keyword: keyword name  


**Example**

    actor_haskeyword $actor Vampire  



### actor_haslos

**Description**

Returns: bool: true if first actor can see second actor, false if not.

**Parameters**

    Form: first actor: target Actor  
    Form: second actor: target Actor  


**Example**

    actor_haslos $actor $system.self  
    if $$ = false cannotseeme  



### actor_incskill

**Description**

Increase targeted actor's skill by specified amount.
For the Player, this uses Game.IncrementSkillBy()
For all other Actors, this uses Actor.ModActorValue()

**Parameters**

    Form: actor: target Actor  
    string: skill: skillname e.g. Alteration, Destruction  
    float: value: number  


**Example**

    actor_incskill $system.self Alteration 1  

Boost Alteration by 1 point  


### actor_infaction

**Description**

Returns: bool: true if actor is in the faction indicated by the FormId, false otherwise

**Parameters**

    Form: actor: target Actor  
    Form: faction: the Faction  


**Example**

    actor_infaction $actor "skyrim.esm:378958"  

$$ will be true if $actor is a follower (CurrentFollowerFaction)  


### actor_isaffectedby

**Description**

Returns: bool: true if the specified actor is currently affected by the MGEF or SPEL indicated by FormID (accepts either); false otherwise

**Parameters**

    Form: actor: target Actor  
    (optional) "ALL": if specified, all following MGEF or SPEL FormIDs must be found on the target Actor  
    Form: mgef: MGEF (Magic Effect) or SPEL (Spell) to check for  
    ; are they affected by all of the effectts (AND)  
    Usage 1: actor_isaffectedby $system.self ALL "skyrim.esm:1030541" "skyrim.esm:1030542" "skyrim.esm:1030543"  
    ; are they affected by any of the effectts (OR)  
    Usage 2: actor_isaffectedby $system.self "skyrim.esm:1030541" "skyrim.esm:1030542" "skyrim.esm:1030543"  




### actor_isguard

**Description**

Returns: bool: true if actor is guard, 1 otherwise.

**Parameters**

    actor: target Actor  


**Example**

    actor_isguard $actor  



### actor_isplayer

**Description**

Returns: bool: true if actor is the player, false otherwise.

**Parameters**

    Form: actor: target Actor  


**Example**

    actor_isplayer $actor  



### actor_isvalid

**Description**

Returns: bool: true if actor is valid, false if not.

**Parameters**

    Form: actor: target Actor  


**Example**

    actor_isvalid $actor  
    if $$ = false end  
    ...  
    [end]  

Jump to the end if actor is not valid  


### actor_iswearing

**Description**

Returns: bool: true if actor is wearing the armor indicated by the FormId, false otherwise.

**Parameters**

    actor: target Actor  
    armor: ARMO FormID  


**Example**

    actor_iswearing $actor "petcollar.esp:31017"  



### actor_lochaskeyword

**Description**

Returns: bool: true if actor's current location has the indicated keyword, false otherwise.

**Parameters**

    Form: actor: target Actor  
    string: keyword: keyword name  


**Example**

    actor_lochaskeyword $actor "LocTypeInn"  

In a bar, inn, or tavern  


### actor_modcrimegold

**Description**

Specified actor reports player, increasing bounty by specified amount.

**Parameters**

    Form: actor: target Actor  
    int: bountyMod: amount to modify bounty by  


**Example**

    actor_modcrimegold $actor 100  



### actor_name

**Description**

Returns: string: the actor name

**Parameters**

    Form: actor: target Actor  


**Example**

    actor_name $actor  



### actor_playanim

**Description**

Causes the actor to play the specified animation

**Parameters**

    Form: actor: target Actor  
    string: animation: animation name  


**Example**

    actor_playanim $system.self "IdleChildCryingStart"  



### actor_qnnu

**Description**

Repaints actor (calls QueueNiNodeUpdate)

**Parameters**

    Form: actor: target Actor  


**Example**

    actor_qnnu $actor  

Note: Do not call this too frequently as the rapid refreshes can causes crashes to desktop  


### actor_race

**Description**

Returns: string: the race name based on sub-function. Blank, empty sub-function returns Vanilla racenames. e.g. "SL" can return SexLab race keynames.

**Parameters**

    Form: actor: target Actor  
    string: sub-function: sub-function  

    if parameter 2 is "": return actors race name. Skyrims, original name. Like: "Nord", "Breton"  


**Example**

    actor_race $system.self ""  



### actor_race_type

**Description**

Returns: int: the "race type". This is what the "Race" filter uses for filtering.

**Parameters**

    Form: actor: target Actor  


**Example**

    actor_race_type $system.self  

0 - error occurred  
1 - Player  
2 - Humanoid - Actor.HasKeyword(ActorTypeNPC)  
3 - Undead - Actor.HasKeyword(ActorTypeUndead)  
4 - Creature - presumed, default if nothing else matches  


### actor_removefaction

**Description**

Removes the actor from the specified faction

**Parameters**

    Form: actor: target Actor  
    Form: faction: target Faction  


**Example**

    actor_removefaction $actor "skyrim.esm:3505"  



### actor_say

**Description**

Causes the actor to 'say' the topic indicated by FormId; not usable on the Player

**Parameters**

    Form: actor: target Actor  
    Form topic: the TopicInfo to say  


**Example**

    actor_say $actor "Skyrim.esm:1234"  



### actor_sendmodevent

**Description**

Causes the actor to send the mod event with the provided arguments

**Parameters**

    Form: actor: target Actor  
    string: event: name of the event  
    string: args: string argument (meaning varies by event sent) (optional: default "")  
    float: argf: float argument (meaning varies by event sent) (optional: default 0.0)  


**Example**

    actor_sendmodevent $system.self "IHaveNoIdeaButEventNamesShouldBeEasyToFind" "strarg" 20.0  



### actor_setalpha

**Description**

Set the Actor's alpha value (inverse of transparency, 1.0 is fully visible) (has no effect if IsGhost() returns true)

**Parameters**

    Form: actor: target Actor  
    float: alpha: 0.0 to 1.0 (higher is more visible)  
    bool: fade: false - instant | true - fade to the new alpha gradually (optional: default true - fade)  


**Example**

    actor_setalpha $system.self 0.5 true  

$system.self will fade to new alpha of 0.5, not instantly  


### actor_setfactionrank

**Description**

Sets the actor's rank in the faction indicated by the FormId to the indicated rank

**Parameters**

    Form: actor: target Actor  
    Form: faction: target Faction  
    int: rank: new faction rank  


**Example**

    actor_setfactionrank $actor "skyrim.esm:378958" -1  



### actor_setrelation

**Description**

Set relationship rank between the two actors to the indicated value

**Parameters**

    Form: first actor: target Actor  
    Form: second actor: target Actor  
    int: rank: new rank  


**Example**

    actor_setrelation $actor $system.player 0  

See actor_getrelation for ranks  


### actor_setscale

**Description**

Sets the actor's scale to the specified value
Note: this is properly a function of ObjectReference, so may get pushed to a different group at some point

**Parameters**

    Form: actor: target Actor  
    scale: float, new scale value to replace the old  


**Example**

    actor_setscale $system.self 1.01  



### actor_state

**Description**

Returns: (varies): the state of the actor for a given sub-function

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



### actor_submerged_level

**Description**

Returns: float: Get the Actor's level of water submersion (from 0.0 to 1.0; 0.0 meaning not touching water, and 1.0 being fully submerged)

**Parameters**

    Form: actor: target Actor  


**Example**

    set $submersion resultfrom actor_submerged_level $system.self  
    ; at about $submersion 0.65 or so, you are chest high and likely to start having to swim  



### actor_wornhaskeyword

**Description**

Returns: bool: true if actor is wearing any armor with indicated keyword, false otherwise.

**Parameters**

    Form: actor: target Actor  
    string: keyword: keyword name  


**Example**

    actor_wornhaskeyword $actor "VendorItemJewelry"  



### actor_worninslot

**Description**

Returns: bool: true if actor is wearing armor in the indicated slotId, false otherwise.

**Parameters**

    Form: actor: target Actor  
    int: armorslot: number, e.g. 32 for body slot  


**Example**

    actor_worninslot $actor 32  



## Actor Value

### av_damage

**Description**

Damage actor value

**Parameters**

    Form: actor: target Actor  
    string: av name: Actor Value name e.g. Health  
    float: amount: amount to damage  


**Example**

    av_damage $system.self Health 100  
    av_damage $system.self   $3   100 ;where $3 might be "Health"  

; both of these damage Health by 100. This can result in death.  


### av_get

**Description**

Returns: float: the actor's current value for the specified Actor Value

**Parameters**

    Form: actor: target Actor  
    string: av name: Actor Value name e.g. Health  


**Example**

    av_get $system.self Health  

Sets the actor's current Health into $$  


### av_getbase

**Description**

Returns: float: the actor's base value for the specified Actor Value

**Parameters**

    Form: actor: target Actor  
    string: av name: Actor Value name e.g. Health  


**Example**

    float: av_getbase $system.self Health  

Sets the actor's base Health into $$  


### av_getmax

**Description**

Returns: float: the actor's max value for the specified Actor Value

**Parameters**

    Form: actor: target Actor  
    string: av name: Actor Value name e.g. Health  


**Example**

    av_getmax $system.self Health  

Sets the actor's max Health into $$  


### av_getpercentage

**Description**

Returns: float: the actor's value as a percentage of max for the specified Actor Value

**Parameters**

    Form: actor: target Actor  
    string: av name: Actor Value name e.g. Health  


**Example**

    av_getpercentage $system.self Health  

Sets the actor's percentage of Health remaining into $$  


### av_mod

**Description**

Modify actor value

**Parameters**

    Form: actor: target Actor  
    string: av name: Actor Value name e.g. Health  
    float: amount: amount to modify by  


**Example**

    av_mod $system.self Health 100  
    av_mod $system.self   $3   100 ;where $3 might be "Health"  

; Changes the max value of the actor value. Not the same as restore/damage.  


### av_restore

**Description**

Restore actor value

**Parameters**

    Form: actor: target Actor  
    string: av name: Actor Value name e.g. Health  
    float: amount: amount to restore  


**Example**

    av_restore $system.self Health 100  
    av_restore $system.self   $3   100 ;where $3 might be "Health"  

; both of these restore Health by 100 e.g. healing  


### av_set

**Description**

Set actor value

**Parameters**

    Form: actor: target Actor  
    string: av name: Actor Value name e.g. Health  
    float: amount: amount to modify by  


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

    actor: target ActorBase (accepts both relative "Skyrim.esm:0xf" and absolute "0xf" values)  
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
    ;;;; will call form_doconsumer if no matches are found  


**Example**

    ; make the target invulnerable  
    set $selfBase resultfrom actor_dogetter $system.self GetActorBase  
    actorbase_doconsumer $selfBase SetInvulnerable true  



### actorbase_dofunction

**Description**

For the targeted ActorBase, set $$ to the result of the specified Function
'Function' in this case specifically refers to functions that take one or more parameters and return a value
https://ck.uesp.net/wiki/ActorBase_Script

**Parameters**

    actor: target ActorBase  (both relative "Skyrim.esm:0xf" and absolute "0xf" values)  
    function: function name  

    GetOutfit  
    GetNthHeadPart  
    GetIndexOfHeadPartByType  
    GetNthOverlayHeadPart  
    GetIndexOfOverlayHeadPartByType  
    GetFaceMorph  
    GetFacePreset  
    GetNthSpell  
    ;;;; will call form_dofunction if no matches are found  


**Example**

    set $spell resultfrom actorbase_dofunction $anActorBase GetNthSpell 0  



### actorbase_dogetter

**Description**

For the targeted ActorBase, return the value from the specified getter
'Getter' in this case specifically refers to functions that take no parameters but return a value
https://ck.uesp.net/wiki/ActorBase_Script

**Parameters**

    actor: target ActorBase  (accepts special variable names ($system.self, $system.player) and both relative "Skyrim.esm:0xf" and absolute "0xf" values)  
    getter: getter name  

    GetClass  
    GetDeadCount  
    GetGiftFilter  
    GetRace  
    GetSex  
    IsEssential  
    IsInvulnerable  
    IsProtected  
    IsUnique  
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
    ;;;; will call form_dogetter if no matches are found  


**Example**

    set $selfBase resultfrom actor_dogetter $system.self GetActorBase  
    set $isUnique resultfrom actorbase_dogetter $selfBase IsUnique  
    set $raceName resultfrom actorbase_dogetter $selfBase GetRace ; i.e. "Breton", "Nord", "Argonian"  



## Armor

### armor_doconsumer

**Description**

For the specified Armor, perform the requested consumer, provided the appropriate additional parameters
'Consumer' in this case specifically refers to functions that take parameters but return no result
https://ck.uesp.net/wiki/Armor_Script

**Parameters**

    Form: target Armor (accepts both relative "Skyrim.esm:0xf" and absolute "0xf" values)  
    consumer: consumer name  

    SetArmorRating  
    SetAR  
    ModArmorRating  
    SetModelPath  
    SetIconPath  
    SetMessageIconPath  
    SetWeightClass  
    SetEnchantment  
    SetSlotMask  
    ;;;; will call form_doconsumer if no matches are found  


**Example**

    set $selfShield resultfrom actor_dogetter $system.self GetEquippedShield  
    armor_doconsumer $selfShield ModArmorRating 100.0 ; big bonus to target's shield armor rating  



### armor_dofunction

**Description**

For the targeted Armor, set $$ to the result of the specified function
'Function' in this case specifically refers to functions that take one or more parameters and return a value
https://ck.uesp.net/wiki/Armor_Script

**Parameters**

    Form: target Armor  (accepts both relative "Skyrim.esm:0xf" and absolute "0xf" values)  
    function: function name  

    GetMaskForSlot  
    GetModelPath  
    GetIconPath  
    GetMessageIconPath  
    AddSlotToMask  
    RemoveSlotFromMask  
    GetNthArmorAddon  
    ;;;; will call form_dofunction if no matches are found  




### armor_dogetter

**Description**

For the targeted Armor, set $$ to the result of the specified getter
'Getter' in this case specifically refers to functions that take no parameters but return a value
https://ck.uesp.net/wiki/Armor_Script

**Parameters**

    Form: target Armor  (accepts both relative "Skyrim.esm:0xf" and absolute "0xf" values)  
    getter: getter name  

    GetWarmthRating  
    GetArmorRating  
    GetAR  
    GetWeightClass  
    GetEnchantment  
    GetSlotMask  
    GetNumArmorAddons  
    IsLightArmor  
    IsHeavyArmor  
    IsClothing  
    IsBoots  
    IsCuirass  
    IsGauntlets  
    IsHelmet  
    IsShield  
    IsJewelry  
    IsClothingHead  
    IsClothingBody  
    IsClothingFeet  
    IsClothingHands  
    IsClothingRing  
    IsClothingRich  
    IsClothingPoor  
    ;;;; will call form_dogetter if no matches are found  


**Example**

    set $selfShield resultfrom actor_dogetter $system.self GetEquippedShield  
    set $selfShieldArmorRating resultfrom armor_dogetter $selfShield GetArmorRating  



### armor_getmaskforslot

**Description**

Returns the slot mask (https://ck.uesp.net/wiki/Slot_Masks_-_Armor) for the specified armor slot.

**Parameters**

    int: slot number  


**Example**

    set $slotMask resultfrom armor_getmaskforslot 32 ; $slotMask should be 0x4  



## Core

### toh_elapsed_time

**Description**

Returns: float: the actual game time passed at the time of the last "Top of the Hour"
For example, if you slept from 1:30 to 4:00, you would get a Top of the Hour event at 4 with a value of 2.5


**Example**

    ; to get the actual elapsed game time from the previous "Top of the Hour" event  
    set $timeSinceLastTOHEvent resultfrom toh_elapsed_time  
    ; this can happen, for example, due to fast travel and sleep events, where multiple hours may pass  



## Form

### form_addkeyword

**Description**

Returns: bool: true if able to add the keyword, false otherwise

**Parameters**

    Form: akForm: the Form to add a Keyword to  
    Form: akKeyword: the Keyword to add  


**Example**

    set $akKeyword resultfrom keyword_get "ArmorHeavy"  
    set $did_add resultfrom form_addkeyword $armor_piece $akKeyword  



### form_doaction

**Description**

For the targeted Form, perform the associated function based on the specified action
'Action' in this case specifically refers to functions that take no parameters and return no values
https://ck.uesp.net/wiki/Form_Script

**Parameters**

    form: target Form (accepts both relative "Skyrim.esm:0xf" and absolute "0xf" values)  
    action: action name  

    RegisterForSleep  
    RegisterForTrackedStatsEvent  
    StartObjectProfiling  
    StopObjectProfiling  
    UnregisterForSleep  
    UnregisterForTrackedStatsEvent  
    UnregisterForUpdate  
    UnregisterForUpdateGameTime  
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

    ; $system.self is an Actor, which is an ObjectReference, which is a Form  
    form_doaction $system.self StopCombat  



### form_doconsumer

**Description**

For the specified Form, perform the requested consumer, provided the appropriate additional parameters
'Consumer' in this case specifically refers to functions that take parameters but return no result
https://ck.uesp.net/wiki/Form_Script

**Parameters**

    form: target Form (accepts both relative "Skyrim.esm:0xf" and absolute "0xf" values)  
    consumer: consumer name  

    SetPlayerKnows  
    SetWorldModelPath  
    SetName  
    SetWeight  
    SetGoldValue  
    SendModEvent  


**Example**

    ; intended to make the player's shield 0.1 weight units  
    set $playerShield resultfrom actor_dogetter $system.player GetEquippedShield  
    form_doconsumer $playerShield SetWeight 0.1 ; featherweight shield  



### form_dofunction

**Description**

For the targeted Form, set $$ to the result of the specified function
'Function' in this case specifically refers to functions that take one or more parameters and return a value
https://ck.uesp.net/wiki/Form_Script

**Parameters**

    actor: target Form  (accepts special variable names ($system.self, $system.player) and both relative "Skyrim.esm:0xf" and absolute "0xf" values)  
    function: function name  

    HasKeywordString  
    HasKeyword  
    GetNthKeyword  
    GetWorldModelNthTextureSet  


**Example**

    ; determine whether a given Form is pointing to an Actor NPC  
    set $isNPC resultfrom form_dofunction $system.self HasKeywordString "ActorTypeNPC"  



### form_dogetter

**Description**

For the targeted Actor, set $$ to the result of the specified getter
'Getter' in this case specifically refers to functions that take no parameters but return a value
https://ck.uesp.net/wiki/Form_Script

**Parameters**

    form: target Form (accepts both relative "Skyrim.esm:0xf" and absolute "0xf" values)  
    getter: getter name  

    GetFormID  
    GetGoldValue  
    PlayerKnows  
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

    set $selfName resultfrom form_dogetter $system.self GetName  
    msg_console $"Name of $system.self, an Actor, as a Form, via GetName(), is '{$selfName}'"  



### form_getbyid

**Description**

Returns: Form: Performs a lookup for a Form and returns it if found; returns none otherwise
Note that if multiple mods introduce an object with the same editorId, the lookup would only return whichever one won
Anywhere a Form is called for in other functions, one of these formIDs can be substituted.

**Parameters**

    string: formID: FormID as: "modfile.esp:<relative int or hex formID>" (mod-colon-id), "<relative int or hex formID>|modfile.esp" (id-pipe-mod), "<absolute int or hex formID>" (id), "anEditorId" (will attempt an editorId lookup)  


**Example**

    set $aleForm resultfrom form_getbyid "Ale"  
    set $aleName resultfrom form_dogetter $aleForm GetName  
    msg_notify $"{$aleName}!! Yay!!"  
    ; Ale!! Yay!!  
    ; anything that derives from Form can be retrieved with this, including Armor, Weapon, Quest, Spell, MagicEffect, Actor, and other types of objects  



### form_removekeyword

**Description**

Returns: bool: true if able to remove the keyword, false otherwise

**Parameters**

    Form: akForm: the Form to remove a Keyword from  
    Form: akKeyword: the Keyword to remove  


**Example**

    set $akKeyword resultfrom keyword_get "ArmorHeavy"  
    set $did_remove resultfrom form_removekeyword $armor_piece $akKeyword  



## Game

### game_doaction

**Description**

Calls the specified global Game script action.
https://ck.uesp.net/wiki/Game_Script

**Parameters**

    string: action name  
    remaining arguments vary by action  

    ClearPrison()  
    ClearTempEffects()  
    ForceFirstPerson()  
    ForceThirdPerson()  
    HideTitleSequenceMenu()  
    PrecacheCharGen()  
    PrecacheCharGenClear()  
    QuitToMainMenu()  
    RequestAutoSave()  
    RequestSave()  
    SendWereWolfTransformation()  
    ServeTime()  
    ShowLimitedRaceMenu()  
    ShowRaceMenu()  
    ShowTitleSequenceMenu()  
    UpdateTintMaskColors()  
    UpdateHairColor()  
    UpdateThirdPerson()  


**Example**

    game_doaction ShowLimitedRaceMenu ; change everything but race and gender  



### game_doconsumer

**Description**

Calls the specified global Game script consumer.
https://ck.uesp.net/wiki/Game_Script

**Parameters**

    string: consumer name  
    remaining arguments vary by consumer  

    AddAchievement(Int aiAchievementID)  
    AddPerkPoints(Int aiPerkPoints)  
    AdvanceSkill(String asSkillName, Float afMagnitude)  
    DisablePlayerControls(Bool abMovement, Bool abFighting, Bool abCamSwitch, Bool abLooking, Bool abSneaking, Bool abMenu, Bool abActivate, Bool abJournalTabs, Int aiDisablePOVType)  
    EnableFastTravel(Bool abEnable)  
    EnablePlayerControls(Bool abMovement, Bool abFighting, Bool abCamSwitch, Bool abLooking, Bool abSneaking, Bool abMenu, Bool abActivate, Bool abJournalTabs, Int aiDisablePOVType)  
    FadeOutGame(Bool abFadingOut, Bool abBlackFade, Float afSecsBeforeFade, Float afFadeDuration)  
    FastTravel(ObjectReference akDestination)  
    IncrementSkill(String asSkillName)  
    IncrementSkillBy(String asSkillName, Int aiCount)  
    IncrementStat(String asStatName, Int aiModAmount)  
    PlayBink(String asFileName, Bool abInterruptible, Bool abMuteAudio, Bool abMuteMusic, Bool abLetterbox)  
    RequestModel(String asModelName)  
    SetAllowFlyingMountLandingRequests(Bool abAllow)  
    SetBeastForm(Bool abEntering)  
    SetCameraTarget(Actor arTarget)  
    SetHudCartMode(Bool abSetCartMode)  
    SetInChargen(Bool abDisableSaving, Bool abDisableWaiting, Bool abShowControlsDisabledMessage)  
    SetPlayerAIDriven(Bool abAIDriven)  
    SetPlayerReportCrime(Bool abReportCrime)  
    SetSittingRotation(Float afValue)  
    SetSunGazeImageSpaceModifier(ImageSpaceModifier apImod)  
    ShakeCamera(ObjectReference akSource, Float afStrength)  
    ShakeController(Float afLeftStrength, Float afRightStrength, Float afDuration)  
    ShowFirstPersonGeometry(Bool abShow)  
    ShowTrainingMenu(Actor aActor)  
    StartTitleSequence(String asSequenceName)  
    TeachWord(WordOfPower akWord)  
    TriggerScreenBlood(Int aiValue)  
    UnlockWord(WordOfPower akWord)  
    SetPerkPoints(Int perkPoints)  
    ModPerkPoints(Int perkPoints)  
    SetGameSettingFloat(String setting, Float value)  
    SetGameSettingInt(String setting, Int value)  
    SetGameSettingBool(String setting, Bool value)  
    SetGameSettingString(String setting, String value)  
    SaveGame(String name)  
    LoadGame(String name)  
    SetNthTintMaskTexturePath(String path, Int n)  
    SetTintMaskColor(Int color, Int type, Int index)  
    SetTintMaskTexturePath(String path, Int type, Int index)  
    SetMiscStat(String name, Int value)  
    SetPlayersLastRiddenHorse(Actor horse)  
    SetSkillLegendaryLevel(String actorValue, Int level)  
    SetPlayerExperience(Float exp)  
    UnbindObjectHotkey(Int hotkey)  
    SetPlayerLevel(Int Level)  


**Example**

    ; turn off fall damage  
    game_doconsumer SetGameSettingFloat "fjumpfallheightmult" 0.0  



### game_dofunction

**Description**

Calls the specified global Game script function.
https://ck.uesp.net/wiki/Game_Script

**Parameters**

    string: function name  
    remaining arguments vary by function  

    Bool AddHavokBallAndSocketConstraint(ObjectReference arRefA, String arRefANode, ObjectReference arRefB, String arRefBNode, Float afRefALocalOffsetX, Float afRefALocalOffsetY, Float afRefALocalOffsetZ, Float afRefBLocalOffsetX, Float afRefBLocalOffsetY, Float afRefBLocalOffsetZ)  
    Int CalculateFavorCost(Int aiFavorPrice)  
    Actor FindClosestActor(Float afX, Float afY, Float afZ, Float afRadius)  
    Actor FindClosestActorFromRef(ObjectReference arCenter, Float afRadius)  
    ObjectReference FindClosestReferenceOfAnyTypeInList(FormList arBaseObjects, Float afX, Float afY, Float afZ, Float afRadius)  
    ObjectReference FindClosestReferenceOfAnyTypeInListFromRef(FormList arBaseObjects, ObjectReference arCenter, Float afRadius)  
    ObjectReference FindClosestReferenceOfType(Form arBaseObject, Float afX, Float afY, Float afZ, Float afRadius)  
    ObjectReference FindClosestReferenceOfTypeFromRef(Form arBaseObject, ObjectReference arCenter, Float afRadius)  
    Actor FindRandomActor(Float afX, Float afY, Float afZ, Float afRadius)  
    Actor FindRandomActorFromRef(ObjectReference arCenter, Float afRadius)  
    ObjectReference FindRandomReferenceOfAnyTypeInList(FormList arBaseObjects, Float afX, Float afY, Float afZ, Float afRadius)  
    ObjectReference FindRandomReferenceOfAnyTypeInListFromRef(FormList arBaseObjects, ObjectReference arCenter, Float afRadius)  
    ObjectReference FindRandomReferenceOfType(Form arBaseObject, Float afX, Float afY, Float afZ, Float afRadius)  
    ObjectReference FindRandomReferenceOfTypeFromRef(Form arBaseObject, ObjectReference arCenter, Float afRadius)  
    Form GetForm(Int aiFormID)  
    Form GetFormFromFile(Int aiFormID, String asFilename)  
    Float GetGameSettingFloat(String asGameSetting)  
    Float GetGameSettingInt(String asGameSetting)  
    Float GetGameSettingString(String asGameSetting)  
    Bool IsWordUnlocked(WordOfPower akWord)  
    Int QueryStat(String asStat)  
    Bool RemoveHavokConstraints(ObjectReference arFirstRef, String arFirstRefNodeName, ObjectReference arSecondRef, String arSecondRefNodeName)  
    Int GetModByName(String name)  
    String GetModName(Int modIndex)  
    String GetModAuthor(Int modIndex)  
    String GetModDescription(Int modIndex)  
    Int GetModDependencyCount(Int modIndex)  
    Int GetNthModDependency(Int modIndex, Int n)  
    Bool IsPluginInstalled(String name)  
    Int GetLightModByName(String name)  
    String GetLightModName(Int modIndex)  
    String GetLightModAuthor(Int modIndex)  
    String GetLightModDescription(Int modIndex)  
    Int GetLightModDependencyCount(Int modIndex)  
    Int GetNthLightModDependency(Int modIndex, Int n)  
    Int GetNthTintMaskColor(Int n)  
    Int GetNthTintMaskType(Int n)  
    Int SetNthTintMaskColor(Int n, Int color)  
    String GetNthTintMaskTexturePath(Int n)  
    Int GetNumTintsByType(Int type)  
    Int GetTintMaskColor(Int type, Int index)  
    String GetTintMaskTexturePath(Int type, Int index)  
    Int GetSkillLegendaryLevel(String actorValue)  
    Float GetExperienceForLevel(Int currentLevel)  
    Form GetHotkeyBoundObject(Int hotkey)  
    Bool IsObjectFavorited(Form form)  
    Form GetFormEx(Int formId)  


**Example**

    ; find a random actor, within 500.0 distance units from the player  
    set $randomActor resultfrom game_dofunction FindRandomActorFromRef $system.player 500.0  
    ; check for existence of the "sl_triggers.esp" mod  
    set $sltrModIndex resultfrom game_dofunction GetModByName "sl_triggers.esp"; result of 255 means not installed, but how?  
    if $sltrModIndex == 255 [HowIsThisScriptRunningIfSLTRIsNotInstalled]  



### game_dogetter

**Description**

Calls the specified global Game script getter.
https://ck.uesp.net/wiki/Game_Script

**Parameters**

    string: getter name  
    remaining arguments vary by getter  

    Actor GetPlayer()  
    ObjectReference GetPlayerGrabbedRef()  
    Actor GetPlayersLastRiddenHorse()  
    Float GetRealHoursPassed()  
    Float GetSunPositionX()  
    Float GetSunPositionY()  
    Float GetSunPositionZ()  
    Bool IsActivateControlsEnabled()  
    Bool IsCamSwitchControlsEnabled()  
    Bool IsFastTravelEnabled()  
    Bool IsFastTravelControlsEnabled()  
    Bool IsFightingControlsEnabled()  
    Bool IsJournalControlsEnabled()  
    Bool IsLookingControlsEnabled()  
    Bool IsMenuControlsEnabled()  
    Bool IsMovementControlsEnabled()  
    Bool IsPlayerSungazing()  
    Bool IsSneakingControlsEnabled()  
    Bool UsingGamepad()  
    Int GetPerkPoints()  
    Int GetModCount()  
    Int GetLightModCount()  
    Int GetNumTintMasks()  
    Int GetCameraState()  
    Float GetPlayerExperience()  
    Bool GetPlayerMovementMode()  
    ObjectReference GetCurrentCrosshairRef()  
    ObjectReference GetCurrentConsoleRef()  


**Example**

    set $numPerkPoints resultfrom game_dogetter GetPerkPoints  



## GlobalVariable

### global_getvalue

**Description**

Returns: float: Finds the indicated GlobalVariable and returns its current value as a float.

**Parameters**

    Form: globalVariable: the GLOB record targeted  


**Example**

    ; retrieve the GLOB via the editorID 'GameDaysPassed', and get it's current value  
    set $gameDaysPassed resultfrom global_getvalue "GameDaysPassed"  



### global_setvalue

**Description**

Finds the indicated GlobalVariable and sets its current value.

**Parameters**

    Form: globalVariable: the GLOB record targeted  
    newValue: float  


**Example**

    ; retrieve the GLOB via the editorID 'GameDaysPassed', and set it's current value  
    ; Sets the Devious Followers willpower global to 20.0  
    global_setvalue "_Dwill" 20.0  



### globalvariable_doconsumer

**Description**

For the specified GlobalVariable, perform the requested consumer, provided the appropriate additional parameters
'Consumer' in this case specifically refers to functions that take parameters but return no result
https://ck.uesp.net/wiki/GlobalVariable_Script

**Parameters**

    Form: target GlobalVariable (accepts both relative "Skyrim.esm:0xf" and absolute "0xf" values)  
    consumer: consumer name  

    SetValue  
    SetValueInt  
    ;;;; will call form_doconsumer if no matches are found  


**Example**

    ; to set the current GLOB TimeScale to 10.0 (half of the default of 20.0, thus slowing the passage of time)  
    set $GLOB_timescale resultfrom form_getbyid "TimeScale"  
    globalvariable_doconsumer $GLOB_timescale SetValue 10.0  
    set $timeScale resultfrom globalvariable_dogetter $GLOB_timescale GetValue  
    ; $timeScale should be 10.0 now (default is 20.0)  



### globalvariable_dofunction

**Description**

For the targeted GlobalVariable, set $$ to the result of the specified function
'Function' in this case specifically refers to functions that take one or more parameters and return a value
https://ck.uesp.net/wiki/GlobalVariable_Script

**Parameters**

    Form: target GlobalVariable  (accepts both relative "Skyrim.esm:0xf" and absolute "0xf" values)  
    function: function name  

    Mod - more thread-safe than get/set  
    ;;;; will call form_dofunction if no matches are found  


**Example**

    ; to apply a modifier to the GLOB TimeScale of -10.0, reducing it from the default of 20.0 down to 10.0  
    set $GLOB_timescale resultfrom form_getbyid "TimeScale"  
    set $timeScale resultfrom globalvariable_dofunction $GLOB_timescale Mod -10.0  
    ; $timeScale should be 10.0 now (default is 20.0)  



### globalvariable_dogetter

**Description**

For the targeted GlobalVariable, set $$ to the result of the specified getter
'Getter' in this case specifically refers to functions that take no parameters but return a value
https://ck.uesp.net/wiki/GlobalVariable_Script

**Parameters**

    Form: target GlobalVariable  (accepts both relative "Skyrim.esm:0xf" and absolute "0xf" values)  
    getter: getter name  

    GetValue  
    GetValueInt  
    ;;;; will call form_dogetter if no matches are found  


**Example**

    ; to get the current GLOB TimeScale  
    set $GLOB_timescale resultfrom form_getbyid "TimeScale"  
    set $timeScale resultfrom globalvariable_dogetter $GLOB_timescale GetValue  
    ; $timeScale should be 20.0 by default  



## Imagespace Modifier

### ism_applyfade

**Description**

Apply imagespace modifier - per original author, check CreationKit, SpecialEffects\Imagespace Modifier

**Parameters**

    Form: item: ImageSpaceModifier to apply  
    float: duration: cross-fade duration in seconds  


**Example**

    ism_applyfade $1 2  



### ism_removefade

**Description**

Remove imagespace modifier - per original author, check CreationKit, SpecialEffects\Imagespace Modifier

**Parameters**

    float: duration: cross-fade removal duration in seconds  


**Example**

    ism_removefade 2  



## Items

### item_add

**Description**

Adds the item to the actor's inventory. If you are struggling with NPC's, try item_addex.

**Parameters**

    Form: actor: target Actor  
    Form: item: the item to add (e.g. Weapon, Armor, Misc. Item)  
    int: count: number (optional: default 1)  
    bool: isSilent: false - show message | true - silent (optional: default: false - show message)  


**Example**

    item_add $system.self "skyrim.esm:15" 10 false  

Adds 10 gold to the actor, displaying the notification  


### item_addex

**Description**

Adds the item to the actor's inventory, but check if some armor was re-equipped (if NPC)

**Parameters**

    Form: actor: target Actor  
    Form: item: ITEM FormId  
    int: count: number (optional: default 1)  
    bool: isSilent: false - show message | true - silent (optional: default false - show message)  


**Example**

    item_addex $system.self "skyrim.esm:15" 10 false  



### item_adduse

**Description**

Add item (like item_add) and then use the added item (like item_equip). Useful for potions, food, and other consumables.

**Parameters**

    Form: actor: target Actor  
    Form: item: the item to add and equip  
    int: count: number (optional: default 1)  
    bool: isSilent: false - show message | true - silent (optional: default false - show message)  


**Example**

    item_adduse $system.self "skyrim.esm:216158" 1 false  

Add and drink some booze  


### item_equip

**Description**

Equip item ("vanilla" version). Note that the documentation suggests adding the item first in most cases if it does not exist.

**Parameters**

    Form: actor: target Actor  
    Form: item: the item to equip  
    bool: preventRemoval: false - removal allowed | true - removal not allowed  
    bool: sound: false - no sound | true - with sound  


**Example**

    item_equip $system.self "ZaZAnimationPack.esm:159072" true false  

Equip the ZaZ armor on $system.self, silently, with no removal allowed (uses whatever slot the armor uses)  


### item_equipex

**Description**

Equip item (SKSE version)

**Parameters**

    Form: actor: target Actor  
    Form: item: the item to equip  
    int: armorslot: number e.g. 32 for body slot  
    bool: sound: false - no sound | true - with sound  
    bool: removalPrevented: false - removal allowed | true - removal not allowed  


**Example**

    item_equipex $system.self "ZaZAnimationPack.esm:159072" 32 0 1  

Equip the ZaZ armor on $system.self, at body slot 32, silently, with no removal allowed  
Equips item directly, Workaround for "NPCs re-equip all armor, if they get an item that looks like armor"  


### item_getcount

**Description**

Returns: int: how many of a specified item an ObjectReference (typically an actor) has

**Parameters**

    Form: actor: target ObjectReference  
    Form: item: item to count  


**Example**

    item_getcount $system.self "skyrim.esm:15"  



### item_remove

**Description**

Remove the item from the source's inventory

**Parameters**

    Form: container: the ObjectReference container (e.g. an Actor, Chest, Barrel, corpse) to remove an item from  
    Form: item: the Form of the item to remove  
    count: number  
    bool: silent: false - show message | true - silent (optional: default false - show message)  
    Form: targetContainer: other container (ObjectReference) to move the item to (optional: default none)  


**Example**

    item_remove $system.self "skyrim.esm:15" 10 false $system.player  

Removes up to 10 gold from the source, looting it to the player (target)  


### item_unequipex

**Description**

Unequip item

**Parameters**

    Form: actor: target Actor  
    Form: item: the item to unequip  
    int: armorslot: number e.g. 32 for body slot  


**Example**

    item_unequipex $system.self "ZaZAnimationPack.esm:159072" 32  

Unequips the ZaZ armor from slot 32 on $system.self  


## JSON

### json_getvalue

**Description**

Returns: (varies): value from JSON file (uses PapyrusUtil/JsonUtil)

**Parameters**

    string: filename: name of file, rooted from 'Data/SKSE/Plugins/StorageUtilData'  
    string: datatype: int, float, string  
    string: key: the key  
    (varies): default: default value in case it isn't present (optional: default for type)  


**Example**

    json_getvalue "../somefolder/afile" float "demofloatvalue" 2.3  

JsonUtil automatically appends .json when not given a file extension  


### json_save

**Description**

Tells JsonUtil to immediately save the specified file from cache

**Parameters**

    string: filename: name of file, rooted from 'Data/SKSE/Plugins/StorageUtilData'  


**Example**

    json_save "../somefolder/afile"  



### json_setvalue

**Description**

Sets a value in a JSON file (uses PapyrusUtil/JsonUtil)

**Parameters**

    string: filename: name of file, rooted from 'Data/SKSE/Plugins/StorageUtilData'  
    string: datatype: int, float, string  
    string: key: the key  
    (varies): new value: value to set  


**Example**

    json_setvalue "../somefolder/afile" float "demofloatvalue" 2.3  

JsonUtil automatically appends .json when not given a file extension  


## Keyword

### keyword_get

**Description**

Returns: Form: the Keyword to retrieve

**Parameters**

    string: akKeywordString: the string of the keyword to fetch  


**Example**

    set $akKeyword resultfrom keyword_get "ArmorHeavy"  



## MfgFix

### mfg_getphonememodifier

**Description**

Returns: int: facial expression (requires MfgFix https://www.nexusmods.com/skyrimspecialedition/mods/11669)

**Parameters**

    Form: actor: target Actor  
    int: mode: number, 0 - set phoneme | 1 - set modifier  
    int: id: an id (I'm not familiar with MfgFix :/)  


**Example**

    mfg_getphonememodifier $system.self 0 $1  



### mfg_reset

**Description**

Resets facial expression (requires MfgFix https://www.nexusmods.com/skyrimspecialedition/mods/11669)

**Parameters**

    Form: actor: target Actor  


**Example**

    mfg_reset $system.self  



### mfg_setphonememodifier

**Description**

Set facial expression (requires MfgFix https://www.nexusmods.com/skyrimspecialedition/mods/11669)

**Parameters**

    Form: actor: target Actor  
    int: mode: number, 0 - set phoneme | 1 - set modifier  
    int: id: an id  (I'm not familiar with MfgFix :/)  
    int: value: new value  
    <actor variable> <mode> <id> <value>  


**Example**

    mfg_setphonememodifier $system.self 0 $1 $2  



## NFF (Nether's Follower Framework)

### nff_getfollowers

**Description**

Returns: Form[]: a list containing the followers


**Example**

    set $nffFollowers resultfrom nff_getfollowers  
    set $count resultfrom listcount $nffFollowers  
    ; counting backwards  
    while $count > 0  
    inc $count -1  
    set $follower $nffFollowers[$count]  
    ; do something for each $follower  
    set $followerName resultfrom actor_name $follower  
    msg_notify $"{$followerName} is your #1 fan!"  
    endwhile  



## NiOverride

### apply_overlay

**Description**

Tells NIO to apply pending changes. Not typically required.

**Parameters**

    Form: actor: target Actor  


**Example**

    apply_overlay $system.player  



### changeoverlay_transparency

**Description**

Modifies the transparency of a given overlay

**Parameters**

    Form: actor: target Actor  
    bool: isFemale: true if a female target, false otherwise  
    string: nodeName: (body, face, etc...)  
    float: transparency  


**Example**

    changeoverlay_transparency $system.player true $nodeName 1.0  



### getoverlay_slot

**Description**

Returns: string: returns a free overlay slot

**Parameters**

    Form: actor: target Actor  
    bool: isFemale: true if a female target, false otherwise  
    string: nodeName: (body, face, etc...)  


**Example**

    set $nodeName resultfrom getvoverlay_slot $system.player true "Body"  



### nio_addnodeoverride_bool

**Description**

Calls NiOveride.AddNodeOverride for bool

**Parameters**

    Form: ref: target of function (e.g. $system.player)  
    bool: isFemale: true if a female target, false otherwise  
    string: node: NIO node you are working with  
    int: _key: NIO key  
    int: index: NIO index  
    bool: value: value to apply  
    bool: persist: persist the override?  




### nio_addnodeoverride_float

**Description**

Calls NiOveride.AddNodeOverride for float

**Parameters**

    Form: ref: target of function (e.g. $system.player)  
    bool: isFemale: true if a female target, false otherwise  
    string: node: NIO node you are working with  
    int: _key: NIO key  
    int: index: NIO index  
    float: value: value to apply  
    bool: persist: persist the override?  




### nio_addnodeoverride_int

**Description**

Calls NiOveride.AddNodeOverride for int

**Parameters**

    Form: ref: target of function (e.g. $system.player)  
    bool: isFemale: true if a female target, false otherwise  
    string: node: NIO node you are working with  
    int: _key: NIO key  
    int: index: NIO index  
    int: value: value to apply  
    bool: persist: persist the override?  




### nio_addnodeoverride_string

**Description**

Calls NiOveride.AddNodeOverride for string

**Parameters**

    Form: ref: target of function (e.g. $system.player)  
    bool: isFemale: true if a female target, false otherwise  
    string: node: NIO node you are working with  
    int: _key: NIO key  
    int: index: NIO index  
    string: value: value to apply  
    bool: persist: persist the override?  




### nio_addnodeoverride_textureset

**Description**

Calls NiOveride.AddNodeOverride for TextureSet

**Parameters**

    Form: ref: target of function (e.g. $system.player)  
    bool: isFemale: true if a female target, false otherwise  
    string: node: NIO node you are working with  
    int: _key: NIO key  
    int: index: NIO index  
    Form: value: TextureSet value to apply  
    bool: persist: persist the override?  




### nio_clearbodymorph

**Description**

Clears the morph value of the target

**Parameters**

    Form: ref: target of function (e.g. $system.player)  
    string: morphName: name of the morph you are working with  
    string: keyName: NIO key you are working with  




### nio_get_morphkeys

**Description**

Returns: string[]: a list of the keys applied to the target actor for the specified morph.

**Parameters**

    Form: ref: target of function (e.g. $system.player)  
    string: morphName: name of the morph you are working with  




### nio_get_morphnames

**Description**

Returns: string[]: a list of the morphNames applied to the target actor.

**Parameters**

    Form: ref: target of function (e.g. $system.player)  




### nio_getbodymorph

**Description**

Returns: float: the current morph value for the target

**Parameters**

    Form: ref: target of function (e.g. $system.player)  
    string: morphName: name of the morph you are working with  
    string: keyName: NIO key you are working with  




### nio_getnodeoverride_bool

**Description**

Returns: bool: the bool override for the node on the target

**Parameters**

    Form: ref: target of function (e.g. $system.player)  
    bool: isFemale: true if a female target, false otherwise  
    string: node: NIO node you are working with  
    int: _key: NIO key  
    int: index: NIO index  




### nio_getnodeoverride_float

**Description**

Returns: float: the float override for the node on the target

**Parameters**

    Form: ref: target of function (e.g. $system.player)  
    bool: isFemale: true if a female target, false otherwise  
    string: node: NIO node you are working with  
    int: _key: NIO key  
    int: index: NIO index  




### nio_getnodeoverride_int

**Description**

Returns: int: the int override for the node on the target

**Parameters**

    Form: ref: target of function (e.g. $system.player)  
    bool: isFemale: true if a female target, false otherwise  
    string: node: NIO node you are working with  
    int: _key: NIO key  
    int: index: NIO index  




### nio_getnodeoverride_string

**Description**

Returns: string: the string override for the node on the target

**Parameters**

    Form: ref: target of function (e.g. $system.player)  
    bool: isFemale: true if a female target, false otherwise  
    string: node: NIO node you are working with  
    int: _key: NIO key  
    int: index: NIO index  




### nio_getnodeoverride_textureset

**Description**

Returns: Form: the TextureSet override for the node on the target

**Parameters**

    Form: ref: target of function (e.g. $system.player)  
    bool: isFemale: true if a female target, false otherwise  
    string: node: NIO node you are working with  
    int: _key: NIO key  
    int: index: NIO index  




### nio_hasbodymorph

**Description**

Returns: bool: true if the target has the body morph; false otherwise

**Parameters**

    Form: ref: target of function (e.g. $system.player)  
    string: morphName: name of the morph you are working with  
    string: keyName: NIO key you are working with  




### nio_hasnodeoverride

**Description**

Returns: bool: true if the target has the node override; false otherwise

**Parameters**

    Form: target of function (e.g. $system.player)  
    bool: isFemale: true if a female target, false otherwise  
    string: nodeName: (body, face, etc...)  
    int: _key: NIO key  
    int: index: NIO index  




### nio_setbodymorph

**Description**

Sets the bodymorph of the target

**Parameters**

    Form: ref: target of function (e.g. $system.player)  
    string: morphName: name of the morph you are working with  
    string: keyName: NIO key you are working with  
    float: value: value to apply  




### nio_updatemodelweight

**Description**

Updates the weight data post morph value. Only to be used on actors who have morph values set.

**Parameters**

    Form: ref: target of function (e.g. $system.player)  




### param_overlay

**Description**

Adds a tattoo overlay to the node with the given transparency

**Parameters**

    Form: actor: target Actor  
    bool: isFemale: true if a female target, false otherwise  
    string: nodeName: (body, face, etc...)  
    string: tattoo  
    float: transparency  


**Example**

    param_overlay $system.player true $nodeName $tattooName 1.0  



### remove_overlay

**Description**

Removes the overlay indicated by nodeName

**Parameters**

    Form: actor: target Actor  
    bool: isFemale: true if a female target, false otherwise  
    string: nodeName: (body, face, etc...)  


**Example**

    remove_overlay $system.player true $nodeName  



## ObjectReference

### objectreference_doaction

**Description**

For the targeted ObjectReference, perform the associated function based on the specified action
'Action' in this case specifically refers to functions that take no parameters and return no values
https://ck.uesp.net/wiki/ObjectReference_Script

**Parameters**

    objectreference: target ObjectReference  (accepts both relative "Skyrim.esm:0xf" and absolute "0xf" values)  
    action: action name  

    ClearDestruction  
    Delete  
    DeleteWhenAble  
    ForceAddRagdollToWorld  
    ForceRemoveRagdollFromWorld  
    InterruptCast  
    MoveToMyEditorLocation  
    RemoveAllInventoryEventFilters  
    StopTranslation  
    ResetInventory  
    ;;;; will call form_doaction if no matches are found  


**Example**

    ; $system.self is an Actor, which is an ObjectReference, which is a Form  
    ; StopCombat is a Form action, so the call to ObjectReference falls through to the parent  
    objectreference_doaction $system.self StopCombat  



### objectreference_doconsumer

**Description**

For the specified ObjectReference, perform the requested consumer, provided the appropriate additional parameters
'Consumer' in this case specifically refers to functions that take parameters but return no result
https://ck.uesp.net/wiki/ObjectReference_Script

**Parameters**

    objectreference: target ObjectReference (accepts both relative "Skyrim.esm:0xf" and absolute "0xf" values)  
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
    ;;;; will call form_doconsumer if no matches are found  


**Example**

    ; give the player's shield 'Fortify Block +20', with 200.0 charge (and technically duration 30.0, but I don't think that actually matters)  
    set $playerShield resultfrom actor_dogetter $system.player GetEquippedShield  
    objectreference_doconsumer $playerShield CreateEnchantment 200.0 "AlchFortifyBlock" 20.0 0.0 30.0  
    ; or give both 'Fortify Block +20' as above, as well as 'Fortify Restoration +20'  
    objectreference_doconsumer $playerShield CreateEnchantment 200.0 "AlchFortifyBlock" 20.0 0.0 30.0 "AlchFortifyRestoration" 20.0 0.0 30.0  



### objectreference_dofunction

**Description**

For the targeted ObjectReference, set $$ to the result of the specified function
'Function' in this case specifically refers to functions that take one or more parameters and return a value
https://ck.uesp.net/wiki/ObjectReference_Script

**Parameters**

    actor: target ObjectReference  (accepts special variable names ($system.self, $system.player) and both relative "Skyrim.esm:0xf" and absolute "0xf" values)  
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
    ;;;; will call form_dofunction if no matches are found  


**Example**

    ; in response to a containeractivate trigger, to quickly determine whether the container had  
    ; something that you might want to force into the player's inventory  
    set $theContainer $request.core.activatedContainer"  
    set $lookingFor $system.forms.gold ; shorthand for gold i.e. septims  
    set $foundCount resultfrom objectreference_dofunction $theContainer GetItemCount $lookingFor  
    ; or determine how much gold the target of the script has on them  
    set $selfGold resultfrom objectreference_dofunction $system.self GetItemCount $lookingFor  



### objectreference_dogetter

**Description**

For the targeted ObjectReference, set $$ to the result of the specified getter
'Getter' in this case specifically refers to functions that take no parameters but return a value
https://ck.uesp.net/wiki/ObjectReference_Script

**Parameters**

    objectreference: target ObjectReference  (accepts both relative "Skyrim.esm:0xf" and absolute "0xf" values)  
    getter: getter name  

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
    ;;;; will call form_dogetter if no matches are found  


**Example**

    ; inside/outside  
    set $isInside resultfrom objectreference_dogetter $system.self IsInInterior  
    if $isInside == true [IsInside]  
    if $isInside == false [IsNotInside]  
    ; working with containers, (including actors, chests, barrels, etc.) which all derive from ObjectReference  
    ; this would be valid, to check the inventory contents of whomever the script is running on  
    set $theContainer $system.self  
    ; this would be valid, to check the inventory contents of the player, regardless of whomever the script is running on  
    set $theContainer $system.player  
    ; this would be valid, to check the inventory contents of a container, in response to the container activation event  
    set $theContainer $request.core.activatedContainer  
    ; for all of the settings of $theContainer above, the following would validly obtain the count of contained items  
    set $inventoryCount resultfrom objectreference_dogetter $theContainer GetNumItems  



## PapyrusUtil

### jsonutil

**Description**

Wrapper around most JsonUtil functions

**Parameters**

    <sub-function> - JsonUtil functionality to perform  
    <filename> - JSON file to interact with, rooted from 'Data/SKSE/Plugins/StorageUtilData'  

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

    Form: perk: the Perk to add  
    Form: actor: target Actor  


**Example**

    perk_add "skyrim.esm:12384" $system.self  



### perk_addpoints

**Description**

Add specified number of perk points to player

**Parameters**

    int: perkpointcount: number of perk points to add  


**Example**

    perk_addpoints 4  



### perk_remove

**Description**

Remove specified perk from the targeted actor

**Parameters**

    Form: perk: the Perk to remove  
    Form: actor: target Actor  


**Example**

    perk_remove "skyrim.esm:12384" $system.self  



## Quest

### quest_doaction

**Description**

For the targeted Quest, perform the associated function based on the specified action
'Action' in this case specifically refers to functions that take no parameters and return no values
https://ck.uesp.net/wiki/Quest_Script

**Parameters**

    Form: target Quest  (accepts both relative "Skyrim.esm:0xf" and absolute "0xf" values)  
    action: action name  

    CompleteAllObjectives  
    CompleteQuest  
    FailAllObjectives  
    Reset  
    Stop  
    ;;;; will call form_doaction if no matches are found  


**Example**

    ; suppose you want to reset a mod's quest form  
    ; and can obtain the editorID via xedit, or construct one from formid and modname  
    set $modQuest resultfrom form_getbyid $questFormID  
    quest_doaction $modQuest Reset  



### quest_doconsumer

**Description**

For the specified Quest, perform the requested consumer, provided the appropriate additional parameters
'Consumer' in this case specifically refers to functions that take parameters but return no result
https://ck.uesp.net/wiki/Quest_Script

**Parameters**

    Form: target Quest (accepts both relative "Skyrim.esm:0xf" and absolute "0xf" values)  
    consumer: consumer name  

    SetActive  
    SetObjectiveCompleted  
    SetObjectiveDisplayed  
    SetObjectiveFailed  
    ;;;; will call form_doconsumer if no matches are found  


**Example**

    ; suppose you want to deactivate a quest mod  
    ; and can obtain the editorID via xedit, or construct one from formid and modname  
    set $modQuest resultfrom form_getbyid $questFormID  
    quest_doconsumer $modQuest SetActive false  



### quest_dofunction

**Description**

For the targeted Quest, set $$ to the result of the specified function
'Function' in this case specifically refers to functions that take one or more parameters and return a value
https://ck.uesp.net/wiki/Quest_Script

**Parameters**

    Form: target Quest  (accepts both relative "Skyrim.esm:0xf" and absolute "0xf" values)  
    function: function name  

    GetAlias  
    GetStageDone  
    IsObjectiveCompleted  
    IsObjectiveDisplayed  
    IsObjectiveFailed  
    IsStageDone  
    ModObjectiveGlobal  
    SetCurrentStageID  
    SetStage  
    UpdateCurrentInstanceGlobal  
    GetNthAlias  
    GetAliasByName  
    ;;;; will call form_dofunction if no matches are found  


**Example**

    ; suppose you want to determine for a quest mod whether a given stage is done (maybe that impacts mod state or activity)  
    ; and can obtain the editorID via xedit, or construct one from formid and modname  
    set $modQuest resultfrom form_getbyid $questFormID  
    set $stageIsDone resultfrom quest_dofunction $modQuest IsStageDone 100  
    if $stageIsDone == true [AsIfTheStageWereDone]  



### quest_dogetter

**Description**

For the targeted Quest, set $$ to the result of the specified getter
'Getter' in this case specifically refers to functions that take no parameters but return a value
https://ck.uesp.net/wiki/Quest_Script

**Parameters**

    Form: target Quest  (accepts both relative "Skyrim.esm:0xf" and absolute "0xf" values)  
    getter: getter name  

    GetCurrentStageID  
    GetStage  
    IsActive  
    IsCompleted  
    IsRunning  
    IsStarting  
    IsStopping  
    IsStopped  
    Start  
    GetID  
    GetPriority  
    GetNumAliases  
    ;;;; will call form_dogetter if no matches are found  


**Example**

    ; suppose you want to obtain a mod's quest stage  
    ; and can obtain the editorID via xedit, or construct one from formid and modname  
    set $modQuest resultfrom form_getbyid $questFormID  
    set $modQuestStage resultfrom quest_dogetter $modQuest GetStage  



## Sound

### snd_play

**Description**

Returns: int: the sound instance handle from playing the specified audio from the specified actor

**Parameters**

    Form: audio: the Audio Form to play  
    Form: actor: target Actor  


**Example**

    snd_play "skyrim.esm:318128" $system.self  



### snd_setvolume

**Description**

Set the sound volume using the specified sound instance handle (from snd_play)

**Parameters**

    int: handle: sound instance handle from snd_play  
    Form: actor: target Actor  
    float; volume: 0.0 - 1.0  


**Example**

    snd_setvolume $1 0.5  

Set the volume of the audio sound playing with handle stored in $1 to 50%  


### snd_stop

**Description**

Stops the audio specified by the sound instance handle (from snd_play)

**Parameters**

    int: handle: sound instance handle from snd_play  


**Example**

    snd_stop $1  



## Spells

### spell_add

**Description**

Adds the specified SPEL by FormId to the targeted Actor, usually to add as an available power or spell in the spellbook.

**Parameters**

    Form: spell: the Spell to add  
    Form: actor: target Actor  


**Example**

    spell_add "skyrim.esm:275236" $system.self  

The light spell is now in the actor's spellbook  


### spell_cast

**Description**

Cast spell at target

**Parameters**

    Form: spell: the Spell to cast  
    Form: actor: target Actor  


**Example**

    spell_cast "skyrim.esm:275236" $system.self  

Casts light spell on self  


### spell_dcsa

**Description**

Casts spell with DoCombatSpellApply Papyrus function. It is usually used for spells that
are part of a melee attack (like animals that also carry poison or disease).

**Parameters**

    Form: spell: the Spell  
    Form: actor: target Actor  


**Example**

    spell_dcsa "skyrim.esm:275236" $system.self  



### spell_dispel

**Description**

Dispels specified SPEL by FormId from targeted Actor

**Parameters**

    Form: spell: the Spell to dispel  
    Form: actor: target Actor  


**Example**

    spell_dispel "skyrim.esm:275236" $system.self  

If light was currently on $system.self, it would now be dispelled  


### spell_remove

**Description**

Removes the specified SPEL by FormId from the targeted Actor, usually to remove as an available power or spell in the spellbook.

**Parameters**

    Form: spell: the Spell to remove  
    Form: actor: target Actor  


**Example**

    spell_remove "skyrim.esm:275236" $system.self  

The light spell should no longer be in the actor's spellbook  


## TopicInfo

### topicinfo_getresponsetext

**Description**

Returns: string: Attempts to return a single response text associated with the provided TopicInfo (by editorID or FormID)
Note: This is more beta than normal; it isn't obvious whether in some cases multiple strings should actually be returned.

**Parameters**

    Form: topicinfo: <formID> or <editorID> for the desired TopicInfo (not Topic)  


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

    Form: actor: target Actor  
    string: command: <command fragment> [<command fragment> ...] ; all <command fragments> will be concatenated  


**Example**

    console $system.self "sgtm" "" "0.5"  
    console $system.self "sgtm 0.5"  

Both are the same  


### deb_msg

**Description**

Joins all arguments together into a single string and logs to "<Documents>\My Games\Skyrim Special Edition\SKSE\sl-triggers.log"
This file is truncated on game start.
Usage 1: deb_msg <msg> [<msg> ...]
Usage 2: deb_msg $msglist ; where $msglist is a string[]

**Parameters**

    string: message: any string or interpolated string  
    string[]: msglist: a list of strings to concatenate for a message  


**Example**

    deb_msg "Hello " "world!"  
    deb_msg "Hello world!"  
    set $whom "world"  
    deb_msg "Hello {$whom}!"  
    set $msg[0] "Hello "  
    set $msg[1] "world!"  
    deb_msg $msg  

; These all print the same thing  


### math

**Description**

Returns: (varies): values from math operations based on sub-function

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

Joins all arguments together into a single string and displays the message in the console
Usage 1: msg_console <msg> [<msg> ...]
Usage 2: msg_console $msglist ; where $msglist is a string[]

**Parameters**

    string: message: any string or interpolated string  
    string[]: msglist: a list of strings to concatenate for a message  


**Example**

    msg_console "Hello " "world!"  
    msg_console "Hello world!"  
    set $whom "world"  
    msg_console "Hello {$whom}!"  
    set $msg[0] "Hello "  
    set $msg[1] "world!"  
    msg_console $msg  

; These all print the same thing  


### msg_notify

**Description**

Joins all arguments together into a single string and displays the message in the standard notification area (top left of your screen by default)
Usage 1: msg_notify <msg> [<msg> ...]
Usage 2: msg_notify $msglist ; where $msglist is a string[]

**Parameters**

    string: message: any string or interpolated string  
    string[]: msglist: a list of strings to concatenate for a message  


**Example**

    msg_notify "Hello " "world!"  
    msg_notify "Hello world!"  
    set $whom "world"  
    msg_notify "Hello {$whom}!"  
    set $msg[0] "Hello "  
    set $msg[1] "world!"  
    msg_notify $msg  

; These all print the same thing  


### rnd_float

**Description**

Returns: float: a random integer between min and max inclusive

**Parameters**

    float: min: number  
    float: max: number  


**Example**

    rnd_float 1 100  



### rnd_int

**Description**

Returns: int: a random integer between min and max inclusive

**Parameters**

    int: min: number  
    int: max: number  


**Example**

    rnd_int 1 100  



### rnd_list

**Description**

Returns: string: one of the arguments at random
Usage 1: rnd_list <argument> [<argument> ...]
Usage 2: rnd_list $arglist ; where $arglist is a string[]

**Parameters**

    string: argument: any string or interpolated string  
    string[]: arglist: a list of strings to pick from  


**Example**

    rnd_list "One" "Two" "Three"  
    listadd $picklist "One" "Two" "Three"  
    rnd_list $picklist  

; These do the same thing  


### util_game

**Description**

Returns: (varies): Perform game related functions based on sub-function

**Parameters**

    sub-function: sub-function  
    parameter: varies by sub-function  

    if sub-function is "IncrementStat", (parameter 3, <stat name>, parameter 4, <amount>), see https://ck.uesp.net/wiki/IncrementStat_-_Game  
    if sub-function is "QueryStat", (parameter 3, <stat name>), returns the value  


**Example**

    util_game "IncrementStat" "Bribes" 1  



### util_getgametime

**Description**

Returns: float: the value of Utility.GetCurrentGameTime() (a float value representing the number of days in game time; mid-day day 2 is 1.5)


**Example**

    util_getgametime  



### util_getgametime

**Description**

Returns: int: the in-game hour (i.e. 2:30 AM returns 2)


**Example**

    util_getgametime  



### util_getrandomactor

**Description**

Returns: Form: a random actor within specified range of self

**Parameters**

    float: range: 0 - all | >0 skyrim units  


**Example**

    util_getrandomactor 320  



### util_getrealtime

**Description**

Returns: float: the value of Utility.GetCurrentRealTime() (a float value representing the number of seconds since Skyrim.exe was launched this session)


**Example**

    util_getrealtime  



### util_getrndactor

**Description**

Returns: Form: a random actor within specified range of self

**Parameters**

    float: range: (0 - all | >0 - range in Skyrim units)  


**Example**

    util_getrndactor 500  
    set $isvalid resultfrom actor_isvalid $actor  
    if $isvalid == false [end]  
    msg_notify "Someone is nearby!"  
    [end]  



### util_sendevent

**Description**

Send SKSE custom event, with each type/value pair being an argument to the custom event

**Parameters**

    string: event: name of the event  
    (type/value pairs are optional; this devolves to util_sendmodevent <eventname>, though with such a call the event signature would require having no arguments)  
    string: param type: type of parameter e.g. "bool", "int", etc.  
    string: param value: value of parameter  
    [type/value, type/value ...]  

    <type> can be any of [bool, int, float, string, form]  


**Example**

    util_sendevent "slaUpdateExposure" form $system.self float 33  

The "slaUpdateExposure" event will be sent with $system.self, and the float value of 33.0 as the two arguments  


### util_sendmodevent

**Description**

Shorthand for actor_sendmodevent $system.player <event name> <string argument> <float argument>

**Parameters**

    string: event: name of the event  
    string: arg: string argument (meaning varies by event sent) (optional: default "")  
    float: arg: float argument (meaning varies by event sent) (optional: default 0.0)  


**Example**

    util_sendmodevent "IHaveNoIdeaButEventNamesShouldBeEasyToFind" "strarg" 0.0  



### util_wait

**Description**

Wait specified number of seconds i.e. Utility.Wait()

**Parameters**

    float: duration: time to wait, in seconds  


**Example**

    util_wait 2.5  

The script will pause processing for 2.5 seconds  


### util_waitforkbd

**Description**

Returns: int: the keycode pressed after waiting for user to press any of the specified keys.
(See https://ck.uesp.net/wiki/Input_Script for the DXScanCodes)
Usage 1: util_waitforkbd <dxscancode> [<dxscancode> ...]
Usage 2: util_waitforkbd $keylist ; where $keylist is a int[]

**Parameters**

    int: dxscancode: <DXScanCode of key>  
    int[]: keylist: a list of dxscancode  


**Example**

    util_waitforkbd 74 78 181 55  
    listadd $keystowaitfor 74 78 181 55  
    util_waitforkbd $keystowaitfor  

; These do the same thing  


### weather_state

**Description**

Returns: (varies): Weather related functions based on sub-function

**Parameters**

    <sub-function> ; currently only GetClassification  


**Example**

    weather_state GetClassification  



## Weapon

### weapon_doconsumer

**Description**

For the specified Weapon, perform the requested consumer, provided the appropriate additional parameters
'Consumer' in this case specifically refers to functions that take parameters but return no result
https://ck.uesp.net/wiki/Weapon_Script

**Parameters**

    Form: target Weapon (accepts both relative "Skyrim.esm:0xf" and absolute "0xf" values)  
    consumer: consumer name  

    Fire  
    SetBaseDamage  
    SetCritDamage  
    SetReach  
    SetMinRange  
    SetMaxRange  
    SetSpeed  
    SetStagger  
    SetWeaponType  
    SetModelPath  
    SetIconPath  
    SetMessageIconPath  
    SetEnchantment  
    SetEnchantmentValue  
    SetEquippedModel  
    SetEquipType  
    SetSkill  
    SetResist  
    SetCritEffect  
    SetCritEffectOnDeath  
    SetCritMultiplier  
    ;;;; will call form_doconsumer if no matches are found  


**Example**

    set $someWeapon resultfrom form_getbyid $weaponFormID  
    weapon_doconsumer $someWeapon SetStagger 5.0 ; huge stagger value  



### weapon_dogetter

**Description**

For the targeted Weapon, set $$ to the result of the specified getter
'Getter' in this case specifically refers to functions that take no parameters but return a value
https://ck.uesp.net/wiki/Weapon_Script

**Parameters**

    Form: target Weapon  (accepts both relative "Skyrim.esm:0xf" and absolute "0xf" values)  
    getter: getter name  

    GetBaseDamage  
    GetCritDamage  
    GetReach  
    GetMinRange  
    GetMaxRange  
    GetSpeed  
    GetStagger  
    GetWeaponType  
    GetModelPath  
    GetIconPath  
    GetMessageIconPath  
    GetEnchantment  
    GetEnchantmentValue  
    GetEquippedModel  
    GetEquipType  
    GetSkill  
    GetResist  
    GetCritEffect  
    GetCritEffectOnDeath  
    GetCritMultiplier  
    IsBattleAxe  
    IsBow  
    IsDagger  
    IsGreatsword  
    IsMace  
    IsStaff  
    IsSword  
    IsWarhammer  
    IsWarAxe  
    ;;;; will call form_dogetter if no matches are found  


**Example**

    set $someWeapon resultfrom form_getbyid $weaponFormID  
    weapon_dogetter $someWeapon GetBaseDamage  



# SexLab P+ Function Library 

## Actor

### actor_race

**Description**

Returns: string: the race name based on sub-function. Blank, empty sub-function returns Vanilla racenames. e.g. "SL" can return SexLab race keynames.

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

Returns: int: the actor's SexLab gender, 0 - male, 1 - female, 2 - futa, 3 - male creature, 4 - female creature

**Parameters**

    Form: actor: target Actor  


**Example**

    actor_getgender $actor  



### sl_add_cum

**Description**

Adds a cum layer to each requested slot for the target Actor

**Parameters**

    Form: actor: the Actor to query about being forbidden from SexLab scenes  
    bool: vaginal: if true, count vaginal cum layers (optional: default: true)  
    bool: oral: if true, count oral cum layers (optional: default: true)  
    bool: anal: if true, count anal cum layers (optional: default: true)  
    int: count: number of layers to add (optional: default: 1)  


**Example**

    ; to add an anal cum layer  
    sl_add_cum $system.self false false true  
    ; to add an oral cum layer  
    sl_add_cum $system.self false true  
    ; to add 2 vaginal cum layers  
    sl_add_cum $system.self true false false 2  
    ; to add 2 vaginal and anal cum layers  
    sl_add_cum $system.self true false true 2  



### sl_advance

**Description**

Changes the stage of the current SexLab scene, for the target Actor; advances a single stage if positive, reverses a single stage if negative
WARNING: This uses a deprecated API until/unless an up to date alternative can be found.

**Parameters**

    int: direction: <negative - backwards / non-negative (including zero) - forwards>  
    Form: actor: target Actor  


**Example**

    sl_advance -3 $system.self  

Only goes back one stage  


### sl_allow_actor

**Description**

Allows the Actor to join SexLab scenes. Reverses forbiddance.

**Parameters**

    Form: actor: the Actor to allow to join SexLab scenes  


**Example**

    sl_allow_actor $targetActor  



### sl_animname

**Description**

Returns: string: the current SexLab animation name
WARNING: This uses a deprecated API until/unless an up to date alternative can be found.

**Parameters**

    Form: actor: target Actor  


**Example**

    sl_animname $system.self  
    msg_notify "Playing: " $$  



### sl_clear_cum

**Description**

Clears cum layers from the target actor

**Parameters**

    Form: actor: the target Actor  
    bool: vaginal: if true, count vaginal cum layers (optional: default: true)  
    bool: oral: if true, count oral cum layers (optional: default: true)  
    bool: anal: if true, count anal cum layers (optional: default: true)  


**Example**

    sl_clear_cum $system.self  



### sl_count_cum

**Description**

Returns: int: count of cum layers for the actor of the specified type(s)

**Parameters**

    Form: actor: the Actor to query about being forbidden from SexLab scenes  
    bool: vaginal: if true, count vaginal cum layers (optional: default: true)  
    bool: oral: if true, count oral cum layers (optional: default: true)  
    bool: anal: if true, count anal cum layers (optional: default: true)  


**Example**

    ; to count only vaginal and anal cum layers  
    sl_count_cum $system.self true false true  
    ; to count only vaginal layers  
    sl_count_cum $system.self true  



### sl_disableorgasm

**Description**

Disables or enables the ability to orgasm via standard SexLab sex activity (orgasms can still be forced by mods)
Only works if called during a scene, when the SexLab thread is still available

**Parameters**

    Form: actor: target Actor  
    bool: disable: true to disable, false to enable  


**Example**

    sl_disableorgasm $system.player true  
    ; this disables orgasm for the player  
    sl_disableorgasm $system.player false  
    ; this enables orgasm for the player  



### sl_find_available_partners

**Description**

Returns: Form[]: a list of Actors that are available for a SexLab scene based on the parameters provided.
Note: This currently relies on deprecated API calls.
Note: Actors you specify in 'requiredActors' are not guaranteed to be valid SexLab actors.
If no matches can be found or if totalRequired is less than requiredActors.Length, requiredActors is returned, even if it is none or an empty list.

**Parameters**

    Form[]: requiredActors: list of Actors you require to be in the scene, limited to 5; size applies to totalRequired; specify none or an empty list if you have no required actors  
    int: totalRequired: the total number of actors desired for the scene (including any in the 'actors' list); should be at least as large as requiredActors.Length and should not be greater than 5  
    int: malesRequired: (optional: default: -1) minimum number of males desired for the scene, out of totalRequired; specify -1 to ignore the requirement  
    int: femalesRequired: (optional: default: -1) minimum number of females desired for the scene, out of totalRequired; specify -1 to ignore the requirement  
    float: radius: (optional: default: 10000.0) distance in Skyrim distance units to search for actors  


**Example**

    ; declare a list of actors you require in the scene, in this case, just the player is required, we are looking for partners  
    Form[] $playerOnlyList  
    listadd $playerOnlyList $system.player  
    ; Assuming a match can be found, we are looking for having 2 total, starting with the player, adding 1 male, in a 2000 unit radius  
    sl_find_available_partners $playerOnlyList 2 1 -1 2000.0  
    ; If instead you want the player plus 2 men and 1 woman, for a total of 4, searched in the default radius (of 10,000.0 distance units)  
    sl_find_available_partners $playerOnlyList 4 2 1  
    ; Or if you want to match with anyone so long as you have a partner, taking all other defaults (this is the minimum number of arguments required)  
    sl_find_available_partners $playerOnlyList 2  
    ; Make it random? 2-5, inclusive of the player?  
    set $sceneSize resultfrom rnd_int 2 5  
    set $scenePartners resultfrom sl_find_available_partners $playerOnlyList $sceneSize  
    ; and then you could call sl_startsex, for example, with the player as the submissive, no tag requirements, no beds allowed  
    sl_startsex $scenePartners $system.player "" false  
    ; or if you want a more consensual scene, you could call sl_startsex, with none as the submissive, "Anal", and "Oral" tag requirements, no beds allowed  
    sl_startsex $scenePartners none "Anal, Oral" false  



### sl_forbid_actor

**Description**

Forbids the Actor from joining SexLab scenes.

**Parameters**

    Form: actor: the Actor to forbid from joining SexLab scenes  


**Example**

    sl_forbid_actor $targetActor  



### sl_get_statistic

**Description**

Returns: float: the value of the specificed SexLab statistic

**Parameters**

    Form: actor: the Actor to query the statistic of  
    int: statisticID: the SexLab statistic ID  
    * 0 - LastUpdate_GameTime  
    * 1 - SecondsInScene  
    * 2 - XP_Vaginal  
    * 3 - XP_Anal  
    * 4 - XP_Oral  
    * 5 - PartnersMale  
    * 6 - PartnersFemale  
    * 7 - PartnersFuta  
    * 8 - PartnersCreature  
    * 9 - TimesOral  
    * 10 - TimesVaginal  
    * 11 - TimesAnal  
    * 12 - TimesMasturbated  
    * 13 - TimesSubmissive  
    * 14 - TimesDominant  
    * 15 - TimesTotal  
    * 16 - Sexuality  
    * 17 - Arousal  


**Example**

    sl_get_statistic $system.player 15  



### sl_getapi

**Description**

Returns: Form: the SexLabFramework API object (from SexLabUtil.GetAPI())


**Example**

    set $slapi resultfrom sl_getapi  



### sl_getprop

**Description**

Returns: string: the value of the requested SexLab thread property

**Parameters**

    string: property:  Stage | ActorCount  
    Form: actor: target Actor  


**Example**

    sl_getprop Stage $system.self  
    msg_notify "Current Stage: " $$  



### sl_getrndactor

**Description**

Returns: Form: a random actor within specified range of self

**Parameters**

    float: range: (0 - all | >0 - range in Skyrim units)  
    int: option: (0 - all | 1 - not in SexLab scene | 2 - must be in SexLab scene) (optional: default 0 - all)  


**Example**

    sl_getrndactor 500 2  
    actor_isvalid $actor  
    if $$ = false [end]  
    msg_notify "Someone is nearby!"  
    [end]  



### sl_getversion

**Description**

Returns: int: the SexLab version as an int (from SexLabUtil.GetVersion())


**Example**

    set $slversion resultfrom sl_getversion  



### sl_getversionstring

**Description**

Returns: string: the SexLab version as a string (from SexLabUtil.GetStringVer())


**Example**

    set $slversionstring resultfrom sl_getversionstring  



### sl_hastag

**Description**

Returns: bool: true if the SexLab scene has the specified tag, false otherwise

**Parameters**

    string: tag: tag name e.g. "Oral", "Anal", "Vaginal"  
    Form: actor: target Actor  


**Example**

    sl_hastag "Oral" $system.self  
    if $$ = true ORAL  



### sl_is_forbidden

**Description**

Returns: bool: true if the actor is forbidden from SexLab scenes, false otherwise

**Parameters**

    Form: actor: the Actor to query about being forbidden from SexLab scenes  


**Example**

    sl_is_forbidden $system.player  



### sl_is_valid_actor

**Description**

Returns: bool: true if the actor is valid for SexLab scenes, false otherwise

**Parameters**

    Form: actor: the Actor to determine SexLab scene validity for  


**Example**

    sl_is_valid_actor $targetActor  



### sl_isactive

**Description**

Returns: bool: active status of SexLab (from SexLabUtil.SexLabIsActive()): true if active, false otherwise


**Example**

    set $sl_is_active resultfrom sl_isactive  



### sl_isin

**Description**

Returns: bool: true if the specified actor is in a SexLab scene, false otherwise

**Parameters**

    Form: actor: target Actor  


**Example**

    sl_isin $system.self  



### sl_isinslot

**Description**

Returns: bool: true if the specified actor is in the specified SexLab scene slot, false otherwise

**Parameters**

    Form: actor: target Actor  
    int: slotnumber: 1-based SexLab thread slot number  


**Example**

    sl_isinslot $system.player 1  



### sl_isready

**Description**

Returns: bool: ready status of SexLab (from SexLabUtil.SexLabIsReady()): true if ready, false otherwise


**Example**

    set $sl_is_ready resultfrom sl_isready  



### sl_orgasm

**Description**

Immediately forces the specified actor to have a SexLab orgasm.

**Parameters**

    Form: actor: target Actor  


**Example**

    sl_orgasm $system.self  
    sl_orgasm $system.partner  

Simultaneous orgasms  


### sl_startsex

**Description**

Returns: int: Starts a SexLab scene and returns the threadid

**Parameters**

    Form[]: actors: list containing the Actors to be in the scene, limited to 5  
    Form: submissive: Form (Actor) to be the submissive in the scene; specify 'none' if no submissive to be set; must also be in the actors list  
    string: tags: (From the SexLabFramework source) Requested animation tags (may be empty). Supported prefixes: '-' to disable a tag, '~' for OR-conjunctions  
    Example: "~A, B, ~C, -D" <=> Animation has tag B, does NOT have tag D and has EITHER tag A or C  
    int: furniture: 0 - Disable, 1 - Allow, 2 - Prefer  


**Example**

    sl_startsex $actorList none "Oral, Anal" 0  
    ; starts a sex scene with the given actor list, no submissives, oral or anal tagged, with no beds allowed  
    sl_startsex $actorList $actorList[0] "Vaginal" 1  
    ; starts a sex scene with the given actor list, the first on the list being the submissive, vaginal tagged, beds allowed but not necessarily preferred  



### sl_validate_actor

**Description**

Returns: int:

**Parameters**

    Form actor: the Actor to determine SexLab scene validity for  


**Example**

    sl_validate_actor $targetActor  

1 - if valid, negative values with respective meanings for non-validity  
-1 = The Actor does not exists (it is None)  
-10 = The Actor is already part of a SexLab animation  
-11 = The Actor is forbidden form SexLab animations  
-12 = The Actor does not have the 3D loaded  
-13 = The Actor is dead (He's dead Jim.)  
-14 = The Actor is disabled  
-15 = The Actor is flying (so it cannot be SexLab animated)  
-16 = The Actor is on mount (so it cannot be SexLab animated)  
-17 = The Actor is a creature but creature animations are disabled  
-18 = The Actor is a creature that is not supported by SexLab  
-19 = The Actor is a creature but there are no valid animations for this type of creature  


### sl_waitforkbd

**Description**

Returns: int: the keycode pressed after waiting for user to press any of the specified keys or for the end of the SexLab scene
(See https://ck.uesp.net/wiki/Input_Script for the DXScanCodes)
Usage 1: sl_waitforkbd <dxscancode> [<dxscancode> ...]
Usage 2: sl_waitforkbd $keylist ; where $keylist is a int[]

**Parameters**

    int: dxscancode: <DXScanCode of key>  
    int[]: keylist: a list of dxscancode  


**Example**

    sl_waitforkbd 74 78 181 55  
    listadd $keystowaitfor 74 78 181 55  
    sl_waitforkbd $keystowaitfor  
    if $$ = 74 MINUS  
    ...  
    if $$ < 0 END  

; These do the same thing  
Wait for Num-, Num+, Num/, or Num*, or animation expired, and then do something based on the result.  


### util_waitforend

**Description**

Wait until specified actor is not in SexLab scene

**Parameters**

    Form: actor: target Actor  


**Example**

    util_waitforend $system.self  

Wait until the scene ends  


# SexLab 1.66 Function Library 

## Actor

### actor_race

**Description**

Returns: string: the race name based on sub-function. Blank, empty sub-function returns Vanilla racenames. e.g. "SL" can return SexLab race keynames.

**Parameters**

    Form: actor: target Actor  
    string: sub-function: sub-function  

    if parameter 2 is "": return actors race name. Skyrims, original name. Like: "Nord", "Breton"  
    if parameter 2 is "SL": return actors Sexlab frameworks race key name. Like: "dogs", "bears", etc. Note: will return "" if actor is humanoid  


**Example**

    actor_race $system.self "SL"  
    msg_notify "  Race SL: " $$  



## SexLab

### actor_getgender

**Description**

Returns: int: the actor's SexLab gender, 0 - male, 1 - female, 2 - male creature, 3 - female creature

**Parameters**

    Form: actor: target Actor  


**Example**

    actor_getgender $actor  



### sl_add_cum

**Description**

Adds a cum layer to each requested slot for the target Actor

**Parameters**

    Form: actor: the Actor to query about being forbidden from SexLab scenes  
    bool: vaginal: if true, count vaginal cum layers (optional: default: true)  
    bool: oral: if true, count oral cum layers (optional: default: true)  
    bool: anal: if true, count anal cum layers (optional: default: true)  


**Example**

    ; to add an anal cum layer  
    sl_add_cum $system.self false false true  
    ; to add an oral cum layer  
    sl_add_cum $system.self false true  
    ; to add a vaginal cum layer  
    sl_add_cum $system.self true  
    ; to add a vaginal and anal cum layer  
    sl_add_cum $system.self true false true  



### sl_advance

**Description**

Changes the stage of the current SexLab scene, for the target Actor; advances a single stage if positive, reverses a single stage if negative

**Parameters**

    int: direction: <negative - backwards / non-negative (including zero) - forwards>  
    Form: actor: target Actor  


**Example**

    sl_advance -3 $system.self  

Only goes back one stage  


### sl_allow_actor

**Description**

Allows the Actor to join SexLab scenes. Reverses forbiddance.

**Parameters**

    Form: actor: the Actor to allow to join SexLab scenes  


**Example**

    sl_allow_actor $targetActor  



### sl_animname

**Description**

Returns: string: to the current SexLab animation name

**Parameters**

    Form: actor: target Actor  


**Example**

    sl_animname $system.self  
    msg_notify "Playing: " $$  



### sl_clear_cum

**Description**

Clears cum layers from the target actor

**Parameters**

    Form: actor: the target Actor  


**Example**

    sl_clear_cum $system.self  



### sl_count_cum

**Description**

Returns: int: count of cum layers for the actor of the specified type(s)

**Parameters**

    Form: actor: the Actor to query about being forbidden from SexLab scenes  
    bool: vaginal: if true, count vaginal cum layers (optional: default: true)  
    bool: oral: if true, count oral cum layers (optional: default: true)  
    bool: anal: if true, count anal cum layers (optional: default: true)  


**Example**

    ; to count only vaginal and anal cum layers  
    sl_count_cum $system.self true false true  
    ; to count only vaginal layers  
    sl_count_cum $system.self true  



### sl_disableorgasm

**Description**

Disables or enables the ability to orgasm via standard SexLab sex activity (orgasms can still be forced by mods)
Only works if called during a scene, when the SexLab thread is still available

**Parameters**

    Form: actor: target Actor  
    bool: disable: true to disable, false to enable  


**Example**

    sl_disableorgasm $system.player true  
    ; this disables orgasm for the player  
    sl_disableorgasm $system.player false  
    ; this enables orgasm for the player  



### sl_find_available_partners

**Description**

Returns: Form[]: a list of Actors that are available for a SexLab scene based on the parameters provided.
Note: Actors you specify in 'requiredActors' are not guaranteed to be valid SexLab actors.
If no matches can be found or if totalRequired is less than requiredActors.Length, requiredActors is returned, even if it is none or an empty list.

**Parameters**

    Form[]: requiredActors: list of Actors you require to be in the scene, limited to 5; size applies to totalRequired; specify none or an empty list if you have no required actors  
    int: totalRequired: the total number of actors desired for the scene (including any in the 'actors' list); should be at least as large as requiredActors.Length and should not be greater than 5  
    int: malesRequired: (optional: default: -1) minimum number of males desired for the scene, out of totalRequired; specify -1 to ignore the requirement  
    int: femalesRequired: (optional: default: -1) minimum number of females desired for the scene, out of totalRequired; specify -1 to ignore the requirement  
    float: radius: (optional: default: 10000.0) distance in Skyrim distance units to search for actors  


**Example**

    ; declare a list of actors you require in the scene, in this case, just the player is required, we are looking for partners  
    Form[] $playerOnlyList  
    listadd $playerOnlyList $system.player  
    ; Assuming a match can be found, we are looking for having 2 total, starting with the player, adding 1 male, in a 2000 unit radius  
    sl_find_available_partners $playerOnlyList 2 1 -1 2000.0  
    ; If instead you want the player plus 2 men and 1 woman, for a total of 4, searched in the default radius (of 10,000.0 distance units)  
    sl_find_available_partners $playerOnlyList 4 2 1  
    ; Or if you want to match with anyone so long as you have a partner, taking all other defaults (this is the minimum number of arguments required)  
    sl_find_available_partners $playerOnlyList 2  
    ; Make it random? 2-5, inclusive of the player?  
    set $sceneSize resultfrom rnd_int 2 5  
    set $scenePartners resultfrom sl_find_available_partners $playerOnlyList $sceneSize  
    ; and then you could call sl_startsex, for example, with the player as the submissive, no tag requirements, no beds allowed  
    sl_startsex $scenePartners $system.player "" false  
    ; or if you want a more consensual scene, you could call sl_startsex, with none as the submissive, "Anal", and "Oral" tag requirements, no beds allowed  
    sl_startsex $scenePartners none "Anal, Oral" false  



### sl_forbid_actor

**Description**

Forbids the Actor from joining SexLab scenes.

**Parameters**

    Form: actor: the Actor to forbid from joining SexLab scenes  


**Example**

    sl_forbid_actor $targetActor  



### sl_get_skill

**Description**

Returns: float: the float value of the specificed SexLab skill

**Parameters**

    Form: actor: the Actor to query the skill of  
    string: skillId: the SexLab skill ID  
    * Foreplay  
    * Vaginal  
    * Anal  
    * Oral  
    * Pure  
    * Lewd  
    * Males  
    * Females  
    * Creatures  
    * Masturbations  
    * Aggressor  
    * Victim  
    * SexCount  
    * PlayerSex  
    * Sexuality  
    * TimeSpent  
    * LastSex.RealTime  
    * LastSex.GameTime  
    * VaginalCount  
    * AnalCount  
    * OralCount  


**Example**

    sl_get_skill $system.player 20  



### sl_getapi

**Description**

Returns: Form: the SexLabFramework API object (from SexLabUtil.GetAPI())


**Example**

    set $slapi resultfrom sl_getapi  



### sl_getprop

**Description**

Returns: string: the value of the requested SexLab thread property

**Parameters**

    string: property:  Stage | ActorCount  
    Form: actor: target Actor  


**Example**

    sl_getprop Stage $system.self  
    msg_notify "Current Stage: " $$  



### sl_getrndactor

**Description**

Returns: Form: a random actor within specified range of self

**Parameters**

    float: range: (0 - all | >0 - range in Skyrim units)  
    int: option: (0 - all | 1 - not in SexLab scene | 2 - must be in SexLab scene) (optional: default 0 - all)  


**Example**

    sl_getrndactor 500 2  
    actor_isvalid $actor  
    if $$ = false [end]  
    msg_notify "Someone is watching you!"  
    [end]  



### sl_getversion

**Description**

Returns: int: the SexLab version as an int (from SexLabUtil.GetVersion())


**Example**

    set $slversion resultfrom sl_getversion  



### sl_getversionstring

**Description**

Returns: string: the SexLab version as a string (from SexLabUtil.GetStringVer())


**Example**

    set $slversionstring resultfrom sl_getversionstring  



### sl_hastag

**Description**

Returns: bool: true if the SexLab scene has the specified tag, false otherwise

**Parameters**

    string: tag: tag name e.g. "Oral", "Anal", "Vaginal"  
    Form: actor: target Actor  


**Example**

    sl_hastag "Oral" $system.self  
    if $$ = true ORAL  



### sl_is_forbidden

**Description**

Returns: bool: true if the actor is forbidden from SexLab scenes, false otherwise

**Parameters**

    Form: actor: the Actor to query about being forbidden from SexLab scenes  


**Example**

    sl_is_forbidden $system.player  



### sl_is_valid_actor

**Description**

Returns: bool: true if the actor is valid for SexLab scenes, false otherwise

**Parameters**

    Form: actor: the Actor to determine SexLab scene validity for  


**Example**

    sl_is_valid_actor $targetActor  



### sl_isactive

**Description**

Returns: bool: active status of SexLab (from SexLabUtil.SexLabIsActive()): true if active, false otherwise


**Example**

    set $sl_is_active resultfrom sl_isactive  



### sl_isin

**Description**

Returns: bool: true if the specified actor is in a SexLab scene, false otherwise

**Parameters**

    Form: actor: target Actor  


**Example**

    sl_isin $system.self  



### sl_isinslot

**Description**

Returns: bool: true if the specified actor is in the specified SexLab scene slot, false otherwise

**Parameters**

    Form: actor: target Actor  
    int: slotnumber: 1-based SexLab thread slot number  


**Example**

    sl_isinslot $system.player 1  



### sl_isready

**Description**

Returns: bool: ready status of SexLab (from SexLabUtil.SexLabIsReady()): true if ready, false otherwise


**Example**

    set $sl_is_ready resultfrom sl_isready  



### sl_orgasm

**Description**

Immediately forces the specified actor to have a SexLab orgasm.

**Parameters**

    Form: actor: target Actor  


**Example**

    sl_orgasm $system.self  
    sl_orgasm $system.partner  

Simultaneous orgasms  


### sl_startsex

**Description**

Returns: int: Starts a SexLab scene and returns the threadid

**Parameters**

    Form[]: actors: list containing the Actors to be in the scene, limited to 5  
    Form: submissive: Form (Actor) to be the submissive in the scene; specify 'none' if no submissive to be set; must also be in the actors list  
    string: tags: (From the SexLabFramework source) AnimationTags [OPTIONAL], is the list of tags the animation has to have. You can add more than one tag by separating them by commas "," (Example: "Oral, Aggressive, FemDom"), the animations will be collected if they have at least one of the specified tags.  
    bool: allowBed: true to allow bed use, false otherwise  


**Example**

    sl_startsex $actorList none "Oral, Anal" false  
    ; starts a sex scene with the given actor list, no submissives, oral or anal tagged only, with no beds allowed  
    sl_startsex $actorList $actorList[0] "Vaginal" true  
    ; starts a sex scene with the given actor list, the first on the list being the submissive, vaginal tagged only, beds allowed  



### sl_validate_actor

**Description**

Returns an int value

**Parameters**

    Form: actor: the Actor to determine SexLab scene validity for  


**Example**

    sl_validate_actor $targetActor  

1 - if valid, negative values with respective meanings for non-validity  
-1 = The Actor does not exists (it is None)  
-10 = The Actor is already part of a SexLab animation  
-11 = The Actor is forbidden form SexLab animations  
-12 = The Actor does not have the 3D loaded  
-13 = The Actor is dead (He's dead Jim.)  
-14 = The Actor is disabled  
-15 = The Actor is flying (so it cannot be SexLab animated)  
-16 = The Actor is on mount (so it cannot be SexLab animated)  
-17 = The Actor is a creature but creature animations are disabled  
-18 = The Actor is a creature that is not supported by SexLab  
-19 = The Actor is a creature but there are no valid animations for this type of creature  


### sl_waitforkbd

**Description**

Returns: int: the keycode pressed after waiting for user to press any of the specified keys or for the end of the SexLab scene
(See https://ck.uesp.net/wiki/Input_Script for the DXScanCodes)
Usage 1: sl_waitforkbd <dxscancode> [<dxscancode> ...]
Usage 2: sl_waitforkbd $keylist ; where $keylist is a int[]

**Parameters**

    int: dxscancode: <DXScanCode of key>  
    int[]: keylist: a list of dxscancode  


**Example**

    sl_waitforkbd 74 78 181 55  
    listadd $keystowaitfor 74 78 181 55  
    sl_waitforkbd $keystowaitfor  
    if $$ = 74 MINUS  
    ...  
    if $$ < 0 END  

; These do the same thing  
Wait for Num-, Num+, Num/, or Num*, or animation expired, and then do something based on the result.  


### util_waitforend

**Description**

Wait until specified actor is not in SexLab scene

**Parameters**

    Form: actor: target Actor  


**Example**

    util_waitforend $system.self  

Wait until the scene ends  


## SexLab Separate Orgasms

### slso_bonus_enjoyment

**Description**

Applies BonusEnjoyment to the specified actor

**Parameters**

    Form: actor: target Actor  
    int: enjoyment: bonus enjoyment to apply  


**Example**

    slso_bonus_enjoyment $system.self 30  



# SexLab Dependent Function Library 

## Devious Devices

### dd_unlockall

**Description**

Attempts to unlock all devices locked on the actor

**Parameters**

    Form: actor: target Actor  
    string: force: "force" to force an unlock, anything else otherwise  


**Example**

    dd_unlockall $system.self force  

Will attempt to (forcibly if necessary, e.g. quest locked items) unlock all lockable items on targeted actor.  


### dd_unlockslot

**Description**

Attempts to unlock any device in the specified slot

**Parameters**

    Form: actor: target Actor  
    int: armorslot: int value armor slot e.g. 32 is body armor  
    string: force: "force" to force an unlock, anything else otherwise  


**Example**

    dd_unlockslot $system.self 32 force  

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

    int: newdebt: new debt value  


**Example**

    df_setdebt 0  

We all know what you are going to use it for  


## SexLab Aroused/OSLAroused

### sla_get_actor_days_since_last_orgasm

**Description**

Returns: float: the days since the actor last had an orgasm as a float

**Parameters**

    Form: actor: target Actor  


**Example**

    sla_get_actor_days_since_last_orgasm $system.self  



### sla_get_arousal

**Description**

Returns: int: the current arousal of the actor as an int

**Parameters**

    actor: target Actor  


**Example**

    sla_get_arousal  



### sla_get_exposure

**Description**

Returns: int: the current exposure level of the actor as an int

**Parameters**

    actor: target Actor  


**Example**

    sla_get_exposure $system.self  



### sla_get_version

**Description**

Returns: int: the version of SexLabAroused or OSLAroused


**Example**

    sla_get_version  
    msg_console "Version is: " $$  



### sla_send_exposure_event

**Description**

Sends the "slaUpdateExposure" modevent. No return value.

**Parameters**

    Form: actor: target Actor  
    float: exposureAmount: amount of exposure update to send  


**Example**

    sla_send_exposure_event $system.self 5.0  



### sla_set_exposure

**Description**

Sets the exposure for the target actor and returns the new amount as an int

**Parameters**

    Form: actor: target Actor  
    int: exposureAmount: amount of exposure update to set  


**Example**

    sla_set_exposure $system.self 25  



### sla_update_exposure

**Description**

Updates the exposure for the target actor and returns the updated amount as an int.
This uses the API, not a modevent directly (though the API may still be sending a modevent behind the scenes)

**Parameters**

    Form: actor: target Actor  
    int: exposureAmount: amount of exposure update to apply  


**Example**

    sla_update_exposure $system.self 5  



## SexLab Survival

### sls_add_magic_curse

**Description**

Adds the SLS magic curse to the target

**Parameters**

    Form: akTarget: the target to add the magic curse to  


**Example**

    sls_add_magic_curse $system.self  



### sls_block_license_purchase

**Description**

Blocks or unblocks license purchasing

**Parameters**

    Form: blocker: the Form to use as the "blocker"; use $system.forms.sltr_main if you don't have a Form you prefer  
    bool: abBlock: true to block license purchases; false to unblock  


**Example**

    sls_block_license_purchase $system.forms.sltr_main true ; the player will no longer be able to purchases licenses  



### sls_do_female_pain_sound

**Description**

Causes SLS to trigger the female pain sound

**Parameters**

    Form: target: target Actor  
    float: volume: volume level to emit the sound at  


**Example**

    sls_do_female_pain_sound $system.self 0.5  



### sls_do_hit_sound

**Description**

Causes SLS to trigger the hit sound

**Parameters**

    Form: target: target Actor  
    float: volume: volume level to emit the sound at  


**Example**

    sls_do_hit_sound $system.self 0.5  



### sls_do_trauma_hit_sound

**Description**

Causes SLS to trigger the trauma hit sound (of an actor being hit; as in the Trauma module)

**Parameters**

    Form: target: target Actor  
    bool: playerSqueaks: true if the player should squeak; false otherwise  


**Example**

    sls_do_trauma_hit_sound $system.self true  



### sls_evict_from_home

**Description**

Evicts the player from the specified player home

**Parameters**

    int: home: an ID to indicate which home to evict from  
    Form: evict_form: the Form to use as the "evicter"; use $system.forms.sltr_main if you don't have a Form you prefer  
    string: reason: the reason to present to the player for the eviction  

    0 - Whiterun  
    1 - Solitude  
    2 - Markarth  
    3 - Windhelm  
    4 - Riften  


**Example**

    ; to evict the player from Solitude  
    sls_evict_from_home 1 $system.forms.sltr_main "Naughty pets don't get pet houses."  



### sls_get_creature_corruption

**Description**

Returns: float: the current amount of creature corruption


**Example**

    set $corruption resultfrom sls_get_creature_corruption  



### sls_get_cum_stuffed_factor

**Description**

Returns: float: the value, 0.0-1.0 inclusive, representing how full of cum the target is from taking in cum; includes vaginal and oral amount

**Parameters**

    Form: target: Actor who is stuffed full of cum  


**Example**

    set $cum_stuffed_amount resultfrom sls_get_cum_stuffed_factor $system.player  



### sls_get_load_fullness

**Description**

Returns: float: the value, 0.0-1.0 inclusive, representing how full of cum the cum_source's balls are

**Parameters**

    Form: cum_source: Actor who is the source of the cum load  


**Example**

    set $load_fullness resultfrom sls_get_load_fullness $some_npc_or_creature  



### sls_get_load_size

**Description**

Returns: float: the cum load size from the cum_source at the specified tier

**Parameters**

    Form: cum_source: Actor who is the source of the cum load  
    int: cum_load_tier: the load_tier from sls_get_load_tier (optional: default: -1)  


**Example**

    set $load_size resultfrom sls_get_load_size $some_npc_or_creature $load_tier  



### sls_get_load_size_actual

**Description**

Returns: float: the actual cum load size from the cum_source at the specified tier

**Parameters**

    Form: cum_source: Actor who is the source of the cum load  
    int: base_load_size: the base load size from sls_get_load_size  


**Example**

    set $load_size_actual resultfrom sls_get_load_size_actual $some_npc_or_creature $base_load_size  



### sls_get_load_tier

**Description**

Returns: int: the cum load tier of the specified cum_source

**Parameters**

    Form: cum_source: Actor who is the source of the cum load  


**Example**

    set $load_tier resultfrom sls_get_load_tier $some_npc_or_creature  

0 - tiny - Skeever/Hare  
1 - small - Dog/Wolf  
2 - average - Most playable races  
3 - above average - Orcs/Nords  
4 - big - Troll/Horse/Bear/Sabrecat  
5 - huge - Mammoth  
6 - massive - Dragon  


### sls_get_skooma_junkie_level

**Description**

Returns: float: the skooma junkie level of the target

**Parameters**

    Form: target: Actor to check level for  
    bool is_withdrawing: true if withdrawal effects must be active; false if we don't care  


**Example**

    set $junkie_level resultfrom sls_get_skooma_junkie_level $system.self false  

0 - Not addicted  
1 - Experimentation  
2 - Regular use  
3 - Risky use  
4 - Dependence  
5 - Addiction  


### sls_increase_ground_time

**Description**

Increases the amount of time the player is "grounded" in a given hold

**Parameters**

    Form: crime_faction_member: an Actor member of the crime faction (i.e. Hold) where the player is to be grounded; specify none if you are using the "hold" argument  
    int: hold: an ID to indicate which hold the player is to be grounded; specify -1 if you are using crime_faction_member (optional; default: -1)  
    int: days: how many days to ground for (optional: default: 1)  

    -1 - Ignore  
    0 - Whiterun  
    1 - Solitude  
    2 - Markarth  
    3 - Windhelm  
    4 - Riften  


**Example**

    ; to ground the player in Markarth  
    sls_increase_ground_time none 2 5 ; ground the player in Markarth for 5 days  
    ; to ground the player in Riften  
    set $riften_guard ..somehow  
    sls_increase_ground_time $riften_guard ; ground the player in Riften for 1 day  



### sls_is_drugged

**Description**

Returns: bool: is the target drugged, checking skooma, Skooma Whore, and lactacid as indicated

**Parameters**

    Form: target: target Actor  
    bool: check_skooma: true to check skooma; false otherwise (optional: default: true)  
    bool: check_sw: true to check Skooma Whore; false otherwise (optional: default: true)  
    bool: check_lactacid: true to check MME Lactacid; false otherwise (optional: default: true)  


**Example**

    sls_is_drugged $system.self false false true  



### sls_is_enjoying_cum

**Description**

Returns: bool: is the player currently in the state of enjoying cum; varies based on factors like cum addiction, cum hunger


**Example**

    set $enjoying_cum resultfrom sls_is_enjoying_cum  



### sls_is_high_on_lactacid

**Description**

Returns: bool: is the target high on MME Lactacid

**Parameters**

    Form: target: target Actor  


**Example**

    sls_is_high_on_lactacid $system.self  



### sls_is_high_on_skooma

**Description**

Returns: bool: is the target high on skooma (not specifically Skooma Whore)

**Parameters**

    Form: target: target Actor  


**Example**

    sls_is_high_on_skooma $system.self  



### sls_is_high_on_skooma_whore_drugs

**Description**

Returns: bool: is the target high on Skooma Whore drugs (not just skooma generally)

**Parameters**

    Form: target: target Actor  


**Example**

    sls_is_high_on_skooma_whore_drugs $system.self  



### sls_remove_magic_curse

**Description**

Removes the SLS magic curse from the target

**Parameters**

    Form: akTarget: the target to remove the magic curse from  


**Example**

    sls_remove_magic_curse $system.self  



### sls_revoke_license

**Description**

Revokes SexLab Survival licenses

**Parameters**

    string: license: the license to revoke; valid values:  

    All - revokes all licenses  
    Random - revokes a random license  
    Magic  
    Weapon  
    Armor  
    Bikini  
    Clothes  
    Curfew  
    Whore  
    Freedom  
    Property  


**Example**

    sls_revoke_license "All" ; revokes all licenses  
    sls_revoke_license "Random" ; revokes a license at random  
    sls_revoke_license "Clothes" ; revokes a Clothes license if it exists  



### sls_send_to_kennel

**Description**

Send the player to the kennel associated with either the crime_faction_member or the hold specified by parameter; only one needs to provided

**Parameters**

    Form: crime_faction_member: an Actor member of the crime faction (i.e. Hold) where you want the player sent; specify none if you are using the "hold" argument  
    string: hold: the hold you want the player sent to; specify "" if you are using the "crime_faction_member"  

    Whiterun  
    Solitude  
    Markarth  
    Windhelm  
    Riften  


**Example**

    sls_send_to_kennel none "Riften" ; send the player to the Riften kennel  
    set $windhelm_guard ...fromsomewhere...  
    sls_send_to_kennel $windhelm_guard "" ; send the player to the Windhelm kennel by specifying a Windhelm guard  



### sls_swallow_cum

**Description**

Triggers the SLS cum swallow effect

**Parameters**

    Form: cum_source: the source of the cum  
    float: amount: an amount of cum to swallow  
    bool: did_swallow: true if the player tries to swallow everything; false otherwise  
    int add_to_face: how much cum to add to the player's face  

    0 - No cum  
    1 - 1 layer of cum  
    2 - 2 layers of cum  


**Example**

    sls_swallow_cum $system.partner 0.5 true 1  



### sls_unevict_from_home

**Description**

Unevicts the player from the specified player home, allowing them use of the home once more

**Parameters**

    int: home: an ID to indicate which home to evict from  
    Form: evict_form: the Form to use as the "evicter"; use $system.forms.sltr_main if you don't have a Form you prefer; must be the same as used to evict  

    0 - Whiterun  
    1 - Solitude  
    2 - Markarth  
    3 - Windhelm  
    4 - Riften  


**Example**

    ; to unevict the player from Solitude, allowing them use of the home there again  
    sls_unevict_from_home 1 $system.forms.sltr_main  



# OStim Function Library 

## OStim

### ostim_actorcount

**Description**

Returns: int: the actorcount of the OStim scene the targetActor is in; 0 if not in a scene

**Parameters**

    Form: targetActor: the actor whose scene you want the actor count from  


**Example**

    ostim_actorcount $system.self  



### ostim_animname

**Description**

Returns: string: the current OStim animation name

**Parameters**

    Form: actor: target Actor  


**Example**

    ostim_animname $system.self  
    msg_notify "Playing: " $$  



### ostim_climax

**Description**

Immediately forces the specified actor to have a OStim orgasm.
May only work during OStim scenes

**Parameters**

    Form: actor: target Actor  
    bool: ignoreStall: (optional; default:false) should the ClimaxStalled setting be ignored  


**Example**

    ostim_climax $system.self  
    ostim_climax $system.partner  

Simultaneous orgasms  


### ostim_findaction

**Description**

Returns: int: the action index if the OStim scene metadata has the specified action, -1 otherwise

**Parameters**

    string: action: action name e.g. "vaginalsex", "analsex", "blowjob"  
    Form: actor: (optional; default: $system.self) target Actor  


**Example**

    ostim_findaction "blowjob" $system.self  
    if $$ = true [doORALthing]  



### ostim_getrndactor

**Description**

Returns: Form: a random actor within specified range of self

**Parameters**

    float: range: (0 - all | >0 - range in Skyrim units)  
    int: option: (0 - all | 1 - not in OStim scene | 2 - must be in OStim scene) (optional: default 0 - all)  


**Example**

    ostim_getrndactor 500 2  
    actor_isvalid $actor  
    if $$ = false [end]  
    msg_notify "Someone is nearby!"  
    [end]  



### ostim_getsceneid

**Description**

Returns: string: the SceneID the targetActor is in; "" if not in a scene

**Parameters**

    Form: actor: target Actor  


**Example**

    ostim_getsceneid $system.self  
    msg_notify "SceneID: " $$  



### ostim_getthreadid

**Description**

Returns: int: the ThreadID for the OStim thread the target actor is in; -1 if not in a thread

**Parameters**

    Form: actor: target Actor  


**Example**

    ostim_getthreadid $system.self  



### ostim_hasaction

**Description**

Returns: bool: true if the OStim scene metadata has the specified action, false otherwise

**Parameters**

    string: action: action name e.g. "vaginalsex", "analsex", "blowjob"  
    Form: actor: (optional; default: $system.self) target Actor  


**Example**

    ostim_hasaction "blowjob" $system.self  
    if $$ = true [doORALthing]  



### ostim_isclimaxstalled

**Description**

Returns: bool: whether the actor is prevented from climaxing

**Parameters**

    Form: actor: target Actor  


**Example**

    ostim_isclimaxstalled $system.player  



### ostim_isin

**Description**

Returns: bool: true if the specified actor is in a OStim scene, false otherwise

**Parameters**

    Form: actor: target Actor  


**Example**

    ostim_isin $system.self  



### ostim_isinslot

**Description**

Returns: bool: true if the specified actor is in the specified OStim scene slot, false otherwise

**Parameters**

    Form: actor: target Actor  
    int: slotnumber: 1-based OStim actor position number  


**Example**

    ostim_isinslot $system.player 1  



### ostim_permitclimax

**Description**

Permits this actor to climax again (as in it undoes ostim_stallclimax)

**Parameters**

    Form actor: target Actor  


**Example**

    ostim_permitclimax $system.player  



### ostim_quickstart

**Description**

Returns: int: Starts an OStim scene and returns the ThreadId

**Parameters**

    Form[]: actors: list containing the Actors to be in the scene, limited to 5  
    string: animation: the animation to play (optional: default: "" which auto-selects)  
    Form: furniture: (ObjectReference) furniture to use (optional: default: none)  


**Example**

    ; start a solo session  
    Form[] $actor_list  
    set $actor_list[0] $system.self  
    ostim_quickstart $actor_list  



### ostim_stallclimax

**Description**

Prevents this actor from climaxing, including the prevention of auto climax animations
Does not prevent the climaxes of auto climax animations that already started

**Parameters**

    Form actor: target Actor  


**Example**

    ostim_stallclimax $system.player  



### ostim_waitforend

**Description**

Wait until specified actor is not in OStim scene

**Parameters**

    Form: actor: target Actor  


**Example**

    ostim_waitforend $self  

Wait until the scene ends  


### ostim_waitforkbd

**Description**

Returns: int: the keycode pressed after waiting for user to press any of the specified keys or for the end of the OStim scene
(See https://ck.uesp.net/wiki/Input_Script for the DXScanCodes)
Usage 1: ostim_waitforkbd <dxscancode> [<dxscancode> ...]
Usage 2: ostim_waitforkbd $keylist ; where $keylist is a int[]

**Parameters**

    int: dxscancode: <DXScanCode of key>  
    int[]: keylist: a list of dxscancode  


**Example**

    ostim_waitforkbd 74 78 181 55  
    listadd $keystowaitfor 74 78 181 55  
    ostim_waitforkbd $keystowaitfor  
    if $$ = 74 MINUS  
    ...  
    if $$ < 0 END  

; These do the same thing  
Wait for Num-, Num+, Num/, or Num*, or animation expired, and then do something based on the result.  


# Adult General Function Library 

## OSLAroused

### osla_get_actor_days_since_last_orgasm

**Description**

Returns: float: the result of OSLAroused_ModInterface.GetArousal()

**Parameters**

    Form: actor: target Actor  


**Example**

    osla_get_actor_days_since_last_orgasm $self  
    msg_console "Arousal is: " $$  



### osla_get_arousal

**Description**

Returns: float: the result of OSLAroused_ModInterface.GetArousal()

**Parameters**

    Form: actor: target Actor  


**Example**

    osla_get_arousal $system.self  
    msg_console "Arousal is: " $$  



### osla_get_arousal_multiplier

**Description**

Returns: float: the result of OSLAroused_ModInterface.GetArousal()

**Parameters**

    Form: actor: target Actor  


**Example**

    osla_get_arousal_multiplier $system.self  
    msg_console "Arousal multiplier is: " $$  



### osla_get_exposure

**Description**

Returns: float: the result of OSLAroused_ModInterface.GetArousal()

**Parameters**

    Form: actor: target Actor  


**Example**

    osla_get_exposure $system.self  
    msg_console "Exposure is: " $$  



### osla_modify_arousal

**Description**

Returns: float: the result of OSLAroused_ModInterface.ModifyArousal(Actor, float, string)

**Parameters**

    Form: actor: target Actor  
    float: value: value  
    string: reason: optional (default "unknown")  


**Example**

    osla_modify_arousal $system.self 20.0 "for reasons"  



### osla_modify_arousal_multiplier

**Description**

Returns: float: the result of OSLAroused_ModInterface.ModifyArousalMultiplier(Actor, float, string)

**Parameters**

    Form: actor: target Actor  
    float: value: value  
    string: reason: optional (default "unknown")  


**Example**

    osla_modify_arousal_multiplier $system.self 0.5 "for reasons"  



### osla_set_arousal

**Description**

Returns: float: the result of OSLAroused_ModInterface.SetArousal(Actor, float, string)

**Parameters**

    Form: actor: target Actor  
    float: value: value  
    string: reason: optional (default "unknown")  


**Example**

    osla_set_arousal $system.self 50.0 "for reasons"  



### osla_set_arousal_multiplier

**Description**

Returns: float: the result of OSLAroused_ModInterface.SetArousalMultiplier(Actor, float, string)

**Parameters**

    Form: actor: target Actor  
    float: value: value  
    string: reason: optional (default "unknown")  


**Example**

    osla_set_arousal_multiplier $system.self 2.0 "for reasons"  



## SLIF (SexLab Inflation Framework)

### slif_get_gender

**Description**

Returns: int: the integer value representing gender as SLIF knows it.

**Parameters**

    Form: actor: the Actor target for the SLIF call  
    int: gender: (optional: default: -1) default gender if not already set; use -1 to let SLIF determine the default  


Per SLIF documentation:  
male            = 0  
female          = 1  
shemale         = 2  
futanari        = 3  
genderless      = 4  
male_creature   = 5  
female_creature = 6  


### slif_get_incrvalue

**Description**

Returns: float: the increment value from SLIF for the node on the actor

**Parameters**

    Form: actor: the Actor target for the SLIF call  
    string: modName: your modname for SLIF purposes (you could use your script name)  
    string: node: the SLIF node to work with  
    float: default: (optional: default: 0.1) default value to assume if one is not already set  




### slif_get_maxvalue

**Description**

Returns: float: the max value from SLIF for the node on the actor

**Parameters**

    Form: actor: the Actor target for the SLIF call  
    string: modName: your modname for SLIF purposes (you could use your script name)  
    string: node: the SLIF node to work with  
    float: default: (optional: default: 100.0) default value to assume if one is not already set  




### slif_get_minvalue

**Description**

Returns: float: the min value from SLIF for the node on the actor

**Parameters**

    Form: actor: the Actor target for the SLIF call  
    string: modName: your modname for SLIF purposes (you could use your script name)  
    string: node: the SLIF node to work with  
    float: default: (optional: default: 0.0) default value to assume if one is not already set  




### slif_get_multvalue

**Description**

Returns: float: the multiplier value from SLIF for the node on the actor

**Parameters**

    Form: actor: the Actor target for the SLIF call  
    string: modName: your modname for SLIF purposes (you could use your script name)  
    string: node: the SLIF node to work with  
    float: default: (optional: default: 1.0) default value to assume if one is not already set  




### slif_get_value

**Description**

Returns: float: the current value from SLIF for the node on the actor

**Parameters**

    Form: actor: the Actor target for the SLIF call  
    string: modName: your modname for SLIF purposes (you could use your script name)  
    string: node: the SLIF node to work with  
    float: default: (optional: default: 0.0) default value to assume if one is not already set  




### slif_get_version

**Description**

Returns: int: a numeric version value, reported by SLIF




### slif_get_versionstring

**Description**

Returns: string: the version as a string, reported by SLIF




### slif_hide_node

**Description**

Tells SLIF to hide the node, with an optional hide value to set the scale to

**Parameters**

    Form: actor: the Actor target for the SLIF call  
    string: modName: your modname for SLIF purposes (you could use your script name)  
    string: node: the SLIF node to work with  
    float: value: (optional: default: 0.0000001) the value to apply for hiding  
    string: oldModName: (optional: default: "") see SLIF documentation; probably should use ""  




### slif_inflate

**Description**

Tells SLIF to inflate the actor, on the given node, for the given amount.

**Parameters**

    Form: actor: the Actor target for the SLIF call  
    string: modName: your modname for SLIF purposes (you could use your script name)  
    string: node: the SLIF node to work with  
    float: value: the value to apply  
    string: oldModName: (optional: default: "") see SLIF documentation; probably should use ""  




### slif_is_inmaintenance

**Description**

Returns: bool: true if SLIF is in maintenance mode, false otherwise




### slif_is_installed

**Description**

Returns: bool: true if SLIF is installed, false otherwise




### slif_is_node_hidden

**Description**

Returns: bool: true if the SLIF node is hidden on the actor, false otherwise

**Parameters**

    Form: actor: the Actor target for the SLIF call  
    string: node: the SLIF node to work with  




### slif_is_updating

**Description**

Returns: bool: true if SLIF is updating, false otherwise




### slif_is_working

**Description**

Returns: bool: true if SLIF is working, false otherwise




### slif_register_actor

**Description**

Tells SLIF to register the actor. SLIF automatically registers on first inflate call, so this is not always required.

**Parameters**

    Form: actor: the Actor target for the SLIF call  
    string: modName: your modname for SLIF purposes (you could use your script name)  
    string: node: (optional: default: "") the SLIF node to work with  
    string: oldModName: (optional: default: "") see SLIF documentation; probably should use ""  
    float: min: (optional: default: -1.0) min value  
    float: max: (optional: default: -1.0) max value  
    float: multiplier: (optional: default: -1.0) multiplier value  
    float: increment: (optional: default: -1.0) increment value  




### slif_reset_actor

**Description**

Resets the SLIF actor, with optional overrides for various settings

**Parameters**

    Form: actor: the Actor target for the SLIF call  
    string: modName: your modname for SLIF purposes (you could use your script name)  
    string: node: (optional: default: "") the SLIF node to reset  
    float: value: (optional: default: 1.0) the value to apply to reset to  
    string: oldModName: (optional: default: "") see SLIF documentation; probably should use ""  
    float: min: (optional: default: -1.0) min value  
    float: max: (optional: default: -1.0) max value  
    float: multiplier: (optional: default: -1.0) multiplier value  
    float: increment: (optional: default: -1.0) increment value  




### slif_set_default_values

**Description**

Sets the default values for SLIF for the node on the actor

**Parameters**

    Form: actor: the Actor target for the SLIF call  
    string: modName: your modname for SLIF purposes (you could use your script name)  
    string: node: the SLIF node to work with  
    float: min: (optional: default: 0.0) default min value if one is not specified  
    float: max: (optional: default: 100.0) default max value if one is not specified  
    float: multiplier: (optional: default: 1.0) default multiplier value if one is not specified  
    float: increment: (optional: default: 0.1) default increment value if one is not specified  




### slif_show_node

**Description**

Tells SLIF to show the node if it was previously hidden

**Parameters**

    Form: actor: the Actor target for the SLIF call  
    string: modName: your modname for SLIF purposes (you could use your script name)  
    string: node: the SLIF node to work with  




### slif_unregister_actor

**Description**

Tells SLIF to unregister the actor

**Parameters**

    Form: actor: the Actor target for the SLIF call  
    string: modName: your modname for SLIF purposes (you could use your script name)  




### slif_update_actor

**Description**

Tells SLIF to update the actor

**Parameters**

    Form: actor: the Actor target for the SLIF call  
    string: modName: your modname for SLIF purposes (you could use your script name)  
    string: node: (optional: default: "") the SLIF node to update  
    string: oldModName: (optional: default: "") see SLIF documentation; probably should use ""  
    float: min: (optional: default: -1.0) min value  
    float: max: (optional: default: -1.0) max value  
    float: multiplier: (optional: default: -1.0) multiplier value  
    float: increment: (optional: default: -1.0) increment value  




