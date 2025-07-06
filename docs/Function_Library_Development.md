## The Concept

Function libraries serve as a way to expand on the available functions in your SLT scripts.

For example, a typical script might look like this:

    ; I should have pointed out, .sltscript format allows comments
    item_add $system.self "skyrim.esm:15" 10 0   ; including on the same line, it just starts a comment to end of line
    goto there

    [here]
    item_add $system.self "skyrim.esm:15" 7 0
    goto finally

    [there]
    item_add $system.self "skyrim.esm:15" 11 0

    goto here

    [finally]

Strictly speaking, `item_add` is the only true "function" in this script, `goto` being a language construct. `item_add` is implemented in `sl_triggersCmdLibSLT.psc`. Suppose in your super cool new mod you want to do something which offers a Papyrus API call that will upgrade equipment somehow. Suppose you would like to have a script function, say `coolmod_item_upgrade` that calls that function. Without command libraries you would need to wait for the SLTR maintainer to add the feature and, assuming they do, hope they did it the way you wanted.

Function libraries offer a method of adding to the available functions without needing to get an update from SLT itself.

## The Pieces
There are two pieces to a function library: the .psc/.pex script, and the `-libraries.json` file.

### The `-libraries.json` file
First, let's have a look at the `-libraries.json` file. Here is the demo sample included in the source (in `anythingYouWantReallyButISuggestYouKeepItReasonableAndConsistent-libraries.json.rename-for-the-demo`):

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

CRITICAL: LOWER PRIORITIES RUN FIRST AND WIN OVER HIGHER PRIORITIES. Take it up with whomever made us feel like higher numbers are always "superior".

### The script
When SLT encounters a function in an SLT script, it will iterate, in priority sequence, all of the command libraries to look for the function; the first implementing library wins. This allows you to set up different libraries as overrides for other functions and why SLT itself is set at 0.

The source code includes a sample command library file, `DemoSLTLibraryScript.psc`. Here is the bare minimum for an SLT function:

    Function do_the_bare_minimum_with_hextun(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
        sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
        Debug.Notification("Hello from a function doing the bare minimum.")
    EndFunction

For SLT to be able to make use of your function, it must adhere to the following requirements:
- global
- no return type
- requires the signature (Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param)
  - Actor CmdTargetActor - the Actor the script was run on; usually this is the Actor the script
            is also affecting but that isn't necessary; however all scripts run on an Actor mechanically
  - ActiveMagicEffect _CmdPrimary - This is actually an sl_triggersCmd, which extends ActiveMagicEffect; you
            can see the cast on the first line of the function; this is what runs the script
            and maintains context for execution.
  - string[] param - the parameters used for the operation in the script, including the function name;
            so if your script had the line from above, 'av_mod $self Health 15', param would have
            length 4, and the values would be:
    - 0   av_mod
    - 1   $self
    - 2   Health
    - 3   15

Here is a longer example from the same demo file, including comments in-line:

            ;/
            The base SLT implementation does not support a command named "do_slt_demo_library_script_stuff",
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

                ; first we need to resolve the parameter to an Actor
                ; sl_triggersCmd.ResolveActor() will attempt to find the Actor based
                ; on the value provided. These are currently special vairable names
                ; but this feature could expand in future.
                Actor _theActor = CmdPrimary.ResolveActor(param[1])

                ; get the display name for later
                string _theDisplayName = _theActor.GetDisplayName() ; This is Creation Kit API stuff

                ; we want to print it to the console. Since PapyrusUtil is a requirement
                ; we have access to MiscUtil.PrintConsole()
                MiscUtil.PrintConsole("Demoing SLT: Targeted Actor with DisplayName(" + _theDisplayName + ")")

                ; and finally we want to "return" the name so the rest of the script has access to it
                ; to "return" it we have to provide it back to CmdPrimary so it can place it in the 
                ; correct context. CmdPrimary.MostRecentResult is how a function reports back its return
                ; value. It can be accessed later in the script with the special variable '$$', at
                ; least until another operation runs that changes the return value.
                CmdPrimary.MostRecentResult = _theDisplayName

                ; There are also
                ; CmdPrimary.MostRecentBoolResult
                ; CmdPrimary.MostRecentIntResult
                ; CmdPrimary.MostRecentFloatResult
                ; CmdPrimary.MostRecentFormResult
                ; While type conversions exist for several of these, it is best to try to be as accurate as possible with your return type
                ; Do not set a value if your function is not intended to return one.

                ; This is absolutely required at the end of any function you create. If you do not do this, bad things will happen.
                CmdPrimary.CompleteOperationOnActor()
            EndFunction

Compile this, place it in scripts, and place your `-libraries.json` file and you can start using your new functions in your SLT scripts. Distribute your .pex and `-libraries.json` to let others marvel at your brilliance. :)