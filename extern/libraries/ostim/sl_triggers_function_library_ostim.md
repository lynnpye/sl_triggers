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


