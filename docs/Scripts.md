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
    * parameter 1: `<variable>`
    * parameter 2: `<value>`
    * Example:

            set $1 "Hi there"
  * `inc`
    * Increments the numeric value of the specified variable by the provided amount
    * parameter 1: `<variable>`
    * parameter 2: `<amount>` (optional: default 1)
    * Example:

            set $2 12
            inc $2 2
            ; $2 is now 14
  * `cat`
    * Concatenates strings into the variable
    * parameter 1: `<variable>`
    * parameter 2: `<string value>` [`<string value>` `...`]
    * Example:

            cat $3 "one " "two " "three "
            cat $4 $1 $2 $3
* Flow control:
  * `[labels]`, `goto`, and `if`
    * A `[label]` marks a line as a valid target for either `goto` or `if`
  * `goto`
    * Resets execution to begin on the line immediately following the indicated label.
    * Note: This accepts variables.
    * parameter 1: `<label>`
    * Example:

            ; Setting a variable with the same name as the label
            ; Also note, we don't have to have seen the label yet to be able to goto it
            set $1 "done"
            ; To make the point, calling goto to go somewhere in order to skip the following line
            goto below
            ; Which would undo all of the progress we made on the line where we set the value
            set $1 ""
            ; Just a label
            [done]
            ; And apparently if we get here we really are done
            return
            ; So we go here, but we actually
            [below]
            ; Start execution on this line, which resolves $1 to 'done'
            ; Which will send us back up to the first line... turns out we aren't done after all!
            goto $1
  * `if`
    * Performs a conditional check and, if it evaluates to true, behaves as a goto and
    * redirects execution to the indicated label.
    * parameter 1: `<resolvable value>`
      * literals like 42, "hi there", and 87.3 but also variables like $48
    * parameter 2: `<conditional operation>`
      * one of the supported operations: `=`, `!=`, `>`, `>=`, `<`, `<=`, `&=`, and `&!=`
        * `=`, `!=`, `>`, `>=`, `<`, `<=`
          * numeric equality, inequality, greater than, greater than or equal to, less than, and less than or equal to operators, respectively
        * `&=`, `&!=`
          * string equality, and inequality, respectively
        * the reason for the separate string comparators is because, again, everything is a string under the hood
          * `set $1 4.0` will become "4.0"
          * `set $2 4.00` will become "4.00"
          * `$1 = $2` will be true because `$1` and `$2` would be coerced to a number first, and `4.0 == 4.00`
          * `$1 &= $2` will be false because `"4.0" != "4.00"`
    * parameter 3: `<resolvable value>`
      * literals like 42, "hi there", and 87.3 but also variables like $48
    * parameter 4: `<label>`
      * the label execution should redirect to if the comparison is true
    * Example

            set $2 12
            set $3 12
            if $2 > $3 gogt
            if $2 < $3 golt
            set $4 100  ; has no impact, just other activity going on
            if $2 = $3 goeq
            ;...
            [goeq]
            ; it ends up here
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

            beginsub dosomethingcomplex
                ; imagine some tedious or complex task you coded, that you have to do multiple times, and that
                ; handling all of the setup and teardown of the loop structure, plus making sure you don't accidentally
                ; flow into it... but that is now all gone, poof, like a bad dream in the morning sun
                ; once endsub is encountered, flow will go back to wherever gosub came from
                ; otherwise it just marks where the script executor will move to when it encounters the beginsub when not being called
            endsub
            ; cruising along in our script
            gosub dosomethingcomplex
            ; more cruising
            gosub dosomethingcomplex
  * `call <SLTScript name> [<arg>...]`, `callarg <argindex> <variable>`
    * `call <SLTScript name> [<arg>...]` is to scripts what `gosub` is for subroutines
    * The requested SLTScript will be spun up with its own heap (i.e. local variables)
    * You can pass parameters to the called script on the same line with your `call`
    * The called script can access these arguments with `callarg <argindex> <variable>`, which places the indexed argument into the variable
    * Example

            ;ScriptA.ini
            set $1 100
            call ScriptB
            if $1 >= 100 "we've been robbed!"
            ; we will end up here, even though ScriptB reduces $1, that is its local $1; we remain unaffected
            msg_notify "All good!"
            return
            [we've been robbed!]
            msg_notify "Get the sheriff!"

            ;ScriptB.ini
            ; note, we are putting it into our local $1 variable, but that doesn't impact the caller
            callarg 0 $1
            if $1 > 0 robthem
            msg_notify "Too poor!"
            return
            [robthem]
            $1 -= 10
            msg_notify "diabolical!"
            ; but actually... it won't affect anything... this $1 is not the same as the ScriptA $1

## Commands: Just another word for Built-Ins and Functions
Why the distinction? Typically built-ins run faster but of course are less extensible. That's fine and not much of a trade-off in most cases. **Generally, however, you won't need to worry about the distinction between 'built-ins' and 'functions'; you can just refer to them all as 'commands'.** I know that differs from the previous nomenclature, but it is better aligned with how things are actually designed.

Each command and it's parameters must reside on one line, with any amount of separating, trailing, or preceding whitespace.

    ; semi-colon is a comment-to-end-of-line marker

Empty lines are ignored.

Aside from how flow control commands affect things, the script will run each command, in sequence, until it encounters a "return" or the end of the script. This does mean that you can have very long-running scripts. **Bear in mind that presently there is a long-standing bug wherein you are not guaranteed consistent behavior if you save and reload while an SLTScript is running. ActiveMagicEffects behave very specifically in this scenario. I am looking into a fix.**


## Variables
### Note: This section is due for potential change/rearchitecture soon.

Currently, you can access local (to the currently executing SLTScript) and global (to all scripts, persistent across saves, permanent for your character until you unset it) variables.

Local variables are accessed in the format of `$<any-non-breaking-characters>` effectively allowing you to create variable names like `$var1`, `$23rdvariable`, `$_#^_23x` (yes, for real on that last one). 

Global variables are the same but prefixed with `!` so `!<any-non-breaking-characters>` (i.e. so yeah, `!()^&3x7` is also a valid global variable name).

### All Variables Are Strings
There are some special variables but first let's mention why there need to be special variables.

As with Fotogen's original, all variables are ultimately strings. If you provide a bare integer, rest assured it will be a string before anything touches it. But Papyrus, like many of these kinds of scripting languages, is pretty good about retaining things like decimal precision and properly flipping between string, int, float, and bool as long as you are careful. So for simplicity, everything you do goes into strings. This is also why the final major data type is not so easily supported; `Form`s.

### And That's Okay
Which brings us back to special variables. SLTScript attempts to give access to functionality that mirrors Papyrus script functionality, which includes data type support for `int`, `float`, `string`, `bool`, and `Form` for many of its functions. `string` can easily and consistently coerce between everything but `Form`.

### Except...
But some commands will return a `Form`, often an `Actor`. To access these, and only with commands that are contextually aware of expecting `Form` type variables, you can reference them via their special names:

* `$self` - the `Actor` the script is attached to/targeting
* `$player` - the Player, in all cases, regardless of whom the script is attached to/targeting
* `$actor` - some special functions return an `Actor` type, but since `$$` is string only, you must reference the returned value as `$actor`
* `$partner` - the first partner in a SexLab scene that is not `$self`
* `$partner2` - the second partner in a SexLab scene that is not `$self`
* `$partner3` - the third partner in a SexLab scene that is not `$self`
* `$partner4` - the fourth partner in a SexLab scene that is not `$self`

### Confusion that Still Needs to be Sorted Out
So now that I can create my own variable `$self`, how does that impact use of `$self` in existing scripts?

Each function "knows" what to do with a given parameter and remember, everything starts life as a string. So when `$self` arrives at a function, if it is in a position that an `Actor` is expected, it is going to look for the special variable `$self` (or `$player`, etc.) and will not know anything about any variable you create called `$self`. For example:

    set $self "Health"
    av_restore $self $self 100

Would heal the "Health" (resolved from the variable `$self` that you set, because it is in the 2nd parameter position) of the actor `$self` (the magic `Actor` keyword used because it is in the 1st parameter position) for 100.

The upshot? I would strongly... very very strongly... advise against making use of the ability to reuse those special variable names. In the future I will try to phase out the special variables (perhaps make specials get a completely different prefix... I think I know my next update) but that would still require a lot of script rewrites.



# Functions and Function Libraries
All other commands are going to come from Function Libraries and the Functions they define. SL Triggers comes with a library, including a selection oriented toward SexLAb and it's mods. There are more details at the [Function Libraries](../Function-Libraries) wiki page.


















#### Footnote about the term 'SLTScript'
##### Okay, yeah, sure, give me a hard time. Feels garish, to be honest. But really, these are little scripts, I will refer to them as such, but Papyrus is referred to as a "script" language, the .psc files are also "scripts", but then this documentation also has to refer to the Papyrus... script.. side of things. So... SLTScript... SLTScripts... sltscript... sltscripts...

#### Footnote about formats
##### There is still support for the original .json format, and form now it hasn't caused any problems to retain it, but I don't plan to make more scripts for it and if something comes up where I need to choose between a new feature and retaining .json support, I would likely drop .json support. I prefer the .ini format as I think it is cleaner, but have no desire to remove it when retaining it costs me nothing.