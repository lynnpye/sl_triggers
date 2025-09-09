# SLTScript Documentation

## Overview

Script for SL Triggers, or SLTScript, is primarily a text file using a simple marker-to-enclose tokenization strategy. Lines are tokenized by splitting on whitespace, except when fields are enclosed in either double-quotes (`""`), dollar-double-quotes for string interpolation (`$""`) or square brackets (`[]`). Enclosed strings may contain whitespace, and embedded double quotes are escaped by doubling them (`""`).

The legacy option of .JSON is no longer supported.

In cases where a bare word is detected and not determined to be a function or variable name, it will be interpreted as a string literal (`""`).

```sltscript
; $msg is a valid variable name, and this is an example of a comment
set $msg "Hello world"
; this prints a message to the console
msg_console $msg
; this jumps to the [done] label
goto [done]

; this code would not be run

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

**Generally, you won't need to worry about the distinction between 'intrinsics' and 'functions'; you can just refer to them all as 'commands', but 'intrinsics' tend to be faster than 'functions'.**

### Script Execution
Scripts run each command in sequence until they encounter a `return` or reach the end of the script. This allows for very long-running scripts.

## Data Types
Data types are preserved and coerced, with `string` as a default fallback. Forms will be "coerced" to their FormID.

**All variables are ultimately strings.** SLTScript automatically handles conversion between types as needed.

For purposes of SLTScript, you have the following data types available:
|Data Type|Description|
|---|---|
|`string`|Sequence of characters, delimited by double quotes, e.g. `"Hello, world!"`.|
|`label`|Sequence of characters, delimited by square brackets, used for `goto`/`if` targets, e.g. `[label target]`. This form allows spaces in the label.|
|`int`|32-bit integer numeric value. Can be expressed in hexadecimal form by using a `0x` prefix. e.g. `-12`, `0`, `100`, `0x23`|
|`float`|floating point (float) numeric value. e.g. `-12.23`, `0.44`, `100.48`|
|`bool`|boolean value, expressed either `true` or `false`|
|`Form`|Form values|
|`Alias`|Alias values|
|`map`|A set of key-value pairs associated with the variable name. See the `Maps` section below. Reference values by using map key notation e.g. `$var{$mapkey}` where `$mapkey` contains the value of the key; literals may be used e.g. `$var{literalvalue}` will look for a value with the key `"literalvalue"`|
|`list`|An ordered set of values, sharing a common type. Once a list's type is determined, future assignments will coerce to that type rather than changing the type of the target variable.|

### Maps
A variable becomes a map when you assign to it using a map key. Map keys are specified using map key notation.

```sltscript
set $keyvalue "somekey"
set $mapvariable{$keyvalue} 23
set $intvalue $mapvariable{$keyvalue}
```

If you do not use a variable for the map key, it will assume the specified map key is a string literal.

```sltscript
; this is identical to the previous example
set $mapvariable{somekey} 23
set $intvalue $mapvariable{somekey}
```

The data type of the assigned value will be retained for coercion later as needed. This means you can do this reliably.

```sltscript
set $mapvariable{test} = true
if $mapvariable{test}
    ; this will run so long as $mapvariable{test} is 'truthy'
endif
```

### Lists
A variable becomes a list when you assign to it using a list index. List indices are ALWAYS resolved as an int. This means if you try to use a variable that is not an int, the variable will be coerced to an int, which in some cases could cause it to always resolve to 0 (i.e. when attempting to use a string as the list index when the string is not a stringified int).

```sltscript
; an instance of a list with a list index
$listvar[0] = 12
```

Unlike maps, which can contain multiple data types, a list contains only a single type. So a list isn't just a list, it is a string list, or an int list, or a Form list, or a label list.

If a variable has never been assigned to, or is not currently a list, the first indexed assignment establishes the list's type.

```sltscript
$listvar[0] = 12
; listvar is now an "int list", containing integers; future assignments will try to coerce data to "int"
$listvar[1] = "23"
; $listvar[1] is 23, because "23" (string) coerces to 23 (int)
$listvar[2] = "thirty-four"
; $listvar[2] is 0, because "thirty-four" (string) coerces to 0 (int) because it isn't an actual number
```

#### List Type Declaration
You can declare a variable to be a specific list type (that is, force it to be treated like that type). This is most useful when initializing a list in order to force the stored data type. The syntax is in the form of `<type> <varname>`. For example:

```sltscript
int[] $listvar
; $listvar will be treated like an list of integers
set $listvar[0] "one"
; $listvar[0] is 0 (int) because "one" (string) coerces to 0 (int) because it is not actually numeric
```

This does not change data. If you have a list of strings containing the value "apple" and cast it to "int[]" (list of integers) and attempt to retrieve the "apple" element, it will return 0 because as an int, "apple" cannot be coerced and defaults to 0.

Note also that if you are careful with the first assignment to a list, this pre-declaration is not required.

Available list types and their declarations:
|Declaration|List Type|
|---|---|
|`string[]`|list of strings e.g. "Nord", "Breton", "Argonian"|
|`bool[]`|list of bool values e.g. true, false|
|`int[]`|list of int values e.g. 23, 34, 45, 0x23, -14|
|`float[]`|list of float values e.g. 1.23, 4.0234, -32|
|`Form[]`|list of Form values e.g. $system.partner, $system.partner2, $system.player|
|`Alias[]`|list of Alias values|
|`label[]`|list of labels e.g. [here], [there], [somewhere]|

### FormID, Forms, and You
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
   - **&lt;modfile&gt;:&lt;relative formid&gt;** this is a commonly used format e.g. "skyrim.esm:0xf" or "skyrim.esm:15" for a septim (modfile: "skyrim.esm", formid: 0xf or 15)
   - **&lt;relative formid&gt;|&lt;modfile&gt;** another commonly used format e.g. "0xf|skyrim.esm" or "15|skyrim.esm"
     - **&lt;relative formid&gt;** keep in mind the difference between an ESL flagged vs a non-ESL flagged mod; the ESL flagged mod has *only* (it's still a lot) 0xFFF room to work with, whereas other mods have the full 0xFFFFFF
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
   - **&lt;absolute formid&gt;** not so common but useful for local tinkering; note that absolute formids will change if your load order changes
     - **accepts decimal or hexadecimal** formid values can be specified as either decimal or hexadecimal; hexadecimal requires a leading `0x`

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

- **Local variables**: `$variableName` | `$local.variableName` - Available only to the currently executing script
- **Thread variables**: `$thread.variableName` - Available to any script on the current thread/callchain
- **Target variables**: `$target.variableName` - Available to any script running on the target
  - **Target scope extension**: `$target<otherActor>.variableName` - Allows access to another target's variables (i.e. not `$system.self`)
- **Global variables**: `$global.variableName` - Available to all scripts, persistent across saves

Variable names can include any of the following characters after the scope: `A-Za-z0-9._`.

Note: You can have whitespacen inside a variable statement only if it is inside the target sub-scope, list index, or map key.
For example:
```sltscript
; these are valid
$target<$otherActor>.varname
$target< $otherActor >.varname
$map{42}
$map{ 42 }
$list[0]
$list[ 0 ]

; but these are not
$target <$otherActor>.varname
$target<$otherActor> .varname
$map {42}
$list [0]
```

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
|`$system.forms.sltr_main`|Form - returns the SLTR Main Quest object (i.e. "0x83f|sl_triggers.esp")|
|`$system.is_available.core`|bool - (Added by SLTR Core) is the SLTR Core extension available and enabled (very rare you would want this false)|
|`$system.toh_elapsed`|float - (Added by SLTR Core) actual elapsed time in hours since the previous top of the hour (may be larger than 1.0 if e.g. sleeping or traveling)|
|`$system.player.is_swimming`|bool - (Added by SLTR Core) true if player is swimming; false otherwise|
|`$system.player.is_in_water`|bool - (Added by SLTR Core) true if player is in water; false otherwise|
|`$system.player.submerged_level`|float - (Added by SLTR Core) current submerged level of player; 0.0 if not submerged/on dry land, 1.0 if fully submerged|
|`$system.player.swimming_start_gametime`|float - (Added by SLTR Core) gametime when player started current swim session; resets to 0.0 when not swimming|
|`$system.player.in_water_start_gametime`|float - (Added by SLTR Core) gametime when player started current in water session; resets to 0.0 when player leaves water|
|`$system.player.swimming_session`|int - (Added by SLTR Core) unique int ID to identify a period of unbroken time player spent swimming; 0 if not swimming|
|`$system.player.in_water_session`|int - (Added by SLTR Core) unique int ID to identify a period of unbroken time player spent in water; 0 if not in water|
|`$system.player.swimming_duration`|float - (Added by SLTR Core) gametime duration player has currently spent swimming; 0.0 if not currently swimming|
|`$system.player.in_water_duration`|float - (Added by SLTR Core) gametime duration player has currently spent in water; 0.0 if not currently in water|
|`$system.player.swimming_last_start_gametime`|float - (Added by SLTR Core) gametime when player started previous swim session|
|`$system.player.in_water_last_start_gametime`|float - (Added by SLTR Core) gametime when player started previous in water session|
|`$system.player.swimming_last_duration`|float - (Added by SLTR Core) gametime duration player was last swimming; might be very small for repeated re-entries of deep water|
|`$system.player.in_water_last_duration`|float - (Added by SLTR Core) gametime duration player was last in water; might be very small for repeated re-entries of shallow water|
|`$system.is_available.sexlab`|bool - (Added by SLTR SexLab) is the SLTR SexLab extension available and enabled (would be false if you installed on a system without SexLab)|
|`$system.partner`|Actor - (Added by SLTR SexLab) the first member of the target Actor's current SexLab scene that is not the target Actor|
|`$system.partner1`|Actor - (Added by SLTR SexLab) the first member of the target Actor's current SexLab scene that is not the target Actor|
|`$system.partner2`|Actor - (Added by SLTR SexLab) the second member of the target Actor's current SexLab scene that is not the target Actor|
|`$system.partner3`|Actor - (Added by SLTR SexLab) the third member of the target Actor's current SexLab scene that is not the target Actor|
|`$system.partner4`|Actor - (Added by SLTR SexLab) the fourth member of the target Actor's current SexLab scene that is not the target Actor|
|`$system.is_available.ostim`|bool - (Added by SLTR OStim) is the SLTR OStim extension available and enabled (would be false if you installed on a system without OStim)|
|`$system.ostim.partner`|Actor - (Added by SLTR OStim) the first member of the target Actor's current OStim scene that is not the target Actor|
|`$system.ostim.partner1`|Actor - (Added by SLTR OStim) the first member of the target Actor's current OStim scene that is not the target Actor|
|`$system.ostim.partner2`|Actor - (Added by SLTR OStim) the second member of the target Actor's current OStim scene that is not the target Actor|
|`$system.ostim.partner3`|Actor - (Added by SLTR OStim) the third member of the target Actor's current OStim scene that is not the target Actor|
|`$system.ostim.partner4`|Actor - (Added by SLTR OStim) the fourth member of the target Actor's current OStim scene that is not the target Actor|

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
|`$request.core.harvesting.harvested_item`|Form - (Added by SLTR Core) (for Harvesting) the Form item that was harvested e.g. 'Snowberries'|
|`$request.core.vampirism.was_contracted`|bool - (Added by SLTR Core) (for Vampirism Transitions) did you just contract it (i.e. disease progressed to Vampirism)|
|`$request.core.vampirism.was_cured`|bool - (Added by SLTR Core) (for Vampirism Transitions) were you cured?|
|`$request.core.vampirism.started_vampire_lord`|bool - (Added by SLTR Core) (for Vampirism Transitions) did you transform to Vampire Lord?|
|`$request.core.vampirism.ended_vampire_lord`|bool - (Added by SLTR Core) (for Vampirism Transitions) did you end the Vampire Lord transformation?|
|`$request.core.lycanthropy.was_contracted`|bool - (Added by SLTR Core) (for Lycanthropy Transitions) did you just contract it (e.g. Companions ceremony)|
|`$request.core.lycanthropy.was_cured`|bool - (Added by SLTR Core) (for Lycanthropy Transitions) were you cured?|
|`$request.core.lycanthropy.started_werewolf`|bool - (Added by SLTR Core) (for Lycanthropy Transitions) did you transform to Werewolf?|
|`$request.core.lycanthropy.ended_werewolf`|bool - (Added by SLTR Core) (for Lycanthropy Transitions) did you end the Werewolf transformation?|
|`$request.core.vampire_feeding.target`|Form - (Added by SLTR Core) (for Vampire Feeding) the target of the feeding|
|`$request.core.soul_trapped.trapper`|Form - (Added by SLTR Core) (for Soul Trapped) the trapper who trapped the target|
|`$request.core.soul_trapped.target`|Form - (Added by SLTR Core) (for Soul Trapped) the target that was trapped|

## Basic Operations

### Variable Assignment and Manipulation

#### `$"{$variable}"` - Variable interpolation
You can use the `$"{$variablename}"` construct to perform string interpolation. This will create a string literal with the specified variables injected into place. Scopes are respected, so you can also have references to e.g. `global` scoped variables.
```sltscript
set $global.monkey.count 21
set $var $"{$global.monkey.count} Monkeys"
; $var now contains '21 Monkeys'
```

#### `set` - Basic Assignment
Sets the value of the specified variable.
```sltscript
set $1 "Hi there"
msg_console $1

set $playerName "John"
msg_console $playerName
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

#### `mapunset` - Unset a map key for a map
Removes the key-value pair identified by the `map-key` argument.
```sltscript
set $mapvar{key} = "value"
mapunset $mapvar "key"
; $mapvar{key} no longer has a value
```

#### `maphaskey` - Unset a map key for a map
Returns true if a key-value pair identified by the `map-key` argument exists for this map.
```sltscript
set $mapvar{foo} = "value"
maphaskey $mapvar "foo"
; $$ is true
maphaskey $mapvar "bar"
; $$ is false
```

#### `mapcopy` - Unset a map key for a map
Copies all key-value pairs associated with the source map to the target map.
```sltscript
set $mapvar{key} = "value"
mapcopy $global.mapvar $mapvar
mapunset $mapvar "key"
; $mapvar{key} no longer has a value
; $global.mapvar{key} still has value "value"
```

#### `mapclear` - Unset a map key for a map
Removes all key-value pairs associated with the map variable.
```sltscript
set $mapvar{key1} = "value1"
set $mapvar{key2} = "value2
mapclear $mapvar
; $mapvar{key1} and $mapvar{key2} no longer have a value
```

#### `mapkeys` - Returns: string[]: a list of the keys in the map
Returns a list of strings corresponding to the available keys in the map.
```sltscript
set $mapvar{fork} = "pointy"
set $mapvar{knife} = "cutty"
set $mapvar{spoon} = "scoopy"
set $keylist resultfrom mapkeys $mapvar
; $keylist now contains a list, ["fork", "knife", "spoon"]
```

#### `listcount` - Returns: int: the size of the indicated list
Returns a count (the size) of the number of elements in the list.
```sltscript
set $listvar[0] = "first"
set $listvar[9] = "last"
set $count resultfrom listcount $listvar
; $count is 10, because by assigning to index 9, it resizes the 0-based list to accommodate
```

#### `listadd` - Adds the value(s) to the list, increasing the size
Adds the provided value(s) to the list, coercing it to the list's type as needed. `listadd` accepts more than 1 argument.
```sltscript
set $listvar[0] = "first"
; the list is a string list, because it's first indexed assignment is a string
listadd $listvar 27
; $listvar[1] is now "27", a string

set $intlist[0] = 100
; the list is an int list, because it's first indexed assignment is an int
listadd $intlist "two hundred"
; $intlist[1] is now 0, because "two hundred" as a string, cast to an int, returns 0
listclear
listadd $intlist 0 100 200 300 400
; $intlist[0-4] contain, respectively,the values indicated, i.e. the equivalent of $intlist[$i] = $i * 100
```

#### `listclear` - Removes all values from the list and sets its count/size to 0
Removes all values from the list and sets its count/size to 0.
```sltscript
set $listvar[0] = "first"
set $listvar[1] = "second"
listclear $listvar
; $listvar[0] and $listvar[1] are no longer set and listcount will return 0
```

#### `listresize` - Sets the list's size to the new value
Sets the new size of the targeted list.
```sltscript
set $listvar[0] = "first"
set $listvar[1] = "second
listresize $listvar 1
; $listvar[1] is no longer set because the list was resized to hold only 1 element
; $listvar[0] remains unchanged
```

#### `listslice` - Returns the requested slice of the list, if available, retaining the type
Copies a slice of data from a list, specified by a required slice length and an optional start index, which defaults to 0.
```sltscript
set $listvar[0] = "first"
set $listvar[1] = "second"
set $listvar[2] = "third"
set $listvar[3] = "fourth"

set $stringslice resultfrom listslice $listvar 2 1
; $stringslice is a list comprised of [ "second", "third" ]
```

#### `listjoin` - Appends to targetList the data from each sourceList, provided the data types match
The usage: listjoin $targetList $sourceList1 $sourceList2 ...

targetList: required

sourceList: 1 or more, must be list variables of the same type as the targetList
```sltscript
Form[] $theCrew
set $theCrew[0] = $system.player
set $theFollowers resultfrom nff_followers
listjoin $theCrew $theFollowers
; $theCrew contains the player and all NFF followers
```

#### `inc` - Increment
Increments the numeric value of a variable by the specified amount (default: 1; float values like 2.3 are allowed).
```sltscript
set $2 12
inc $2 2
; $2 is now 14

inc $3    ; increments $3 by 1; since it was not set, it will be initialized to 0 and incremented by 1
```

#### `cat` - String Concatenation
Concatenates strings into the target variable.
```sltscript
cat $3 "one " "two " "three "
; $3 is now "one two three "
cat $4 $1 $2 $3
; $4 would have the contents of $1, $2, and $3, concatenated with no adjoining spaces
```

#### `typeid` - Returns: int: the Type ID of the variable
The type ID of a variable is an int value representing the underlying type when the variable was last assigned.
Attempting to get the type ID of something that is not a variable, basically literals, will return 0.
If a variable has not been set yet, it will return 0.
This can be used to determine if a value has ever been set before, including globals.
Because system variables are more akin to macros rather than actual variables, they also have no type ID. But you can
obtain it by setting a variable to the value of the system variable.

Possible values:
- 0 - Invalid
- 1 - string
- 2 - bool
- 3 - int
- 4 - float
- 5 - Form (or Form sub-type e.g. ObjectReference, Actor)
- 6 - Label - a goto target e.g. [label]
- 7 - Map
- 8 - Alias (or ReferenceAlias)
- 101 - string[] (i.e. string list)
- 102 - bool[]
- 103 - int[]
- 104 - float[]
- 105 - Form[]
- 106 - Label[]
- ; there is no list of maps
- 108 - Alias[]
```sltscript
typeid $var
; $$ is 0
set $var "true"
typeid $var
; $$ is 1, because "true" is a string
set $var true
typeid $var
; $$ is 2, because the bare keyword true is a boolean
set $var 42
typeid $var
; $$ is 3
set $var 42.0
typeid $var
; $$ is 4
; $$ is 0 for all of the following literals
typeid "Hello, world!"
typeid 42
typeid true
typeid false
typeid 42.0
```

#### `typename` - Returns: string: the type name of the variable
Returns the name associated with the id from `typeid`.

Possible values:
- "string"
- "int"
- "float"
- "bool"
- "Form"
- "Label"
- "Map"
- "Alias"
- "string[]"
- "bool[]"
- "int[]"
- "float[]"
- "Form[]"
- "Label[]"
- "Alias[]"

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

All commands beyond the intrinsics come from Function Libraries. SLTR includes an expanding library with functions covering not only base Skyrim but also SexLab, OStim, and other related mods.

For detailed information about available functions, see the [Function Libraries](../Function-Libraries) wiki page.

## Best Practices

1. **Use meaningful variable names** to make your scripts more readable
2. **Comment your code** using semicolons for complex logic
3. **Be cautious with long-running scripts** due to the save/reload bug
4. **Test subroutines and script calls** thoroughly to ensure proper variable scoping

## Legacy Support

**JSON Format:** JSON support has ended. Future development focuses on .sltscript format.

## Technical Notes

- **Tokenization:** Lines split on whitespace except within quotes or brackets
- **Escape sequences:** Embedded double quotes use `""` 
- **Variable resolution:** Functions automatically determine expected data types for parameters
- **Performance:** Built-ins typically run faster than library functions but are less extensible