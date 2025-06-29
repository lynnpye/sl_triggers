# SLTScript

Script for SL Triggers, or SLTScript, is primarily an .ini, text formatted file using a simple marker-to-enclose tokenization strategy. Lines are tokenized by splitting on whitespace, except when fields are enclosed in either double quotes (`"`) or square brackets (`[]`). Enclosed strings may contain whitespace, and embedded double quotes are escaped by doubling them (`""`).

    set $1 "Hello world"
    msg_console  $1

    goto done

    ; stuff

    [done]

## Built-Ins
Scripts contain sequences of commands. A command can be a built-in operation or a function. "Built-ins" are part of the SLTScript language; they can't be overridden through added function libraries, though extensions can alter them. Typically the rule is, however, that if an extension overrides such low-level functionality it should fallback gracefully. The point being these are things like: 

* Simple variable manipulators:
  * `set`
    * Sets the value of the specified variable
      * `set <variable> <value>`
        * parameter 1: `<variable>`
        * parameter 2: `<value>`
        * Example:
          * `set $1 "Hi there"`
      * `set <variable> <value> <operator> <value>`
        * parameter 1: `<variable>`
        * parameter 2: `<value>`
        * parameter 3: `<operator>`
          * `+ - * / &`: addition, subtraction, multiplication, division, string concatenation
        * parameter 4: `<value>`
        * Example:
          * `set $1 "Hi there"`
      * `set <variable> resultfrom <command> <commandarguments...>`
        * parameter 1: `<variable>`
        * parameter 2: `resultfrom` - literally
        * parameter 2: `<command>` - any command with a return value e.g. `actor_name`
        * parameter 4: `<commandarguments...>` - zero or more arguments as needed for the command
        * Example:
          * `set $greeting resultfrom rnd_list "Hi there" "Greetings" "Bonjour" "Howdy"`
  * `inc`
    * Increments the numeric value of the specified variable by the provided amount
    * parameter 1: `<variable>`
    * parameter 2: `<amount>` (optional: default 1)
    * Example:
      * `set $2 12`
      * `inc $2 2`
      * `; $2 is now 14`
  * `cat`
    * Concatenates strings into the variable
    * parameter 1: `<variable>`
    * parameter 2: `<string value>` [`<string value>` `...`]
    * Example:
      * `cat $3 "one " "two " "three "`
      * `cat $4 $1 $2 $3`
* Flow control:
  * `[labels]`, `goto`, and `if`
    * A `[label]` marks a line as a valid target for either `goto` or `if`
  * `goto`
    * Resets execution to begin on the line immediately following the indicated label.
    * Note: This accepts variables.
    * parameter 1: `<label>`
    * Example:
      * Setting a variable with the same name as the label
      * `  ; Also note, we don't have to have seen the label yet to be able to goto it`
      * `set $1 "done"`
      * `  ; To make the point, calling goto to go somewhere in order to skip the following line`
      * `goto below`
      * `  ; Which would undo all of the progress we made on the line where we set the value`
      * `set $1 ""`
      * `  ; Just a label`
      * `[done]`
      * `  ; And apparently if we get here we really are done`
      * `return`
      * `  ; So we go here, but we actually`
      * `[below]`
      * `  ; Start execution on this line, which resolves $1 to 'done'`
      * `  ; Which will send us back up to the first line... turns out we aren't done after all!`
      * `goto $1`
  * `if`
    * Performs a conditional check and, if it evaluates to true, behaves as a goto and
    * redirects execution to the indicated label.
    * parameter 1: `<resolvable value>`
      * literals like 42, "hi there", and 87.3 but also variables like $48
    * parameter 2: `<conditional operation>`
      * one of the supported operations: `=`, `!=`, `>`, `>=`, `<`, `<=`, `&=`, and `&!=`
    * parameter 3: `<resolvable value>`
      * literals like 42, "hi there", and 87.3 but also variables like $48
    * parameter 4: `<label>`
      * the label execution should redirect to if the comparison is true
    * Example
      * `set $2 12`
      * `set $3 12`
      * `if $2 > $3 gogt`
      * `if $2 < $3 golt`
      * `set $4 100  ; has no impact, just other activity going on`
      * `if $2 = $3 goeq`
      * `;...`
      * `[goeq]`
      * `; it ends up here`
  * `return`
    * Exits the current SLTScript. If this SLTScript was called from another, execution will return to the calling script.
    * Example
      * `return`
  * `beginsub <subroutine name>`, `endsub`, `gosub <subroutine name>`
    * Subroutines are blocks of code marked by `beginsub <subroutine name>` and `endsub`
    * If the flow of execution reaches a `beginsub`, it will skip to the `endsub` and keep processing the file
    * This means you can place your subroutines anywhere in your SLTScript
    * When you want to execut your subroutine, use `gosub <subroutine name>`
    * Execution will continue from the first line of the subroutine and return to the first line after `gosub` when `endsub` is encountered
    * You are still inside your script; they are all the same variables
    * Example
      * `beginsub dosomethingcomplex`
      * `  ; imagine some tedious or complex task you coded, that you have to do multiple times, and that`
      * `  ; handling all of the setup and teardown of the loop structure, plus making sure you don't accidentally`
      * `  ; flow into it... but that is now all gone, poof, like a bad dream in the morning sun`
      * `  ; once endsub is encountered, flow will go back to wherever gosub came from`
      * `  ; otherwise it just marks where the script executor will move to when it encounters the beginsub when not being called`
      * `endsub`
      * ` ; cruising along in our script`
      * `gosub dosomethingcomplex`
      * ` ; more cruising`
      * `gosub dosomethingcomplex`
  * `call <SLTScript name> [<arg>...]`, `callarg <argindex> <variable>`
    * `call <SLTScript name> [<arg>...]` is to scripts what `gosub` is for subroutines
    * The requested SLTScript will be spun up with its own heap (i.e. local variables)
    * You can pass parameters to the called script on the same line with your `call`
    * The called script can access these arguments with `callarg <argindex> <variable>`, which places the indexed argument into the variable
    * Example
      * ScriptA.ini
      * `set $1 100`
      * `call ScriptB`
      * `if $1 >= 100 "we've been robbed!"`
      * `; we will end up here, even though ScriptB reduces $1, that is its local $1; we remain unaffected`
      * `msg_notify "All good!"`
      * `return`
      * `[we've been robbed!]`
      * `msg_notify "Get the sheriff!"`
      * ScriptB.ini
      * `; note, we are putting it into our local $1 variable, but that doesn't impact the caller`
      * `callarg 0 $1`
      * `if $1 > 0 robthem`
      * `msg_notify "Too poor!"`
      * `return`
      * `[robthem]`
      * `$1 -= 10`
      * `msg_notify "diabolical!"`
      * `; but actually... it won't affect anything... this $1 is not the same as the ScriptA $1`

## Commands: Just another word for Built-Ins and Functions
Why the distinction? Typically built-ins run faster but of course are less extensible. That's fine and not much of a trade-off in most cases. **Generally, however, you won't need to worry about the distinction between 'built-ins' and 'functions'; you can just refer to them all as 'commands'.** I know that differs from the previous nomenclature, but it is better aligned with how things are actually designed.

Each command and it's parameters must reside on one line, with any amount of separating, trailing, or preceding whitespace.

    ; semi-colon is a comment-to-end-of-line marker

Empty lines are ignored.

Aside from how flow control commands affect things, the script will run each command, in sequence, until it encounters a "return" or the end of the script. This does mean that you can have very long-running scripts. 


## Variables and Scopes
Variables are written using the following syntax:
`$[<optional scope>.]<variable name>`

Where `[<optional scope>.]` by default includes the five basic scopes: `local`, `thread`, `target`, `global`, and the read-only `system`.

Scopes may be added by extensions or as needed by the system.

### Local Scope
Locally scoped variables exist only for the duration of the currently running script. If that script calls another script, all of its locally scoped variables will be unavailable. Once the script returns, all of its locally scoped variables will be lost.

Local scope is the default scope when no scope is specified. So the following are referring to the same variable:
`$variable1`
`$local.variable1`

### Thread Scope
Thread scoped variables exist in the script in which they are created, and in any script that script calls or which is called by such a script, recursively. They cease to exist once the initially executed script returns.

An example would be:
`$thread.variable1`

For example, if ScriptA.ini is triggered, and calls ScriptB.ini, a thread scoped variable could be created in ScriptB.ini and still be available to ScriptA.ini once ScriptB.ini returns. Then if that same instance of ScriptA called ScriptC.ini, that ScriptC would also have access to the same thread scoped variables.

But now suppose a completely different isntance of ScriptA.ini started via the same trigger. Any thread scoped variables from the other copy of ScriptA.ini, and any script it calls, will be unavailable to *this* instance of ScriptA.ini, and likewise for its thread scoped variables.

### Target Scope
Target scoped variables exist on any SLTScript running on the same target/Actor.

An example would be:
`$target.variable1`

If ScriptA.ini creates a target scoped variable, called `$preciousFlag`, then when run on the Player, the value of `$preciousFlag` will correspond to what the script set it to when run on the Player. But if run on Hod, then the value of `$preciousFlag` would be whatever it was set to while running on Hod.

So the same variable can have a different value depending on who it is running on.

### Global Scope
Global scoped variables are shared across all SLTScript instances.

An example would be:
`$global.variable1`

Local variables are currently accessed in the format of `$<number>` where `<number>` may be any variable from `$1` to `$2147483647`. 

Global variables are the same but prefixed with `$g` so `$g<number>` and valid from `$g1` to `$g2147483647`.

### System Scope
System scoped variables are read-only and provided by SLTR itself, plus any extensions.
The current set of system variables is:

* `$system.<variable>`
  * `stats.running_scripts` - count of currently running SLTScripts (will obviously never be less than 1 since you will be running one yourself)
  * `self` - replacement for `$self`; the Actor the script is running on
  * `player` - replacement for `$player`; the Player
  * `actor` - replacement for `$actor`; the selected actor from some functions
  * `none` - none, stand-in for Actor parameters
  * `is_player.inside` - 1 if inside, 0 otherwise
  * `is_player.outside` - 1 if outside, 0 otherwise
  * `is_player.in_city` - 1 if in city, 0 otherwise
  * `is_player.in_dungeon` - 1 if in dungeon, 0 otherwise
  * `is_player.in_safe` - 1 if in safe area, 0 otherwise
  * `is_player.in_wilderness` - 1 if in wilderness, 0 otherwise
  * `is_available.core` - 1 if the SLTCore extension is enabled, 0 otherwise
  * `is_available.sexlab` - 1 if the SLTSexLab extension is enabled, 0 otherwise
  * `partner` | `partner1` - replacement for `$partner`; the first partner of an SL scene
  * `partner2` - replacement for `$partner2`; the second partner of an SL scene
  * `partner3` - replacement for `$partner3`; the third partner of an SL scene
  * `partner4` - replacement for `$partner4`; the fourth partner of an SL scene

### Custom Scopes
There are additional scoped variables provided by SLTR extensions:
* `$core.<variable>`
  * `toh_elapsed` - elapsed time during the last 'Top of the Hour' event (i.e. was an hour elapsed or was more time elapsed due to e.g. sleep)

## All Variables Are Strings
There are some special variables but first let's mention why there need to be special variables.

As with Fotogen's original, all variables are ultimately strings. If you provide a bare integer, rest assured it will be a string before anything touches it. But Papyrus, like many of these kinds of scripting languages, is pretty good about retaining things like decimal precision and properly flipping between string, int, float, and bool as long as you are careful. So for simplicity, everything you do goes into strings. This is also why the final major data type is not so easily supported; `Form`s.

### And That's Okay
Which brings us back to special variables. SLTScript attempts to give access to functionality that mirrors Papyrus script functionality, which includes data type support for `int`, `float`, `string`, `bool`, and `Form` for many of its functions. `string` can easily and consistently coerce between everything but `Form`.

Some functions will return and/or accept a FormID; in most cases this will be sufficient for situations where you want to work with a Form.



# Functions and Function Libraries
All other commands are going to come from Function Libraries and the Functions they define. SL Triggers comes with a library, including a selection oriented toward SexLAb and it's mods. There are more details at the [Function Libraries](../Function-Libraries) wiki page.


















#### Footnote about the term 'SLTScript'
##### Okay, yeah, sure, give me a hard time. Feels garish, to be honest. But really, these are little scripts, I will refer to them as such, but Papyrus is referred to as a "script" language, the .psc files are also "scripts", but then this documentation also has to refer to the Papyrus... script.. side of things. So... SLTScript... SLTScripts... sltscript... sltscripts...

#### Footnote about formats
##### There is still support for the original .json format, and for now it hasn't caused any problems to retain it, but I don't plan to make more scripts for it and if something comes up where I need to choose between a new feature and retaining .json support, I would likely drop .json support. I prefer the .ini format as I think it is cleaner, but have no desire to remove it when retaining it costs me nothing.