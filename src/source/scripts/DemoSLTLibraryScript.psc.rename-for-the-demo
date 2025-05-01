scriptname DemoSLTLibraryScript

;/
This script, although part of the SLT source, is here purely for demonstration
purposes for how the library extension system works.

If you peek into sl_triggersCmdLibCore, SexLab, and SLT, you will see a bunch of 
global functions corresponding with the various operations you can
perform in script. If you then take a look in SKSE/Plugins/extensions/ you will
find some files named *-libraries.json

Each *-libraries.json has a very simple format:

{
    "scriptname1" : priority,
    "scriptname2" : priority
}

Where "scriptname1" and "scriptname2" refer to scripts, like this one,
that you can write, compile, and share or just drop it into your own Scripts folder.
The *-libraries.json file tells SLT of its existence.

The priority number is a signed integer, where lower is ... um... higher. I iterate
from the lowest priority to highest priority, so the first one to respond to a function
name wins. Thus, lower is better. 

0 (zero) is a "baseline" of sorts. The SLT main implementation is at priority 0. 
This allows you to override existing functions whether to patch them or to enhance
the functionality. For example, the SexLab library is at -500 because it
overrides one or two of the base SLT implementations and I wanted to leave plenty
of room for others to choose priorities in between. The Core library is at 1000 because
it only adds a couple of highly specific functions, so no need to try to override anything.

When an SLT script is run, it will have lines like this:

    av_mod $self Health 15

SLT will search each library for a function named av_mod and run it with appropriate
context. You will be given an instance of sl_triggersCmd, which contains functions
to interact with the rest of SLT. That is, it provides methods to look up variable values,
set them, perform certain core SLT functions, and so on. The existing sl_triggersCmdLib*.psc
files are rife with examples of how these functions can be constructed, but being a
demo, let's have some examples.

To start with, here is the barest minimum of a library function. Let's name it appropriately.
/;

function DebMsg(string msg) global
	MiscUtil.WriteToFile("data/skse/plugins/sl_triggers/debugmsg.log", msg + "\n", true)
	MiscUtil.PrintConsole(msg)
	;Debug.Notification(msg)
endfunction

Function do_the_bare_minimum_with_hextun(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
    DebMsg("do_the_bare_minimum_with_hextun")
	sl_triggersCmd CmdPrimary = _CmdPrimary as sl_triggersCmd
    Debug.Notification("Hello from a function doing the bare minimum.")
EndFunction

;/
The requirements:
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
                0   av_mod
                1   $self
                2   Health
                3   15
- technically the cast on the first line is not necessary *if* you are not going to make use
            of the CmdPrimary
/;

;/
How about another example, this time one that actually tries to do something.
The base SLT implementation does not support a command named "do_slt_demo_library_script_stuff",
so let's rectify that. Let's have it accept an Actor as the first parameter and it will
print the Actor's display name to console. Finally it is going to "return" the actor's name
for later functions in the script to make use of (if they choose to).

So in param we would expect something like:
    0   do_slt_demo_library_script_stuff    ; I can't believe I made myself type that again
    1   $player                             ; note that this could also be values like $self, and $actor
$player is a special variable that always resolves to the Player. In this case, even
if CmdTargetActor were pointing to Ancano, $player would still resolve to the player.
/;
Function do_slt_demo_library_script_stuff(Actor CmdTargetActor, ActiveMagicEffect _CmdPrimary, string[] param) global
    DebMsg("do_slt_demo_library_script_stuff")
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

    ; .. oh, let's also put the name into a variable and a global variable.
    ; script variables are of the format '$#' and '$g#' for globals.
    ; Local variables do not live beyond the lifetime of the script and
    ; are not visible outside of the script.
    ; Global variables remain beyond the script. They can be used to
    ; communicate between scripts.

    ; this would be atypical, btw... local variables (e.g. $2, $83)
    ; are usually set and fetched by the script author. Changing them
    ; inside the library should be a fairly rare occurrence or should
    ; be well commented.
    CmdPrimary.vars_set(23, _theDisplayName)

    ; This would be a bit more likely, and only if it is commented
    ; clearly. But this would be how two scripts could communicate
    ; with a dropbox style approach, using well known global var indexes.
    CmdPrimary.globalvars_set(84, _theDisplayName)
EndFunction

;/
Now if we place a file named something like:
    anythingYouWantReallyButISuggestYouKeepItReasonableAndConsistent-libraries.json
with contents of:

{
    "DemoSLTLibraryScript" : 10000
}

Then any script run in that instance of SLT would be able to 
recognize and execute commands of the form:

    do_the_bare_minimum_with_hextun

and:

    do_slt_demo_library_script_stuff  $player

and voila, new functions for your scripts. :)
/;