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
|`$system.stats.running_scripts`|int - current count of running scripts; will always be 1 or greater because you will be calling it from a script|
|`$system.realtime`|float - the current real time (i.e. seconds since launch of SkyrimSE.exe) from Game.GetCurrentRealtime()|
|`$system.gametime`|float - the current game time (i.e. in-game days since your save was created) from Game.GetCurrentGametime()|
|`$system.initialGameTime`|float - the game time when the script was started|
|`$system.initialScriptName`|string - the initial script that was requested; might differ from current script in case `call` was used|
|`$system.currentScriptName`|string - the current script that is running; might differ from current script in case `call` was used|
|`$system.sessionid`|int - the current SLTR sessionid (changes with each load of a save or creation of a new game)|
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

#### Core
`core` scoped variables are provided by the Core extension
|Variable|Returns|
|---|---|
|`$core.toh_elapsed`|float - actual elapsed time in hours since the previous top of the hour (may be larger than 1.0 if e.g. sleeping or traveling)|

### Data Types
Data types are preserved and coerced, with `string` as a default fallback. Forms will be "coerced" to their FormID.

**All variables are ultimately strings.** SLTScript automatically handles conversion between string, int, float, and bool types as needed. While Papyrus supports `Form` types, these require special handling in SLTScript.

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

**Syntax:** `if <value1> <operator> <value2> <label>`

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