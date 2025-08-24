# SexLab 1.66 Function Library 

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


### sl_allow_actor

**Description**

Allows the Actor to join SexLab scenes. Reverses forbiddance.

**Parameters**

    Form actor: the Actor to allow to join SexLab scenes  


**Example**

    sl_allow_actor $targetActor  



### sl_animname

**Description**

Returns to the current SexLab animation name


**Example**

    sl_animname $system.self  
    msg_notify "Playing: " $$  



### sl_disableorgasm

**Description**

Disables or enables the ability to orgasm via standard SexLab sex activity (orgasms can still be forced by mods)
Only works if called during a scene, when the SexLab thread is still available

**Parameters**

    actor: target Actor  
    disable: bool: true to disable, false to enable  


**Example**

    sl_disableorgasm $system.player true  
    ; this disables orgasm for the player  
    sl_disableorgasm $system.player false  
    ; this enables orgasm for the player  



### sl_find_available_partners

**Description**

Returns a list of Actors (Form[]) that are available for a SexLab scene based on the parameters provided.
Note: Actors you specify in 'requiredActors' are not guaranteed to be valid SexLab actors.
If no matches can be found or if totalRequired is less than requiredActors.Length, requiredActors is returned, even if it is none or an empty list.

**Parameters**

    Form[] requiredActors: list of Actors you require to be in the scene, limited to 5; size applies to totalRequired; specify none or an empty list if you have no required actors  
    int totalRequired: the total number of actors desired for the scene (including any in the 'actors' list); should be at least as large as requiredActors.Length and should not be greater than 5  
    int malesRequired: (optional: default: -1) minimum number of males desired for the scene, out of totalRequired; specify -1 to ignore the requirement  
    int femalesRequired: (optional: default: -1) minimum number of females desired for the scene, out of totalRequired; specify -1 to ignore the requirement  
    float radius: (optional: default: 10000.0) distance in Skyrim distance units to search for actors  


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

    Form actor: the Actor to forbid from joining SexLab scenes  


**Example**

    sl_forbid_actor $targetActor  



### sl_get_skill

**Description**

Returns the float value of the specificed SexLab skill

**Parameters**

    Form actor: the Actor to query the skill of  
    string skillId: the SexLab skill ID  
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

Returns the SexLabFramework API object (from SexLabUtil.GetAPI())


**Example**

    set $slapi resultfrom sl_getapi  



### sl_getprop

**Description**

Returns the value of the requested SexLab thread property

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



### sl_getversion

**Description**

Returns the SexLab version as an int (from SexLabUtil.GetVersion())


**Example**

    set $slversion resultfrom sl_getversion  



### sl_getversionstring

**Description**

Returns the SexLab version as a string (from SexLabUtil.GetStringVer())


**Example**

    set $slversionstring resultfrom sl_getversionstring  



### sl_hastag

**Description**

Returns true if the SexLab scene has the specified tag, false otherwise

**Parameters**

    tag: tag name e.g. "Oral", "Anal", "Vaginal"  
    actor: target Actor  


**Example**

    sl_hastag "Oral" $system.self  
    if $$ = true ORAL  



### sl_is_forbidden

**Description**

Returns true if the actor is forbidden from SexLab scenes, false otherwise

**Parameters**

    Form actor: the Actor to query about being forbidden from SexLab scenes  


**Example**

    sl_is_forbidden $system.player  



### sl_is_valid_actor

**Description**

Returns true if the actor is valid for SexLab scenes, false otherwise

**Parameters**

    Form actor: the Actor to determine SexLab scene validity for  


**Example**

    sl_is_valid_actor $targetActor  



### sl_isactive

**Description**

Returns active status of SexLab (from SexLabUtil.SexLabIsActive()): true if active, false otherwise


**Example**

    set $sl_is_active resultfrom sl_isactive  



### sl_isin

**Description**

Returns true if the specified actor is in a SexLab scene, false otherwise

**Parameters**

    actor: target Actor  


**Example**

    sl_isin $system.self  



### sl_isinslot

**Description**

Returns true if the specified actor is in the specified SexLab scene slot, false otherwise

**Parameters**

    actor: target Actor  
    slotnumber: 1-based SexLab thread slot number  


**Example**

    sl_isinslot $system.player 1  



### sl_isready

**Description**

Returns ready status of SexLab (from SexLabUtil.SexLabIsReady()): true if ready, false otherwise


**Example**

    set $sl_is_ready resultfrom sl_isready  



### sl_orgasm

**Description**

Immediately forces the specified actor to have a SexLab orgasm.

**Parameters**

    actor: target Actor  


**Example**

    sl_orgasm $system.self  
    sl_orgasm $system.partner  

Simultaneous orgasms  


### sl_startsex

**Description**

Starts a SexLab scene and returns the threadid

**Parameters**

    Form[] list: actors: Form[] list containing the Actors to be in the scene, limited to 5  
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

Returns an int value; 1 - if valid, negative values with respective meanings for non-validity
* -1 = The Actor does not exists (it is None)
* -10 = The Actor is already part of a SexLab animation
* -11 = The Actor is forbidden form SexLab animations
* -12 = The Actor does not have the 3D loaded
* -13 = The Actor is dead (He's dead Jim.)
* -14 = The Actor is disabled
* -15 = The Actor is flying (so it cannot be SexLab animated)
* -16 = The Actor is on mount (so it cannot be SexLab animated)
* -17 = The Actor is a creature but creature animations are disabled
* -18 = The Actor is a creature that is not supported by SexLab
* -19 = The Actor is a creature but there are no valid animations for this type of creature

**Parameters**

    Form actor: the Actor to determine SexLab scene validity for  


**Example**

    sl_validate_actor $targetActor  



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



