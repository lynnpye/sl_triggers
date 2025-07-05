# SL Triggers Redux

# What Does It Do:
SLTR lets you run simple scripts without the need to compile and without worrying about Papyrus script dependencies or whether your script will build. SLTR comes with some scripts for you, thinks like giving yourself a little gold, healing yourself, giving yourself a drink. You can also write your own custom SLTScripts. And finally, you can set up triggers, ways to make SLTScripts run in response to game events, like on game load, on changing location, or even tied to custom keymappings of your choice. All of this is configurable via MCM or text files if you prefer.

It is ESL flagged to minimize impact on your load order and most dependencies are loaded dynamically, so aside from the requirements of SKSE and PapyrusUtils, everything else is optional depending on what functionality you want.

# More Details Please!
SL Triggers Redux (SLTR, though you may still see references to SLT) is, at its heart, a way to run various tasks in response to events in game. The original focus of SLTR was purely on the four basic SexLab events (Sex Start, Orgasm, Sex End, Separate Orgasm via SLSO), but the framework has been expanded to not be tied solely to SexLab events. In addition, out of the box, you can also set up hotkeys to run scripts on demand, set scripts up to run on the (in-game) hour, and even run scripts directly via console command.

These scripts are simple .sltscript (text) files with an easy to understand syntax and a number of examples available to work from. Scripts are comprised of commands. Commands can be things like "av_set" (to set an Actor Value) or syntactic commands like "goto" (to script execution to a different line). 

Additionally, more commands can be added as command libraries, to expand the capabilities of your scripts even further.

You don't have to program the scripts to use them. A selection is available for you to work with from the get-go, plus any you want to copy and modify, plus you can also share scripts with other SLT users. (I hold no copyright over any SLTScripts anyone creates, just so you know.)

# Speaking of Copyright and Licensing
All work associated with "SL Triggers Redux" aka "SLTR" aka "SLT" (in relation to it's origin) is derived from [the original, SL Triggers, by Fotogen](https://www.loverslab.com/files/file/8760-sl-triggersv12-2022-06-05/). I received approval to continue development. More info available on the [SLT Wiki](https://github.com/lynnpye/sl_triggers/wiki).

All other work that exists as part of this project as well as the associated SKSE C++ plugin project (when it's not hosted here) is and always will be [free and unencumbered released into the public domain](https://unlicense.org) or [MIT Licensed](https://opensource.org/license/mit) depending on the project and compatibility requirements.

# Installation:

If you have an older version (i.e. Fotogen's original) you will need a new save. Sorry. :(
I strongly recommend using a mod manager like ModOrganizer2.

Typical mod install into Data\ (again, if you aren't using a mod manager)

MCM is available to manage triggers and settings, but all options are also manageable through files.


# Requirements:

- SKSE
- PapyrusUtil
- (optional) SexLab Framework (if you want SexLab events and commands)
- (optional) A ConsoleUtil variant (I recommend Console Util Extended)  (if you want to execute Skyrim console commands in your scripts)
- (optional) MfgFix https://www.nexusmods.com/skyrimspecialedition/mods/11669 (if you want facial expression related commands in your scripts)


# About Performance:

Effort has been made to avoid scripts from stressing the system more than necessary, but there are still limitations. Each script will be run on an Actor in game (the Player or an NPC). Any one Actor can have no more than 10 scripts running on them at one time. Scripts can be long-running if you make them so, so be careful not to let things run away.

 
# Setting Things Up:

The MCM lists "extensions" on the left and their associated triggers and settings on the right. Each "extension" represents a set of triggers/events that you can add to and configure to run SLT scripts in response.

When you add a trigger, it will show up with it's configurable options. Each option represents a check that will be made when the selected event fires. If all the checks pass, the Actor being verified will have the script run on them.

You can also "soft delete" a trigger, marking it inactive until either you restore it or go in and physically remove the trigger file. Until restored it will remain inactive.

So take a SexLab event like an SLSO Orgasm (i.e. two actors having sex but only one of them orgasms). Here is how the condition checks would run. Note that this is specific to a SexLab event, which in context may have 1 or more actors involved. Other events (like hotkeys) do not logically have more than 1 actor involved.

- SexLab "On Separate Orgasm" event fires
- SexLab Extension (and any other listender) receives the event
- SLX then checks each of its triggers that match the "On Separate Orgasm" event
- For each trigger that matches
  - For each actor in the scene
    - Does the actor meet all of the conditions? If so, run the script

So even though actor 1 orgasmed, because of the nature of the event, all actors were checked for conditions and, based on those conditions, any of the actors might have had the script run on them. Or all of the actors. It depends on how you configure your trigger. For example if you set it for "Location = Outdoors" for a "On Separate Orgasm" event, both actors would be affected because both are outdoors at the time that either one of them had the separate orgasm.

The SexLab events, involving multiple actors, are a little more involved to setup, but all of the triggers should be easy to grasp after a bit.

# What Is Different From the Original?

Fotogen's original sl_triggers effort is great and still works well. Plus I had already added some of these features (like the Keymapping and Top of the Hour event handling) to it. So what else is new in this updated version?

- Extensible - It is very easy to expand functionality to add more operations to be available in your scripts with the new command libraries; Papyrus script developers can create their own .psc file with global functions to add new operations that will be available to any script run on the system
- New script format - The original format used JSON which is conveniently supported in the Skyrim environment but not convenient for development; the new .sltscript format is easier to read and works conveniently with syntax highlighting for some of the features
- More than SexLab - I know, SexLab is the SL in SLT; but the framework supports any event to fire a script
- ModEvent support for Script Execution - Mod authors can send mod events with a script name and SLT will run the script on the targeted Actor (or the Player if no target is available)
- API support - You can also access the same features through an API if you prefer
- Console command support - Some features available from the console