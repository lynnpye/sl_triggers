# Adult General Function Library 

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




