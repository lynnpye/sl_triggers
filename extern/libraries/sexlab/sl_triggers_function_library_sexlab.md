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



