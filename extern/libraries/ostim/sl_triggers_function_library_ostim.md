# OStim Function Library 

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



### ostim_waitforend

**Description**

Wait until specified actor is not in OStim scene

**Parameters**

    actor: target Actor  


**Example**

    ostim_waitforend $self  

Wait until the scene ends  


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


