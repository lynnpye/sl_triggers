# SLTScript Documentation

## Overview

Script for SL Triggers, or SLTScript, is primarily a text file using a simple marker-to-enclose tokenization strategy. Lines are tokenized by splitting on whitespace, except when fields are enclosed in either double-quotes (`""`), dollar-double-quotes for string interpolation (`$""`) or square brackets (`[]`). Enclosed strings may contain whitespace, and embedded double quotes are escaped by doubling them (`""`).

The legacy option of .JSON still exists but is deprecated.

In cases where a bare word is detected and not determined to be a function or variable name, it will be interpreted as a string literal (`""`).

```sltscript
; $1 is a valid variable name, and this is an example of a comment
set $1 "Hello world"
msg_console $1
goto done

; stuff

[done]
```

## Basic Syntax and Commands

### Comments and Empty Lines
```sltscript
; semi-colon is a comment-to-end-of-line marker
```
Empty lines are ignored.

### Command Structure
Each command and its parameters must reside on one line, with any amount of separating, trailing, or preceding whitespace. Commands can be either **intrinsics** (part of the SLTScript language) or **functions** (from extension libraries).

**Generally, you won't need to worry about the distinction between 'intrinsics' and 'functions'; you can just refer to them all as 'commands'.**

### Script Execution
Scripts run each command in sequence until they encounter a `return` or reach the end of the script. This allows for very long-running scripts.

## Literals
SLTScript supports the following literals and literal types.

|Literal|Description|
|---|---|
|___string literals___|Anything surrounded in `""`, e.g.: `"string"`, `"Hello world!"`|
|___numeric values___|Any integer or float value. Integers can be expressed in hexadecimal notation e.g. `0x12`|
|`true`|boolean: true|
|`false`|boolean: false|
|`none`|Form: none|

## Variables

### Variables and Scopes
SLTScript supports scoped variables:

- **Local variables**: `$<name>` | `$local.<name>` - Available only to the currently executing script
- **Thread variables**: `$thread.<name>` - Available to any script on the current thread/callchain
- **Target variables**: `$target.<name>` - Available to any script running on the target
- **Global variables**: `$global.<name>` - Available to all scripts, persistent across saves

Variable names can include any of the following characters after the scope: `A-Za-z0-9._`.

### Special Scopes
#### System
`system` scoped variables are typically read-only and offer various system-level pieces of information.
|Variable|Returns|
|---|---|
|`$system.self`|Actor - the Actor the script is targeting/running on; for some triggers this will always be the Player|
|`$system.player`|Actor - the Player|
|`$system.actor`|Actor - the Actor returned from certain functions e.g. util_getrndactor|
|`$system.random.100`|float - random number between 0.0 and 100.0 inclusive|
|`$system.none`|Form - none; i.e. a null Form|
|`$system.is_player.inside`|bool - is the Player currently in an interior location|
|`$system.is_player.outside`|bool - is the Player currently in an exterior location|
|`$system.is_player.in_city`|bool - is the Player currently in a City, Town, Habitation, or Dwelling|
|`$system.is_player.in_dungeon`|bool - is the Player currently in a DraugrCrypt, DragonPriestLair, FalmerHive, VampireLair, Dwarven Ruin, Dungeon, Mine, or Cave|
|`$system.is_player.in_safe`|bool - is the Player currently in a PlayerHome, Jail, or Inn|
|`$system.is_player.in_wilderness`|bool - is the Player currently in a Hold, BanditCamp, MilitaryFort, or a Location with no keyword|
|`$system.is_player.in_combat`|bool - true if the Player is currently in combat, false otherwise|
|`$system.stats.running_scripts`|int - current count of running scripts; will always be 1 or greater because you will be calling it from a script|
|`$system.realtime`|float - the current real time (i.e. seconds since launch of SkyrimSE.exe) from Utility.GetCurrentRealtime()|
|`$system.gametime`|float - the current game time (i.e. in-game days since your save was created) from Utility.GetCurrentGametime()|
|`$system.initialGameTime`|float - the game time when the script was started|
|`$system.initialScriptName`|string - the initial script that was requested; might differ from current script in case `call` was used|
|`$system.currentScriptName`|string - the current script that is running; might differ from current script in case `call` was used|
|`$system.sessionid`|int - the current SLTR sessionid (changes with each load of a save or creation of a new game)|
|`$system.forms.gold`|Form - returns the Form for gold (i.e. "0xf|Skyrim.esm")|
|`$system.is_available.core`|bool - (Added by SLTR Core) is the SLTR Core extension available and enabled (very rare you would want this false)|
|`$system.is_available.sexlab`|bool - (Added by SLTR SexLab) is the SLTR SexLab extension available and enabled (would be false if you installed on a system without SexLab)|
|`$system.partner`|Actor - (Added by SLTR SexLab) the first member of the target Actor's current SexLab scene that is not the target Actor (same as `$sexlab.partner1`)|
|`$system.partner1`|Actor - (Added by SLTR SexLab) the first member of the target Actor's current SexLab scene that is not the target Actor (same as `$sexlab.partner`)|
|`$system.partner2`|Actor - (Added by SLTR SexLab) the second member of the target Actor's current SexLab scene that is not the target Actor|
|`$system.partner3`|Actor - (Added by SLTR SexLab) the third member of the target Actor's current SexLab scene that is not the target Actor|
|`$system.partner4`|Actor - (Added by SLTR SexLab) the fourth member of the target Actor's current SexLab scene that is not the target Actor|

#### Request
`request` scoped variables are also read-only and typically intended to convey information relevant to the context of the trigger, or the environment at the time the script was requested. Unlike `system` scoped variables that are intrinsic to the system, `request` scoped variables are only going to have relevant information in certain circumstances.

|Variable|Returns|
|---|---|
|`$request.core.activatedContainer`|Form - (Added by SLTR Core) container that was activated as part of a container activation trigger|
|`$request.core.activatedContainer.is_corpse`|bool - (Added by SLTR Core) true if the activated container was a corpse|
|`$request.core.activatedContainer.is_empty`|bool - (Added by SLTR Core) true if the activated container was empty|
|`$request.core.activatedContainer.is_common`|bool - (Added by SLTR Core) true if the activated container is one of the 'Common' types|
|`$request.core.activatedContainer.count`|int - (Added by SLTR Core) returns the current count of inventory items in the activated container (yes, current; remove something and this value's result will change)|
|`$request.core.was_player.inside`|bool - (Added by SLTR Core) was the Player "Inside" at the time the trigger was handled|
|`$request.core.was_player.outside`|bool - (Added by SLTR Core) was the Player "Outside" at the time the trigger was handled|
|`$request.core.was_player.in_safe_area`|bool - (Added by SLTR Core) was the Player "In a Safe Area" at the time the trigger was handled|
|`$request.core.was_player.in_city`|bool - (Added by SLTR Core) was the Player "In a City" at the time the trigger was handled|
|`$request.core.was_player.in_wilderness`|bool - (Added by SLTR Core) was the Player "In the Wilderness" at the time the trigger was handled|
|`$request.core.was_player.in_dungeon`|bool - (Added by SLTR Core) was the Player "In a Dungeon" at the time the trigger was handled|
|`$request.core.from_location`|bool - (Added by SLTR Core) (for OnLocationChange) the Location travelled from; might be none/empty for many outdoor locations|
|`$request.core.to_location`|bool - (Added by SLTR Core) (for OnLocationChange) the Location travelled to; might be none/empty for many outdoor locations|
|`$request.core.equipped_item.base_form`|Form - (Added by SLTR Core) (for Player Equipment Change) the base Form for the item that was equipped/unequipped|
|`$request.core.equipped_item.object_reference`|ObjectReference - (Added by SLTR Core) (for Player Equipment Change) the ObjectReference from the original event; typically only available for unique items (e.g. artifacts)|
|`$request.core.equipped_item.is_equipping`|bool - (Added by SLTR Core) (for Player Equipment Change) true if the item was being equipped; false if the item was being unequipped|
|`$request.core.equipped_item.is_unique`|bool - (Added by SLTR Core) (for Player Equipment Change) true if the item was unique (event provided ObjectReference) ; false otherwise|
|`$request.core.equipped_item.has_enchantments`|bool - (Added by SLTR Core) (for Player Equipment Change) true if the item had enchantments; false otherwise|
|`$request.core.equipped_item.type`|string - (Added by SLTR Core) (for Player Equipment Change) One of 'Armor', 'Weapon', 'Spell', 'Potion', or 'Ammo'|
|`$request.core.player_on_hit.attacker`|Form - (Added by SLTR Core) (for Player On Hit) the Player if the Player was attacking, their opponent if the Player was being attacked|
|`$request.core.player_on_hit.target`|Form - (Added by SLTR Core) (for Player On Hit) the Player if the Player was being attacked, their opponent if the Player was attacking|
|`$request.core.player_on_hit.source`|int - (Added by SLTR Core) (for Player On Hit) the source FormID (weapon/spell) used for the attack|
|`$request.core.player_on_hit.projectile`|int - (Added by SLTR Core) (for Player On Hit) the projectile FormID used for the attack if one was involved|

#### Core
`core` scoped variables are provided by the Core extension
|Variable|Returns|
|---|---|
|`$core.toh_elapsed`|float - actual elapsed time in hours since the previous top of the hour (may be larger than 1.0 if e.g. sleeping or traveling)|

### Data Types
Data types are preserved and coerced, with `string` as a default fallback. Forms will be "coerced" to their FormID.

**All variables are ultimately strings.** SLTScript automatically handles conversion between string, int, float, and bool types as needed. While Papyrus supports `Form` types, these require special handling in SLTScript.

#### FormID, Forms, and You
For any function that expects a Form like thing (e.g. Actor, ObjectReference, Form, ActorBase), you can provide any of the following:

- **Special Scoped Variables** `system` variables and perhaps variables in other scopes such as `request` may return Forms and can always be used where a Form is expected
- **Variables** If you perform a function that returns a Form and set a variable to store that result, you should be able to trust that using that variable where a Form is expected will work. For example:
```sltscript
actor_name $system.player
set $targetActor $$
; anything that expects an Actor should work with $targetActor
actor_isvalid $targetActor
; $$ will either be true or false depending on the validity of $targetActor
```
- **FormID Strings** You can also directly provide a FormID string; likewise, setting a variable to such a FormID string will also allow it to be used; FormID strings can be provided in several formats:
   - **<modfile>:<relative formid>** this is a commonly used format e.g. "skyrim.esm:0xf" or "skyrim.esm:15" for a septim (modfile: "skyrim.esm", formid: 0xf or 15)
   - **<relative formid>|<modfile>** another commonly used format e.g. "0xf|skyrim.esm" or "15|skyrim.esm"
   - **<absolute formid>** not so common but useful for local tinkering; note that absolute formids will change if your load order changes
   - **accepts decimal or hexadecimal** formid values can be specified as either decimal or hexadecimal; hexadecimal requires a leading `0x`
   - **<relative formid>** keep in mind the difference between an ESL flagged vs a non-ESL flagged mod; the ESL flagged mod has *only* (it's still a lot) 0xFFF room to work with, whereas other mods have the full 0xFFFFFF
```sltscript
; this is a relative FormID and 'Quick Start - SE.esp' is not ESL flagged, so we can safely assume the whole 0xFFFFFF is available
; although the high order bits aren't specified, for sake of discussion, let's assume Quick Start is at 0x23
set $quickstartchest = "0x003881|Quick Start - SE.esp"
; this is one of the containers in the Quick Start mod
form_dogetter $quickstartchest GetFormID
;  $$ would now contain something like 587,217,025 (i.e. int value of '587217025'), which is base 10 for hex value of 0x23003881
form_dogetter $quickstartchest GetName
; $$ would now contain something like "Chest" or whatever the name is from the mod
```

## Basic Operations

### Variable Assignment and Manipulation

#### `$"{variable}"` - Variable interpolation
You can use the `$"{variablename}"` construct to perform string interpolation. This will create a string literal with the specified variables injected into place. Scopes are respected, so you can also have references to e.g. `global` scoped variables.
```sltscript
set $global.monkey.count 21
set $var $"{global.monkey.count} Monkeys"
; $var now contains '21 Monkeys'
```

Note that when in the interpolation tag, the preceding `$` is avoided.

#### `set` - Basic Assignment
Sets the value of the specified variable.
```sltscript
set $1 "Hi there"
set $playerName "John"
```

#### `set resultfrom` - Assignment from Function
Sets a variable to the result of a function call.
```sltscript
set $playerName resultfrom actor_name $player
; $playerName now contains the player's name
```

#### `set from operation` - Assignment from Operation
Sets a variable to the result of an operation on two parameters.
- Operators: `+`, `-`, `*`, `/`, `&` (string concatenation)
```sltscript
set $var1 3
set $var2 5
set $total $var1 + $var2
; $total now contains 8
```

#### `inc` - Increment
Increments the numeric value of a variable by the specified amount (default: 1; float values like 2.3 are allowed).
```sltscript
set $2 12
inc $2 2
; $2 is now 14
inc $3    ; increments $3 by 1
```

#### `cat` - String Concatenation
Concatenates strings into the target variable.
```sltscript
cat $3 "one " "two " "three "
cat $4 $1 $2 $3
```

## Flow Control

### Labels and Jumps

#### Labels
A `[label]` marks a line as a valid target for `goto` or `if` statements.
```sltscript
[done]
[mylabel]
```

#### `goto` - Unconditional Jump
Resets execution to begin on the line immediately following the indicated label.
```sltscript
set $1 "done"
goto below
set $1 ""        ; this line is skipped
[done]
return
[below]
goto $1          ; jumps to 'done' label using variable
```

#### `if` - Conditional Jump
Performs a conditional check and redirects execution to a label if true.

**Syntax:**
```sltscript
; variant 1 - compare value1 and value 2
if <value1> <operator> <value2> <label>
; variant 2 - check value1 for "truthiness"
if <value1> <label>
```

**Operators:**
- Numeric: `=`/`==` (equality), `!=` (inequality), `>`, `>=`, `<`, `<=`
- String: `&=` (equality), `&!=` (inequality)

```sltscript
set $2 12
set $3 12
if $2 > $3 gogt
if $2 < $3 golt
if $2 = $3 goeq

[goeq]
; execution continues here if $2 equals $3
```

#### `if`/`elseif`/`else`/`endif` - Conditional Block
Performs conditional checks and executes the commands in the block where the conditional check matches. `else` is the default.

**Syntax:** 
```sltscript
; variant 1 - compare value1 and value 2
if <value1> <operator> <value2>
; variant 2 - check value1 for "truthiness"
if <value1>

; variant 1 - compare value1 and value 2
elseif <value1> <operator> <value2>
; variant 2 - check value1 for "truthiness"
elseif <value1>

; optional, default block if specified
else

; end of if-block
endif
```

**Operators:**
- Numeric: `=`/`==` (equality), `!=` (inequality), `>`, `>=`, `<`, `<=`
- String: `&=` (equality), `&!=` (inequality)

```sltscript
set $zeroth 0
set $first 1
set $second 2
set $third 3
set $istrue true

if $first > $second
    ; won't execute because 1 < 2
elseif $zeroth
    ; won't execute because 0 is not "truthy"
elseif $istrue
    ; this will execute because true is "truthy"
elseif $first < $second
    ; won't execute becuse the if-block has already been satisfied
else
    ; won't execute becuse the if-block has already been satisfied
endif
```

#### `while`/`endwhile` - Conditional Block Loop
Performs conditional checks and executes the commands in the block if the condition is true. Repeats the block until the condition is no longer true.
WARNING: You *must* ensure you do *something* to make the condition false at some point, or return from the script, or else you will have an infinite loop.

**Syntax:**
```sltscript
; variant 1 - compare value1 and value 2
while <value1> <operator> <value2>
; variant 2 - check value1 for "truthiness"
while <value1>

; end of while-block, if the conditional is still true, execution will begin again at the top of the block
endwhile
```

**Operators:**
- Numeric: `=`/`==` (equality), `!=` (inequality), `>`, `>=`, `<`, `<=`
- String: `&=` (equality), `&!=` (inequality)

```sltscript
set $counter 0
set $goal 10

while $counter < $goal
    ; this loop will iterate 10 times
    msg_console $"Iteration {counter}"
    inc $counter 1
endwhile
```

#### `return` - Exit Script
Exits the current SLTScript. If called from another script, execution returns to the calling script.
```sltscript
return
```

## Subroutines

### Defining and Using Subroutines
Subroutines allow you to create reusable blocks of code within your script.

#### `beginsub` and `endsub` - Define Subroutine
```sltscript
beginsub dosomethingcomplex
    ; Your subroutine code here
    ; Shares the same variables as the main script
endsub
```

#### `gosub` - Call Subroutine
```sltscript
gosub dosomethingcomplex
; execution continues here after subroutine completes
```

**Note:** If execution flow reaches a `beginsub` during normal script execution, it will skip to the corresponding `endsub`.

### Complete Subroutine Example
```sltscript
; Main script flow
gosub dosomethingcomplex
; more code
gosub dosomethingcomplex

beginsub dosomethingcomplex
    ; Complex task code here
    ; This code can be called multiple times
endsub
```

## Script Calling

### `call` - Execute Another Script
Calls another SLTScript with its own variable scope (heap). Note that when referencing scripts you can leave off the .sltscript extension.

**Syntax:** `call <script_name> [<arg1> <arg2> ...]`

```sltscript
; ScriptA.sltscript
set $1 100
call "ScriptB" "some argument"
; $1 is still 100 - ScriptB's changes don't affect this script
```

### `callarg` - Access Arguments
In the called script, use `callarg` to access passed arguments.

**Syntax:** `callarg <index> <variable>`

```sltscript
; ScriptB.sltscript
callarg 0 $receivedArg
; $receivedArg now contains "some argument"
```

### Complete Call Example
```sltscript
; ScriptA.sltscript
set $1 100
call "ScriptB"
if $1 >= 100 allgood
msg_notify "Something went wrong!"
return

[allgood]
msg_notify "All good!"

; ScriptB.sltscript
set $1 50  ; This doesn't affect ScriptA's $1
msg_notify "ScriptB executed successfully"
return
```

## Function Libraries

All commands beyond the intrinsics come from Function Libraries. SLTR includes a an expanding library with functions covering not only base Skyrim but also SexLab and related mods.

For detailed information about available functions, see the [Function Libraries](../Function-Libraries) wiki page.

## Best Practices

1. **Use meaningful variable names** to make your scripts more readable
2. **Comment your code** using semicolons for complex logic
3. **Be cautious with long-running scripts** due to the save/reload bug
4. **Test subroutines and script calls** thoroughly to ensure proper variable scoping

## Legacy Support

**JSON Format:** There is still support for the original .json format, but .sltscript is preferred. Future development focuses on .sltscript format.

## Technical Notes

- **Tokenization:** Lines split on whitespace except within quotes or brackets
- **Escape sequences:** Embedded double quotes use `""` 
- **Variable resolution:** Functions automatically determine expected data types for parameters
- **Performance:** Built-ins typically run faster than library functions but are less extensible