# SexLab Dependent Function Library 

## Devious Devices

### dd_unlockall

**Description**

Attempts to unlock all devices locked on the actor

**Parameters**

    Form: actor: target Actor  
    string: force: "force" to force an unlock, anything else otherwise  


**Example**

    dd_unlockall $self force  

Will attempt to (forcibly if necessary, e.g. quest locked items) unlock all lockable items on targeted actor.  


### dd_unlockslot

**Description**

Attempts to unlock any device in the specified slot

**Parameters**

    Form: actor: target Actor  
    int: armorslot: int value armor slot e.g. 32 is body armor  
    string: force: "force" to force an unlock, anything else otherwise  


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



