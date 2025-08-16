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



