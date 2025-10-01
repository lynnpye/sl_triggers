## The Concept

Function libraries serve as a way to expand on the available functions in your SLT scripts.

For example, a typical script might look like this:

    item_add $system.self "skyrim.esm:15" 10 0
    goto there

    [here]
    item_add $system.self "skyrim.esm:15" 7 0
    goto finally

    [there]
    item_add $system.self "skyrim.esm:15" 11 0

    goto here

    [finally]

Strictly speaking, `item_add` is the only true "function" in this script, `goto` being a language construct. `item_add` is implemented in `sl_triggersCmdLibSLT.psc`. Suppose in your mod you want to do something which offers a Papyrus API call that will upgrade equipment somehow. Suppose you would like to have a script function, say `yourmod_item_upgrade` that calls that function. Without command libraries you would need to wait for the SLTR maintainer to add the feature and, assuming they do, hope they did it the way you wanted.

Function libraries offer a method of adding to the available functions without needing to get an update from SLTR itself.

## The Pieces
There are two pieces to a function library: the .psc/.pex script, and the `-libraries.json` file.

### The `-libraries.json` file
First, let's have a look at the `-libraries.json` file. Here is a sample:

    {
        "DemoSLTLibraryScript" : 10000
    }

Pretty simple, huh? You can have more than one row. This would be valid, too:

    {
        "DemoSLTLibraryScript" : 10000,
        "AnotherDemoScript" : 9000
    }

What this does it tells SLT that these two scripts exist, have the indicated priorities, and contain function implementations to make available in SLT scripts.

Priorities are signed integers. The baseline SLT functions are at priority 0, available to be overridden.

IMPORTANT: Libraries are checked in priority order, from low to high. If a library has a function definition for `foo_function` at priority `-100` it will be run instead of a library with its own definition for `foo_function` but at priority `200` (because `-100 < 200`).

### The script
When SLTR encounters a function in an SLTScript, it will iterate, in priority sequence, all of the command libraries to look for the function; the first implementing library wins. This allows you to set up different libraries as overrides for other functions and why SLTR itself is set at 0.

Here is the bare minimum for an SLTR function:

    Function do_the_bare_minimum_with_hextun(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
        sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
        Debug.Notification("Hello from a function doing the bare minimum.")
        CmdPrimary.CompleteOperationOnActor()
    EndFunction

For SLTR to be able to make use of your function, it must adhere to the following requirements:
- global
- no return type
- requires the signature (Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param)
  - `Actor CmdTargetActor` - the Actor the script was run on; usually this is the Actor the script
            is also affecting but that isn't necessary; however all scripts run on an Actor mechanically
  - `ActiveMagicEffect _CmdPrimary` - This is actually an sl_triggersCmd, which extends ActiveMagicEffect; you
            can see the cast on the first line of the function; this is what runs the script
            and maintains context for execution.
  - `string[] param` - the parameters used for the operation in the script, including the function name;
            so if your script had the line 'av_mod $system.self Health 15', param would have
            length 4, and the values would be:
    - 0   av_mod
    - 1   $system.self
    - 2   Health
    - 3   15
  - It must cast `_CmdPrimary` to `sl_triggersCmd` and call `sl_triggersCmd.CompleteOperationOnActor()` before returning

Here is a longer example from the same demo file, including comments in-line:

            ;/
                The base SLTR implementation does not support a command named "do_slt_demo_library_script_stuff",
                so let's rectify that. Let's have it accept an Actor as the first parameter and it will
                print the Actor's display name to console. Finally it is going to "return" the actor's name
                for later functions in the script to make use of (if they choose to).

                So in param we would expect something like:
                    0   do_slt_demo_library_script_stuff    ; I can't believe I made myself type that again
                    1   $system.player                      ; note that this could also be values like $system.self, and $system.actor
                $system.player is a special variable that always resolves to the Player. In this case, even
                if CmdTargetActor were pointing to Ancano, $system.player would still resolve to the player.
            /;
            Function do_slt_demo_library_script_stuff(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
                ; although not always immediately necessary, since the last thing you must do is call CmdPrimary.CompleteOperationOnActor()
                ; before returning, you will always need to cast this as sl_triggersCmd
                sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

                ; first we need to resolve the parameter to an Actor.
                ; sl_triggersCmd.ResolveActor() will attempt to find the Actor based
                ; on the value provided.
                Actor _theActor = CmdPrimary.ResolveActor(param[1])

                ; see: https://ck.uesp.net/wiki/ObjectReference_Script for `string GetDisplayName()`
                ; Actor derives from ObjectReference and thus has GetDisplayname()
                ; get the display name for later. 
                string _theDisplayName = _theActor.GetDisplayName() 

                ; we want to print it to the console. Since PapyrusUtil is a requirement
                ; we have access to MiscUtil.PrintConsole()
                MiscUtil.PrintConsole("Demoing SLTR: Targeted Actor with DisplayName(" + _theDisplayName + ")")

                ; and finally we want to "return" the name so the rest of the script has access to it
                ; to "return" it we have to provide it back to CmdPrimary so it can place it in the 
                ; correct context (i.e. `$$`). CmdPrimary.MostRecentStringResult is how a function "returns"
                ; a string value.
                CmdPrimary.MostRecentStringResult = _theDisplayName

                ; Do not set any of the MostRecent*Result properties before calling `CompleteOperationOnActor` unless your function
                ; is intended to return a result.

                ; This is absolutely required at the end of any function you create. If you do not do this, the calling script controller
                ; will remain in a loop waiting indefinitely for your function to return, causing your script to hang indefinitely or
                ; until you use `SLTR Reset`, and most likely harming performance generally, particularly if multiple copies continue to launch
                ; and hang.
                CmdPrimary.CompleteOperationOnActor()
            EndFunction

Compile this, place it in scripts, and place your `-libraries.json` file and you can start using your new functions in your SLTScripts. Distribute your .pex and `-libraries.json` to let others marvel at your brilliance. :)

To resolve a parameter to a particular type, use the `Resolve*` functions; for derived types from the available base types, you would then need to perform any necessary casts.

|parameter type|`Resolve*` function to use|
|---|---|
|`string`|`ResolveString`|
|`bool`|`ResolveBool`|
|`int`|`ResolveInt`|
|`float`|`ResolveFloat`|
|`Form`|`ResolveForm`|
|`Alias`|`ResolveAlias`|
|`[Label]` (returns a `string`)|`ResolveLabel`|
|`string[]`|`ResolveListString`|
|`bool[]`|`ResolveListBool`|
|`int[]`|`ResolveListInt`|
|`float[]`|`ResolveListFloat`|
|`Form[]`|`ResolveListForm`|
|`[Label][]` (returns a `string`)|`ResolveListLabel`|
|`Alias[]`|`ResolveListAlias`|
|These are convenience wrappers|
|`ObjectReference`|`ResolveObjRef`|
|`Actor`|`ResolveActor`|
|`FormList`|`ResolveFormList`|
|`Actor[]`|`ResolveListActor`|


For each return type, you can use the following `MostRecent*Result` property in your function to signal the value and its type. It is not recommended to set multiple of these, since the last `MostRecent*Result` property set "wins", effectively ignoring any previously set values.

|return type|`MostRecent*Result` property to use|
|---|---|
|`string`|`MostRecentStringResult`|
|`bool`|`MostRecentBoolResult`|
|`int`|`MostRecentIntResult`|
|`float`|`MostRecentFloatResult`|
|`Form`|`MostRecentFormResult`|
|`[Label]`|`MostRecentLabelResult`|
|`Alias`|`MostRecentAliasResult`|
|`string[]`|`MostRecentListStringResult`|
|`bool[]`|`MostRecentListBoolResult`|
|`int[]`|`MostRecentListIntResult`|
|`float[]`|`MostRecentListFloatResult`|
|`Form[]`|`MostRecentListFormResult`|
|`[Label][]`|`MostRecentListLabelResult`|
|`Alias[]`|`MostRecentListAliasResult`|

`[Label]` is not a CreationKit mapped type but refers to `goto` labels for use in SLTScripts, allowing you to treat them as returnable/settable types.

`Form` refers to any CreationKit type derived from `Form` such as `ObjectReference`, `Actor`, `Quest`, and `Armor`.

`Alias` refers to any CreationKit type derived from `Alias` such as `ReferenceAlias`.

## Complete Example

The following two files represent a "complete" function library, in that it includes both the `-libraries.json` and the `.psc`. It includes a simple sample function for none, string, and bool[] types (i.e. return none, return an object, return a list), and some examples of handling several parameter situations (i.e. no parameters, fixed parameters, list parameters requiring casting, and optional parameters). It is given a very late priority since it is only introducing simple sample functions.

Making sure that sl_triggersCmd.psc is present in your Papyrus include path (header only is all that is needed) is the bare minimum required. If you wish to make use of e.g. sl_triggers.psc or sl_triggersStatics.psc, then header only versions of those will also need to be present during your Papyrus compile.

Then, in your mod, place the compiled `SLTRLibrary_CompleteSample.pex` you built into the `Scripts/` subfolder, and place `complete-sample-libraries.json` into the `SKSE/Plugins/sl_triggers/extensions/` subfolder.

`complete-sample-libraries.json:`
```
{
    "SLTRLibrary_CompleteSample" : 10000
}
```

`SLTRLibrary_CompleteSample.psc:`
```papyrus
;/
  return_none_parms_none
    returns: none
    parms: none
  
  Notes: Does no parameter checking, so technically it allows a user to provide arguments, but they will be ignored without warning.

  Examples could include:
    - a function to heal the player for a specific amount (there are no variables and no result needs to be reported)

/;
function return_none_parms_none (Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    Actor player = Game.GetPlayer()
    player.RestoreActorValue("Health", 100.0)

	CmdPrimary.CompleteOperationOnActor()
endfunction

;/
  return_string_parms_one_string
    returns: string
    parms: string

  Notes: Uses sl_triggersStatics function for parameter checking, to provide useful output during script execution.

  Examples could include:
    - a function to wrap a string in hyphens (i.e. turning "foo" into "-foo")

/;
function return_string_parms_one_string (Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    ; param.Length includes the function name itself
    ; we want exactly one parameter to be passed, so we want param.Length eq 2
    ; this convenience wrapper will print the current scriptname and line number along with an error message
    ; in case of the param.Length being incorrect
    if sl_triggersStatics.ParamLengthEQ(CmdPrimary, param.Length, 2)
        string arg = CmdPrimary.ResolveString(param[1])
        CmdPrimary.MostRecentStringResult = "-" + arg + "-"
    endif

	CmdPrimary.CompleteOperationOnActor()
endfunction

;/
  return_list_bool_parms_list_form
    returns: bool[]
    parms: Form[]
  
  Notes: Performs a cast for the argument because we receive Forms but need to work with Armors.

  Examples could include:
    - a function that, given an Armor[] (i.e. a list of Papyrus Armor objects), which may be sparsely
      populated (i.e. contain none/null values), return a same-sized bool[], set to true for each index
      where an Armor has non-zero Warm Rating

/;
function return_list_bool_parms_list_form (Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    if sl_triggersStatics.ParamLengthEQ(CmdPrimary, param.Length, 2)
        ; We have a Form[] because that's the closest we can get to receiving an Armor[]
        ; So we're going to have to iterate and cast
        Form[] armorForms = CmdPrimary.ResolveListForm(param[1])

        ; PapyrusUtils is a dependency, so let's make ourselves a bool[]
        bool[] results = PapyrusUtil.BoolArray(armorForms.Length)

        int i = armorForms.Length
        while i > 0
            i -= 1
            if armorForms[i]
                Armor theArmor = armorForms[i] as Armor
                if theArmor && theArmor.GetWarmthRating() > 0
                    results[i] = true
                endif
            endif
        endwhile

        CmdPrimary.MostRecentListBoolResult = results
    endif

	CmdPrimary.CompleteOperationOnActor()
endfunction

;/
  return_none_parms_one_int_optional_actor
    returns: none
    parms:  int - required
            Actor - optional
  
  Examples could include:
    - a function to give the indicated amount of gold to whichever Actor is specified
      or the Player if none is specified

/;
function return_none_parms_one_int_optional_actor (Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd

    ; We use a slightly different check here, verifying that the
    ; parameter list length (again, inclusive of the function name)
    ; is greater than 1 (i.e. at least 2, meaning it includes the first parameter)
    if sl_triggersStatics.ParamLengthGT(CmdPrimary, param.Length, 1)
        int amount = CmdPrimary.ResolveInt(param[1])
        ; set the default
        Actor theActor = Game.GetPlayer()
        if param.Length > 2
            theActor = CmdPrimary.ResolveActor(param[2])
        endif
        ; CmdPrimary contains a number of helper functions you may use
        Form gold = CmdPrimary.GetFormById("0xf")
        theActor.AddItem(gold, amount)
    endif

	CmdPrimary.CompleteOperationOnActor()
endfunction

```