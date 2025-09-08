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



